//
//  TournamentMatchCentreViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "TournamentMatchCentreViewController.h"
#import "TournamentCentralModel.h"

@interface TournamentMatchCentreViewController ()

@end

@implementation TournamentMatchCentreViewController

@synthesize tournamentMatch = _tournamentMatch;
@synthesize delegate = _delegate;
@synthesize homeTeamLabel = _homeTeamLabel;
@synthesize awayTeamLabel = _awayTeamLabel;
@synthesize matchLabel = _matchLabel;
@synthesize actionButton = _actionButton;
@synthesize targetAction = _targetAction;
@synthesize viewMatchButton = _viewMatchButton;
@synthesize matchProgressLabel = _matchProgressLabel;

#define GOTO_MATCH_SEGUE_ID @"GotoMatchSegue"

- (NSString *) getFilenameWhereMatchExistsMatchVC:(MatchViewController *)matchVC {
    NSLog(@"getFilenameWhereMatchExistsMatchVC: %@", DOCUMENT_TOURNAMENTS);
    return DOCUMENT_TOURNAMENTS;
}

- (TournamentMatch *) tournamentMatch {
    return [self.delegate selectTournamentMatchForMatchCentre:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTournamentUpdate:) name:TOURNAMENT_UPDATED object:nil];
}

- (void) onTournamentUpdate:(NSNotification *)notification {
    
    NSLog(@"Tournament Update");
    [self setupView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupView];
}

- (void) setupView {
    
    self.homeTeamLabel.text = self.tournamentMatch.homeSeed.tournamentTeam.team.teamShortName;
    self.awayTeamLabel.text = self.tournamentMatch.awaySeed.tournamentTeam.team.teamShortName;
    self.matchLabel.text = [NSString stringWithFormat:@"%@ Match %@", self.tournamentMatch.round.tournamentRoundName,self.tournamentMatch.matchNumber];
    self.matchProgressLabel.text = [self.tournamentMatch.match matchSummary];
    [self validateActionButton];
}

- (BOOL) matchContainsUserTeam {
    
    BOOL isUserTeam = YES;
    TournamentTeam *userTeam = self.tournamentMatch.round.tournament.userTournamentTeam;        
    if(![self.tournamentMatch.homeSeed.tournamentTeam isEqual:userTeam] && 
       ![self.tournamentMatch.awaySeed.tournamentTeam isEqual:userTeam]) isUserTeam = NO;
    
    return isUserTeam;
}

- (void) setTargetAction:(id<TargetActionProtocol>)targetAction withText:(NSString *)text {
    self.targetAction = targetAction;
    self.actionButton.titleLabel.textAlignment = UITextAlignmentCenter;
    [self.actionButton setTitle:text forState:UIControlStateNormal];
}

- (void) validateActionButton {
    
    // if user team in match
    Match *match = self.tournamentMatch.match;
    
    NSLog(@"Match State: %@", match.state);
    
    if([self matchContainsUserTeam]){
        if([match.state isEqualToString:MATCH_STATE_SCHEDULED]) {
            
            [self setTargetAction:[[SimulateMatchTargetAction alloc] initWithTournamentMatchCentreVC:self] withText:@"Simulate User Match"];
//            [self setTargetAction:[[GotoMatchTargetAction alloc] initWithSegueID:GOTO_MATCH_SEGUE_ID forViewController:self] withText:@"Start Match"];
            
        }else if([match.state isEqualToString:MATCH_STATE_IN_PROGRESS]) { 
            
            [self setTargetAction:[[GotoMatchTargetAction alloc] initWithSegueID:GOTO_MATCH_SEGUE_ID forViewController:self] withText:@"Continue"];
            
        }else if ([match.state isEqualToString:MATCH_STATE_COMPLETED]) {
            
            [self gotoNextMatch];
        }
    } else {
        if([match.state isEqualToString:MATCH_STATE_SCHEDULED] ||
           [match.state isEqualToString:MATCH_STATE_IN_PROGRESS]) {

            [self setTargetAction:[[SimulateMatchTargetAction alloc] initWithTournamentMatchCentreVC:self] withText:@"Simulate Match"];
            
        }else if ([match.state isEqualToString:MATCH_STATE_COMPLETED]) {
            
            [self gotoNextMatch];
        } 
    }
    
    self.viewMatchButton.hidden = ![match.state isEqualToString:MATCH_STATE_COMPLETED];
}

- (void) gotoNextMatch {
    
    // validation of the next reuired action
    NSLog(@"Next Match is valid: %@ vs %@", [self.tournamentMatch.round getNextMatch].homeSeed.tournamentTeam.team.teamShortName, [self.tournamentMatch.round getNextMatch].awaySeed.tournamentTeam.team.teamShortName);
    NSLog(@"Next Round is valid: %@", [self.tournamentMatch.round.tournament getNextRound].tournamentRoundName);
    // goto next match
    
    // if next match 
    if([self.tournamentMatch.round getNextMatch]){
        // set this as the next match in the model?
        [self setTargetAction:[[GotoNextScheduledMatchTargetAction alloc] initWithTournamentMatchCentreVC:self] withText:@"Goto Next Match"];
    }else if ([self.tournamentMatch.round.tournament getNextRound]) {
        // set this as the next round in the model and call this again
        [self setTargetAction:[[GotoNextRoundTargetAction alloc] initWithTournamentMatchCentreVC:self] withText:@"Goto Next Round"];
    }else {
        // tournament is complete, there are no more matches to be played
        [self.actionButton removeFromSuperview];
        self.actionButton = nil;
        self.targetAction = nil;
    }
}

- (IBAction)onActionButtonPress:(id)sender { 
    if(self.targetAction) [self.targetAction invokeAction];
}

- (IBAction)onViewMatchPress:(id)sender {
    id <TargetActionProtocol> gotoMatchInvocator = [[GotoMatchTargetAction alloc] initWithSegueID:GOTO_MATCH_SEGUE_ID forViewController:self];
    [gotoMatchInvocator invokeAction];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.destinationViewController isKindOfClass:[MatchViewController class]]){
        MatchViewController *matchVC = (MatchViewController *)segue.destinationViewController;
        matchVC.delegate = self;
        matchVC.matchID = self.tournamentMatch.match.matchID;
    }
}

- (void) matchVC:(MatchViewController *)matchVC didFinish:(Match *)match {
    // validate tournament
        // if these is a next match in the current round, set it to that
        // if not see if there is a next round to access and set that up parsing it correctly
        // if not then we have reached the end of the tournament
}

- (void)viewDidUnload {
    [self setHomeTeamLabel:nil];
    [self setAwayTeamLabel:nil];
    [self setMatchLabel:nil];
    [self setActionButton:nil];
    [self setViewMatchButton:nil];
    [self setMatchProgressLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
