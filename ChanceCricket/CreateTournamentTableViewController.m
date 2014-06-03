//
//  CreateGroupsTableViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CreateTournamentTableViewController.h"
#import "TeamSelectionTableViewController.h"

@interface CreateTournamentTableViewController ()

@property (nonatomic, strong) TableViewSectionCellData *addTeamsCellData;

@end

@implementation CreateTournamentTableViewController

@synthesize addTeamsCellData = _addTeamsCellData;
@synthesize sections = _sections;
@synthesize userSection = _userSection;
@synthesize teamsSection = _teamsSection;
@synthesize selectedTeams = _selectedTeams;
@synthesize userTeam = _userTeam;
@synthesize delegate = _delegate;

#define ADD_TEAMS_TEXT @"Add Teams"
#define N_TOTAL_TEAMS 12

- (IBAction)onCancelPress:(UIBarButtonItem *)sender {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self addToolbar];
}

- (void) addToolbar {
    
    self.navigationController.toolbarHidden = NO;
    
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *addTeamItem;
    
    addTeamItem = self.selectedTeams.count != N_TOTAL_TEAMS ? [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddMoreTeamsPressed:)] : nil; 
    
    addTeamItem.style = UIBarButtonItemStyleBordered;
    
    NSArray *items = [NSArray arrayWithObjects:self.editButtonItem, flexibleSpaceItem, addTeamItem, nil];
    
    self.toolbarItems = items;
    
}

- (void) validateNavigationBar {
      
    if((self.selectedTeams.count == N_TOTAL_TEAMS && self.userTeam) && !self.navigationItem.rightBarButtonItem && ![self.tableView isEditing]){
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Begin" style:UIBarButtonItemStyleDone target:self action:@selector(setupTournament:)];
        self.navigationItem.rightBarButtonItem = doneButton;
    }else{
        if((self.selectedTeams.count == 0 || !self.userTeam) || [self.tableView isEditing]) self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void) setupTournament:(id)sender {

    [MatchDatabase openFile:DOCUMENT_TOURNAMENTS usingBlock:^(UIManagedDocument *database) {
        Tournament *tournament = [Tournament createTournamentWithTeams:self.selectedTeams setUserTeam:self.userTeam inContext:database.managedObjectContext];
        [MatchDatabase saveDatabase:database usingCompletionBlock:^(UIManagedDocument *database){
            [self.delegate tournamentTVC:self createdTournamentID:tournament.tournamentID];
        }];
    }];
}

- (void) setUserTeam:(Team *)userTeam {
    _userTeam = userTeam;
    [self updateUserTeam];
}

- (void) updateUserTeam {
    
    if(self.userTeam){
        self.userSection = [[TableViewSection alloc] initWithTitle:@"Player Team" andSectionCellDatas:[NSMutableArray arrayWithObject:[[TitleSectionCellData alloc] initWithTitle:self.userTeam.teamName]]]; 
    }else{
        self.userSection = [[TableViewSection alloc] initWithTitle:@"Player Team" andSectionCellDatas:[NSMutableArray arrayWithObject:[[TitleSectionCellData alloc] initWithTitle:@"Please select a team..."]]];
    }    
}

- (NSMutableArray *) selectedTeams {
    if(!_selectedTeams) _selectedTeams = [[NSMutableArray alloc] init];
    return _selectedTeams;
}

- (NSUInteger)numberOfTeamsToSelect {
    NSUInteger nTeamsToSelect = N_TOTAL_TEAMS - self.selectedTeams.count;    
    return nTeamsToSelect;
}

- (NSArray *) teamsToExcludeFromSelection {
    NSMutableArray *teamsToExclude = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.teamsSection.sectionCellDatas.count; i++) {
        TitleSectionCellData *titleSectionCellData = [self.teamsSection.sectionCellDatas objectAtIndex:i];
        [teamsToExclude addObject:titleSectionCellData.cellTitle];
    }
    return [self.selectedTeams copy];
}

- (void) teamSelectionComplete:(NSArray *)teams {

    [self.selectedTeams addObjectsFromArray:teams];
    
    [self dismissModalViewControllerAnimated:YES];
    [self.tableView reloadData];
    
    [self addToolbar];
    
}

- (void) onAddMoreTeamsPressed:(id)sender {
    
    TeamSelectionTableViewController *teamSelectTVC = [[TeamSelectionTableViewController alloc] init];
    teamSelectTVC.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:teamSelectTVC];
    [self.navigationController presentViewController:navigationController animated:YES completion:^{}];

}

- (TableViewSection *) userSection {
    if(!_userSection)_userSection = [[TableViewSection alloc] initWithTitle:@"Player Team" andSectionCellDatas:[NSMutableArray arrayWithObject:[[TitleSectionCellData alloc] initWithTitle:@"None selected"]]];
    return _userSection;
}

- (TableViewSectionCellData *) addTeamsCellData{
    if(!_addTeamsCellData) _addTeamsCellData = [[AddTeamsCellData alloc] init];
    return _addTeamsCellData;
}

