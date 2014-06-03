//
//  MatchSelectionTableViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 16/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "MatchSelectionTableViewController.h"

@interface MatchSelectionTableViewController ()

@end

@implementation MatchSelectionTableViewController

@synthesize navigationBar = _navigationBar;
@synthesize delegate = _delegate;
@synthesize selectedMatchID = _selectedMatchID;
@synthesize selectedCell = _selectedCell;

- (IBAction)cancelButtonPress:(UIBarButtonItem *)sender {
    [[self presentingViewController] dismissModalViewControllerAnimated:YES];
}

//- (void) managedDocumentOpened:(UIManagedDocument *)database {
//    [self setupFetchedResultsController:database.managedObjectContext];
//}

- (void)setupFetchedResultsController:(NSManagedObjectContext *)context // attaches an NSFetchRequest to this UITableViewController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Match"];
    request.predicate = [NSPredicate predicateWithFormat:@"state == %@ || state == %@", MATCH_STATE_IN_PROGRESS, MATCH_STATE_CREATED];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"matchID" ascending:YES]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:context
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"selectMatchCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // ask NSFetchedResultsController for the NSMO at the row in question
    Match *match = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Then configure the cell using it ...
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",  match.matchID];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ vs %@:", match.homeTeam.teamShortName, match.awayTeam.teamShortName];
    
//    NSLog(@"Match ID: %@", match.matchID);
    
    return cell;
}

- (void) onDonePressed:(id)sender {
    [self.delegate matchSelectionComplete:self withMatchID:self.selectedMatchID];
}

- (void) validateNavigationBar {
    
    UINavigationItem *navigationItem = [self.navigationBar.items objectAtIndex:0];
    
    if(!navigationItem.rightBarButtonItem){
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onDonePressed:)];
        navigationItem.rightBarButtonItem = doneButton;
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Match *targetSelectedMatch = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if([targetSelectedMatch.matchID isEqualToString:self.selectedMatchID]) return;
    
    if(self.selectedCell) self.selectedCell.accessoryType = UITableViewCellAccessoryNone;
    
    self.selectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    self.selectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.selectedMatchID = targetSelectedMatch.matchID;
    
//    NSLog(@"Selected Match ID: %@", self.selectedMatchID);
    
//    [self validateNavigationBar];
    
    [self.delegate matchSelectionComplete:self withMatchID:self.selectedMatchID];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [MatchDatabase getDatabaseDocumentFromRequester:self];
	// Do any additional setup after loading the view.
    [MatchDatabase openFile:DOCUMENT_EXHIBITION_MATCHES usingBlock:^(UIManagedDocument *database) {
        [self setupFetchedResultsController:database.managedObjectContext];
    }];
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
