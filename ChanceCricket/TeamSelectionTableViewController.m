//
//  TeamSelectionTableViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 16/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "TeamSelectionTableViewController.h"

@interface TeamSelectionTableViewController ()

@end

@implementation TeamSelectionTableViewController

@synthesize selectedCell = _selectedCell;
@synthesize selectedTeam = _selectedTeam;
@synthesize navigationBar = _navigationBar;
@synthesize delegate = _delegate;
@synthesize excludedTeam = _excludedTeam;
@synthesize selectedTeams = _selectedTeams;

- (void) viewDidLoad {
    self.navigationItem.title = @"Team Selection";
    
    NSLog(@"Number of teams to select: %i", [self.delegate numberOfTeamsToSelect]); 
    NSLog(@"Number of teams to exclude: %i", [self.delegate teamsToExcludeFromSelection].count);
    
    if(!self.navigationItem.leftBarButtonItem){
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPress:)];
        self.navigationItem.leftBarButtonItem = cancelButton;
    }
    
//    [MatchDatabase getDatabaseDocumentFromRequester:self];
    
    [MatchDatabase openFile:DOCUMENT_ROOT usingBlock:^(UIManagedDocument *database) {
        [self setupFetchedResultsController:database.managedObjectContext];
    }];
    
    [self addToolbar];
}

- (void) addToolbar {
    
    self.navigationController.toolbarHidden = NO;
    
    UIBarButtonItem *autofillItem = [[UIBarButtonItem alloc] initWithTitle:@"Autofill" style:UIBarButtonItemStyleBordered target:self action:@selector(onAutofillPress:)];
    UIBarButtonItem *clearItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(onClearPress:)];
    UIBarButtonItem *flexibleSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *items = [NSArray arrayWithObjects:clearItem, flexibleSpaceItem, autofillItem, nil];
    
    self.toolbarItems = items;
    
}

- (void) onAutofillPress:(id)sender {
    
    NSLog(@"AutoFill with number of teams: %i", [self.delegate numberOfTeamsToSelect]);
    
    NSInteger i = 0;
    while (self.selectedTeams.count != [self.delegate numberOfTeamsToSelect]) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        Team *teamFromIndex = [self.fetchedResultsController objectAtIndexPath:indexPath];
        if(![self.selectedTeams containsObject:teamFromIndex]) [self.selectedTeams addObject:teamFromIndex];
        i++;
    }
    
    [self.tableView reloadData];
    [self validateNavigationBar];
}

- (void) onClearPress:(id)sender {
    
    self.selectedTeams = [[NSMutableArray alloc] init];
    
    [self.tableView reloadData];
    [self validateNavigationBar];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}

- (NSMutableArray *) selectedTeams {
    if(!_selectedTeams) _selectedTeams = [[NSMutableArray alloc] init]; 
    return _selectedTeams;
}

- (void) setExcludedTeam:(NSString *)excludedTeam{
    _excludedTeam = excludedTeam;
    
//    NSLog(@"Set Excluded Team: %@", _excludedTeam);
    
//    [MatchDatabase getDatabaseDocumentFromRequester:self];
    [MatchDatabase openFile:DOCUMENT_ROOT usingBlock:^(UIManagedDocument *database) {
        [self setupFetchedResultsController:database.managedObjectContext];
    }];
}

- (void) cancelButtonPress:(id)sender {
    [[self presentingViewController] dismissModalViewControllerAnimated:YES];
}

- (void) managedDocumentOpened:(UIManagedDocument *)database {
    [self setupFetchedResultsController:database.managedObjectContext];
}

- (NSArray *) excludedTeamPredicates {
    
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.delegate teamsToExcludeFromSelection].count ; i++) {
        Team *team = [[self.delegate teamsToExcludeFromSelection] objectAtIndex:i];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"teamName != %@", team.teamName];
        
        [predicates addObject:predicate];
    }

    return predicates;
}

- (void)setupFetchedResultsController:(NSManagedObjectContext *)context // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Team"];

    if([self excludedTeamPredicates]) request.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:[self excludedTeamPredicates]];
    
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"teamName" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
    // no predicate because we want ALL the Photographers
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"selectTeamCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // ask NSFetchedResultsController for the NSMO at the row in question
    Team *team = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.accessoryType = [self.selectedTeams containsObject:team] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    // Then configure the cell using it ...
    cell.textLabel.text = team.teamName;
    
//    NSLog(@"Team: %@", team.teamName);
    
    return cell;
}

- (void) onDonePressed:(id)sender {
    [self.delegate teamSelectionComplete:[self selectedTeams]];
}

- (void) validateNavigationBar {
    
//    UINavigationItem *navigationItem = [self.navigationItem.items objectAtIndex:0];
    
    if(self.selectedTeams.count > 0 && !self.navigationItem.rightBarButtonItem){
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDonePressed:)];
        self.navigationItem.rightBarButtonItem = doneButton;
    }else{
        if(self.selectedTeams.count == 0) self.navigationItem.rightBarButtonItem = nil;
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Team *teamFromIndex = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if([self.selectedTeams containsObject:teamFromIndex]){
        [self.selectedTeams removeObject:teamFromIndex];
    }else{
        if([self.delegate numberOfTeamsToSelect] != 1){
            if(self.selectedTeams.count < [self.delegate numberOfTeamsToSelect]) [self.selectedTeams addObject:teamFromIndex];
        }else{
            self.selectedTeams = [NSMutableArray arrayWithObject:teamFromIndex];
        }        
    }
    
    [self.tableView reloadData];
    [self validateNavigationBar];
}

- (void)viewDidUnload
{
    [self setNavigationBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
