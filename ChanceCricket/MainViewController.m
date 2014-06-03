//
//  MainViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize matchID = _matchID;
@synthesize tournamentID = _tournamentID;
@synthesize resumeMatchButton = _resumeMatchButton;
@synthesize resumeTournamentButton = _resumeTournamentButton;

- (void) setResumeButtonEnabled {
    
    BOOL matchIsEnabled = self.matchID ? YES : NO;
    BOOL tournamentIsEnabled = self.tournamentID ? YES : NO;
    
    [self.resumeMatchButton setEnabled:matchIsEnabled];
    self.resumeMatchButton.alpha = matchIsEnabled ? 1 : 0.4;
    
    [self.resumeTournamentButton setEnabled:tournamentIsEnabled];
    self.resumeTournamentButton.alpha = tournamentIsEnabled ? 1 : 0.4;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setResumeButtonEnabled];
}

- (void) viewDidLoad {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.matchID = [userDefaults valueForKey:SETTINGS_LAST_MATCH_ID];
    self.tournamentID = [userDefaults valueForKey:SETTINGS_LAST_TOURNAMENT_ID];
    
//    if(self.tournamentID) [self performSegueWithIdentifier:@"GotoTournamentSegue" sender:self];
    if(self.matchID) [self performSegueWithIdentifier:@"segueToMatchVC" sender:self];
}

- (IBAction)onResumeMatchSelect:(id)sender {
    [self gotoMatch:self.matchID];
}

- (void) matchSelectionComplete:(id)sender withMatchID:(NSString *)matchID {
    [self gotoMatch:matchID];
}

- (void) gotoMatch:(NSString *)matchID {
    
    self.matchID = matchID;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setValue:self.matchID forKey:SETTINGS_LAST_MATCH_ID];
    
    [self dismissModalViewControllerAnimated:YES];
    [self performSegueWithIdentifier:@"segueToMatchVC" sender:self];
    
    [userDefaults synchronize];
    NSLog(@"User Defaults last matchID: %@", [userDefaults valueForKey:SETTINGS_LAST_MATCH_ID]);
}

- (void)matchVC:(MatchViewController *)matchVC didFinish:(Match *)match {
    NSLog(@"Match Did Finish");
}

- (void)tournamentTVC:(CreateTournamentTableViewController *)tournamentTVC createdTournamentID:(NSString *)tournamentID {
    
    [self dismissModalViewControllerAnimated:YES];
    
    self.tournamentID = tournamentID;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setValue:self.tournamentID forKey:SETTINGS_LAST_TOURNAMENT_ID];
    [userDefaults synchronize];
    
    [self performSegueWithIdentifier:@"GotoTournamentSegue" sender:self];
    NSLog(@"Tournament ID: %@ - Segue To Tournament Central", self.tournamentID);
}

- (NSString *) getFilenameWhereMatchExistsMatchVC:(MatchViewController *)matchVC {
    return DOCUMENT_EXHIBITION_MATCHES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Will Transition to match screen
    if ([segue.destinationViewController isKindOfClass:[MatchViewController class]]) {   
        MatchViewController *matchVC = (MatchViewController *)segue.destinationViewController;
//        NSLog(@"Set the match with match ID: %@", self.matchID);
        matchVC.delegate = self;
        matchVC.matchID = self.matchID;
    }
    
    // Will Transition to Create Match Modal
    if ([segue.destinationViewController isKindOfClass:[CreateMatchModalViewController class]]) {   
        CreateMatchModalViewController *createMatchVC = (CreateMatchModalViewController *)segue.destinationViewController;
        createMatchVC.delegate = self;
    }
    
    // Will Transition to Select Match Modal
    if ([segue.destinationViewController isKindOfClass:[MatchSelectionTableViewController class]]) {   
        MatchSelectionTableViewController *selectMatchVC = (MatchSelectionTableViewController *)segue.destinationViewController;
        selectMatchVC.delegate = self;
    }
    
    // Will Transition to Tournament Creation
    if([segue.destinationViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *navigationController = (UINavigationController *)segue.destinationViewController;
        
        if ([[navigationController.viewControllers objectAtIndex:0] isKindOfClass:[CreateTournamentTableViewController class]]) {   
            CreateTournamentTableViewController *createTournamentTVC = (CreateTournamentTableViewController *)[navigationController.viewControllers objectAtIndex:0];
            NSLog(@"Seguing!");
            createTournamentTVC.delegate = self;
        }
    }
    
    // Will Transition to Tournament Central
    if ([segue.destinationViewController isKindOfClass:[TournamentCentralViewController class]]) {   
        TournamentCentralViewController *tournamentCentralTVC = (TournamentCentralViewController *)segue.destinationViewController;
        NSLog(@"Goto Tournament Central");
        tournamentCentralTVC.tournamentID = self.tournamentID;
        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setResumeMatchButton:nil];
    [self setResumeTournamentButton:nil];
    [super viewDidUnload];
}
@end
