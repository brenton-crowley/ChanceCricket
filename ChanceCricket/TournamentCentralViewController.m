//
//  TouramentCentralViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "TournamentCentralViewController.h"

@interface TournamentCentralViewController ()

@end

@implementation TournamentCentralViewController

@synthesize model = _model;
@synthesize tournamentID = _tournamentID;

- (TournamentMatch *)selectTournamentMatchForMatchCentre:(TournamentMatchCentreViewController *)matchCentre {
    return self.model.tournament.currentRound.currentTournamentMatch;
}

- (void) gotoNextSchedluedMatchForMatchCentre:(TournamentMatchCentreViewController *)matchCentre {
    [self.model setCurrentMatchToNextScheduledMatch];
}

- (void) gotoNextRoundForMatchCentre:(TournamentMatchCentreViewController *)matchCentre {
    [self.model setCurrentRoundToNextRound];
}

- (void) simulateCurrentMatch:(TournamentMatchCentreViewController *)matchCentre {
    [self.model simulateCurrentMatch];
}

- (TournamentRound *)selectTournamentRoundForStandings:(TournamentStandingsViewController *)tournamentStandings {
    return self.model.tournament.currentRound;
}

- (Tournament *)selectTournamentForFixtures:(TournamentFixturesViewController *)tournamentFixtures {
    return self.model.tournament;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Will initialise the tournament in the model and prep everything
    [self.model initTournament:self.tournamentID];
    
    // Init Delegates
    for (int i = 0; i < self.viewControllers.count; i++) {
        id viewController = [self.viewControllers objectAtIndex:i];
        if([viewController respondsToSelector:@selector(setDelegate:)]) [viewController setDelegate:self];
    }
    self.delegate = self;
}


- (TournamentCentralModel *) model {
    if(!_model) _model = [[TournamentCentralModel alloc] init];
    return _model;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
