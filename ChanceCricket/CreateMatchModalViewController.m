//
//  CreateMatchModalViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateMatchModalViewController.h"
#import "Match+Factory.h"

@interface CreateMatchModalViewController ()

@property (nonatomic) BOOL isMatchReady;

@end

@implementation CreateMatchModalViewController

#define DEFAULT_SELECT_TEAM_CELL_TEXT @"Please select a team"

@synthesize isMatchReady = _isMatchReady;
@synthesize navigationBar = _navigationBar;
@synthesize selectedIndexPath = _selectedIndexPath;
@synthesize homeTeamCell = _homeTeamCell;
@synthesize awayTeamCell = _awayTeamCell;
@synthesize homeTeam = _homeTeam;
@synthesize awayTeam = _awayTeam;
@synthesize delegate = _delegate;
@synthesize teamToExcludeFromSelection = _teamToExcludeFromSelection;

- (NSUInteger)numberOfTeamsToSelect {
    NSUInteger nTeamsToSelect = 1;
    return nTeamsToSelect;
}

- (NSArray *) teamsToExcludeFromSelection {
    
    NSArray *teamToExclude = self.teamToExcludeFromSelection ? [NSArray arrayWithObject:self.teamToExcludeFromSelection] : [[NSArray alloc] init];
    
    return teamToExclude;
}

- (void) gotoMatch:(id)sender {
//    [MatchDatabase getDatabaseDocumentFromRequester:self];
    [MatchDatabase openFile:DOCUMENT_EXHIBITION_MATCHES usingBlock:^(UIManagedDocument *database) {
        Match *match = [Match createMatchWithHomeTeam:self.homeTeam andAwayTeam:self.awayTeam inContext:database.managedObjectContext];
        
        [MatchDatabase saveDatabase:database usingCompletionBlock:^(UIManagedDocument *database) {
            [self.delegate gotoMatch:match.matchID];
        }];
    }];
}

- (void) togglePlayMatchButtonVisible {
    UINavigationItem *navigationItem = [self.navigationBar.items objectAtIndex:0];
    
    if(self.isMatchReady && !navigationItem.rightBarButtonItem){
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(gotoMatch:)];
        navigationItem.rightBarButtonItem = doneButton;
    }else{
        if(navigationItem.rightBarButtonItem) navigationItem.rightBarButtonItem = nil; 
    }
}

- (void) setIsMatchReady:(BOOL)isMatchReady {
    
    _isMatchReady = isMatchReady;
    
//    NSLog(@"is Match Ready: %@", _isMatchReady ? @"YES" : @"NO");
    [self togglePlayMatchButtonVisible];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateCellLabels];
}

- (IBAction)cancelButtonPress:(UIBarButtonItem *)sender {
    [[self presentingViewController] dismissModalViewControllerAnimated:YES];
}

- (void) resetCell:(UITableViewCell *)cellToReset {
    if([cellToReset isEqual:self.homeTeamCell]) {
        self.homeTeam = nil;
    }else{
        self.awayTeam = nil;
    }
}

- (void) validateMatchReadyWithFocusedCell:(UITableViewCell *)focusedCell {
    
//    NSLog(@"Home Team Name: %@, Away Team Name: %@", self.homeTeam.teamName, self.awayTeam.teamName);
    
    if(self.homeTeam && self.awayTeam && (![self.homeTeam.teamName isEqualToString:self.awayTeam.teamName])){
        // we're good to go, so reveal the play button
        self.isMatchReady = YES;
        return;
    }
    
    if([self.homeTeam.teamName isEqualToString:self.awayTeam.teamName]) [self resetCell:[focusedCell isEqual:self.homeTeamCell] ? self.awayTeamCell : self.homeTeamCell];
     
    self.isMatchReady = NO;
    
}

- (void) updateCellLabels {
    self.homeTeamCell.textLabel.text = self.homeTeam ? self.homeTeam.teamName : DEFAULT_SELECT_TEAM_CELL_TEXT;
    self.awayTeamCell.textLabel.text = self.awayTeam ? self.awayTeam.teamName : DEFAULT_SELECT_TEAM_CELL_TEXT;

}

- (void) teamSelectionComplete:(NSArray *)teams {
    
    Team *team = [teams lastObject];
    
    [self dismissModalViewControllerAnimated:YES];
    
    UITableViewCell *focusedCell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
    
    if([focusedCell isEqual:self.homeTeamCell]){
        self.homeTeam = team;
    }else {
        self.awayTeam = team;
    }
    
    [self validateMatchReadyWithFocusedCell:focusedCell];
    [self updateCellLabels];
    
}

- (void)viewDidUnload
{
    [self setHomeTeamCell:nil];
    [self setAwayTeamCell:nil];
    [self setNavigationBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIndexPath = indexPath;
    
    [self openTeamSelectionModal];
}

- (void) openTeamSelectionModal {
    
    UITableViewCell *focusedCell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
    self.teamToExcludeFromSelection = [focusedCell isEqual:self.homeTeamCell] ? self.homeTeam : self.awayTeam;
    
    TeamSelectionTableViewController *teamSelectTVC = [[TeamSelectionTableViewController alloc] init];
    teamSelectTVC.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:teamSelectTVC];
    [self presentViewController:navigationController animated:YES completion:^{}];
    
    NSLog(@"Open Selection Modal");
}

@end