- (TableViewSection *) teamsSection {
    _teamsSection = [[TableViewSection alloc] initWithTitle:@"World T20 Teams"];
    for (Team *team in self.selectedTeams) {
        [_teamsSection addSectionCellData:[[TitleSectionCellData alloc] initWithTitle:team.teamName]];
    }
    
    [self validateNavigationBar];
    return _teamsSection;
}

- (NSArray *) sections {
    NSMutableArray *tempSections = [[NSMutableArray alloc] init];
    if (self.userSection) [tempSections addObject:self.userSection];
    [tempSections addObject:self.teamsSection];
    _sections = [tempSections copy];
    return _sections;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:YES];
    
    [self validateNavigationBar];
    
    if(!editing){
        [self addToolbar];
        [self.tableView reloadData];
    }
}

- (void)tableView:(UITableView *)tv commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Team *teamToRemove = [self.selectedTeams objectAtIndex:indexPath.row];
        
        if(teamToRemove.teamName == self.userTeam.teamName) self.userTeam = nil;
        
        [self.selectedTeams removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self updateUserTeam];
        
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        [self onAddMoreTeamsPressed:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // number of groups specified in round one of the tournament groups
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    TableViewSection *tableViewSection = [self.sections objectAtIndex:section];
    
    return tableViewSection.sectionCellDatas.count;
}

- (BOOL) displayReorderControl:(TableViewSectionCellData *)cellData {
    
    if([cellData isEqual:self.addTeamsCellData]) return NO;
    
    return self.tableView.isEditing;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewSection *tableViewSection = [self.sections objectAtIndex:indexPath.section];
    TableViewSectionCellData *tableViewSectionCellData = [tableViewSection.sectionCellDatas objectAtIndex:indexPath.row];

    NSString *CellIdentifier = tableViewSectionCellData.cellReuseID ? tableViewSectionCellData.cellReuseID : @"GroupCreationCell";    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.showsReorderControl = [self displayReorderControl:tableViewSectionCellData];
    
    if(indexPath == [NSIndexPath indexPathForRow:0 inSection:0]) [cell setUserInteractionEnabled:NO];
    
    [tableViewSectionCellData renderCell:cell];
    
    if([tableViewSection.sectionTitle isEqual:self.teamsSection.sectionTitle]){
        Team *teamFromIndex = [self.selectedTeams objectAtIndex:indexPath.row];
        cell.accessoryType = self.userTeam == teamFromIndex ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    }
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
    TableViewSection *tableViewSection = [self.sections objectAtIndex:section];
    
    return tableViewSection.sectionTitle;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewSection *tableViewSection = [self.sections objectAtIndex:indexPath.section];
    TableViewSectionCellData *tableViewSectionCellData = [tableViewSection.sectionCellDatas objectAtIndex:indexPath.row];
    
    return ![tableViewSectionCellData isEqual:self.addTeamsCellData] ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleInsert;

}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    Team *movingTeam = [self.selectedTeams objectAtIndex:fromIndexPath.row];    
    [self.selectedTeams removeObject:movingTeam];
    [self.selectedTeams insertObject:movingTeam atIndex:toIndexPath.row];

}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)targetIndexPath {  
       
    if (sourceIndexPath.section != targetIndexPath.section) {
        NSInteger row = 0;
        if (sourceIndexPath.section < targetIndexPath.section) {
            row = [self tableView:tableView numberOfRowsInSection:sourceIndexPath.section] - 1;
        }
        return [NSIndexPath indexPathForRow:row inSection:sourceIndexPath.section];     
    }
    
    return targetIndexPath;
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *tableViewSection = [self.sections objectAtIndex:indexPath.section];
    TableViewSectionCellData *tableViewSectionCellData = [tableViewSection.sectionCellDatas objectAtIndex:indexPath.row];
    
    return ![tableViewSectionCellData isEqual:self.addTeamsCellData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *tableViewSection = [self.sections objectAtIndex:indexPath.section];
//    TableViewSectionCellData *tableViewSectionCellData = [tableViewSection.sectionCellDatas objectAtIndex:indexPath.row];
    
    return ![tableViewSection isEqual:self.userSection];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewSection *tableViewSection = [self.sections objectAtIndex:indexPath.section];
    TableViewSectionCellData *tableViewSectionCellData = [tableViewSection.sectionCellDatas objectAtIndex:indexPath.row];
    
    if([tableViewSectionCellData isEqual:self.addTeamsCellData]){
        [self onAddMoreTeamsPressed:nil];
    }
    
    if([tableViewSection.sectionTitle isEqualToString:self.teamsSection.sectionTitle]){
        NSLog(@"Length of Selected teams: %i", self.selectedTeams.count);
        Team *teamFromIndex = [self.selectedTeams objectAtIndex:indexPath.row];
        NSLog(@"Selected Team: %@", teamFromIndex.teamName);
        self.userTeam = teamFromIndex;
        
//        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, [NSIndexPath indexPathForRow:0 inSection:0],nil] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
    }
}

@end
