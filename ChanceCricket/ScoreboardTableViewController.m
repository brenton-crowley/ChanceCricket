//
//  ScoreboardTableViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 10/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "ScoreboardTableViewController.h"


@interface ScoreboardTableViewController ()

- (NSString *) queueNewCellForDisplayFromList;
- (void) invalidate;

@end

@implementation ScoreboardTableViewController

NSString * const CELL_BATSMEN = @"cellBatsmen";
NSString * const CELL_BOWLERS = @"cellBowlers";
NSString * const CELL_LAST_WICKET = @"cellLastWicket";
NSString * const CELL_RUN_RATES = @"cellRunRates";

@synthesize isActive = _isActive;
@synthesize headingTwoLinesTableViewCell = _scoreboardTableViewCell;
@synthesize lastWicketTableViewCell = _lastWicketTableViewCell;
@synthesize invalidateViewTimer = _invalidateViewTimer;
@synthesize currentCell = _currentCell;
@synthesize queuedCell = _queuedCell;
@synthesize delegate = _delegate;
@synthesize tableView = _tableView;
@synthesize cellTypes = _cellTypes;

#define TICK_SPEED 3
#define NUM_SECTIONS_IN_VIEW 1
#define NUM_ROWS_IN_SECTION 2

- (void) setDelegate:(id<ScoreboardTableViewControllerDelegate>)delegate {
    _delegate = delegate;
    
//    NSLog(@"setDelegate in ScoreboardTVC");
}

- (NSArray *) cellTypes {
    
    NSMutableArray *cellTypes = [NSMutableArray arrayWithObjects:CELL_BATSMEN, CELL_BOWLERS, CELL_RUN_RATES, nil];
    Inning *inning = [self.delegate inningForScoreboardTableView];
    if(inning && inning.wickets.count > 0 && ![cellTypes containsObject:CELL_LAST_WICKET]) [cellTypes addObject:CELL_LAST_WICKET];
    
    _cellTypes = cellTypes;
    
    return _cellTypes;
}

- (void) loadView {
    self.view = self.tableView;
}

- (UITableView *) tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame: CGRectMake(90, 0, 160, 64)
                                                              style:UITableViewStylePlain];
        _tableView.rowHeight = 64;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (id <ScoreboardTableCellProtocol>) currentCell {
    if(!_currentCell) _currentCell = [self getTableCellFromSpecifiedCell:[[self cellTypes] objectAtIndex:0]];
    return _currentCell;
}

- (id <ScoreboardTableCellProtocol>) queuedCell {
    if(!_queuedCell) _queuedCell = [self getTableCellFromSpecifiedCell:[self queueNewCellForDisplayFromList]];
    return _queuedCell;
}

- (void) update {
    if(!self.isActive) self.isActive = YES;
    [self invalidate];
}

- (void) invalidate {
    
//    NSLog(@"Invalidate");
    
    [self.currentCell invalidate:[self.delegate inningForScoreboardTableView]];
    [self.queuedCell invalidate:[self.delegate inningForScoreboardTableView]];
    
    if(self.tableView.delegate != self) self.tableView.delegate = self;
    if(self.tableView.dataSource != self) self.tableView.dataSource = self;
    
//    if(!self.invalidateViewTimer && self.isActive) self.invalidateViewTimer = [NSTimer scheduledTimerWithTimeInterval:TICK_SPEED
//                                                                                              target:self selector:@selector(onInvalidateTimerInterval:)
//                                                                                            userInfo:self repeats:NO];
//    
    [self.tableView reloadData];
}

- (NSString *) getCellReuseIdentifier:(NSString *)cellType {
    
    [[NSBundle mainBundle] loadNibNamed:@"ScoreboardTableViewCell" owner:self options:nil];
//    NSLog(@"cellType: %@ == %@", cellType, CELL_LAST_WICKET);
    NSString *reuseIdentifier = [cellType isEqualToString:CELL_LAST_WICKET] ? self.lastWicketTableViewCell.reuseIdentifier : self.headingTwoLinesTableViewCell.reuseIdentifier;
    self.lastWicketTableViewCell = nil;
    self.headingTwoLinesTableViewCell = nil;
    return reuseIdentifier;
}

- (id) getTableCellFromSpecifiedCell:(NSString *)cellType {
    
    NSString *reuseIdentifier = [self getCellReuseIdentifier:cellType];
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier: reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: reuseIdentifier];
        [[NSBundle mainBundle] loadNibNamed:@"ScoreboardTableViewCell" owner:self options:nil];
//        NSLog(@"Cell was equal to null so add it: %@", reuseIdentifier);
        cell = [cellType isEqualToString:CELL_LAST_WICKET] ? self.lastWicketTableViewCell : self.headingTwoLinesTableViewCell;
    }
    
    ((id <ScoreboardTableCellProtocol>)cell).cellType = cellType;
    [(id <ScoreboardTableCellProtocol>)cell invalidate:[self.delegate inningForScoreboardTableView]];
    
    return cell;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;

    if(indexPath.row == 0) cell = (UITableViewCell *)self.currentCell;
    else if(indexPath.row == 1) cell = (UITableViewCell *)self.queuedCell;

    return cell;
} 

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.row%2 == 0) {
        UIColor *altCellColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.1];
        cell.backgroundColor = altCellColor;
    }
}

- (void) onInvalidateTimerInterval:(NSTimer *)timer {
        
    self.invalidateViewTimer = nil;
    
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    if([self.tableView indexPathForSelectedRow] != [NSIndexPath indexPathForRow:0 inSection:0]){

        self.currentCell = self.queuedCell;
        self.queuedCell = [self getTableCellFromSpecifiedCell:[self queueNewCellForDisplayFromList]];
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self invalidate];
        
    }
    
}

- (NSString *) queueNewCellForDisplayFromList {
    NSArray *allTypes = [self cellTypes];
    NSUInteger index = [allTypes indexOfObject:self.currentCell.cellType] + 1 >= allTypes.count ? 0 : [allTypes indexOfObject:self.currentCell.cellType] + 1;
    NSString *cellType = [allTypes objectAtIndex:index];
    
    return cellType;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return NUM_SECTIONS_IN_VIEW;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return NUM_ROWS_IN_SECTION;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.headingTwoLinesTableViewCell = nil;
    self.lastWicketTableViewCell = nil;
    self.invalidateViewTimer = nil;
    self.currentCell = nil;
    self.queuedCell = nil;
    self.delegate = nil;
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.tableView = nil;
    self.cellTypes = nil;
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.isActive = NO;
    [self.invalidateViewTimer invalidate];
    self.invalidateViewTimer = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
