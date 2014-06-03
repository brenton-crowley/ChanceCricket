//
//  DetailedScorecardTableViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailedScorecardTableViewController.h"
#import "Match+Factory.h"
#import "ScorecardSegment.h"
#import "SegmentProtocol.h"
#import "SectionProtocol.h"
#import "ScoreboardCellData.h"
#import "BattingInningScorecardSection.h"
#import "BowlingInningScorecardSection.h"
#import "SummaryInningScorecardSection.h"

@interface DetailedScorecardTableViewController () 

@property (nonatomic, strong) id <SegmentProtocol> currentSegment;

- (void) createSegments;
- (ScorecardSegment *) createSegmentWithInning:(Inning *)inning;
- (ScorecardSegment *) createSegmentWithSummary;

@end

@implementation DetailedScorecardTableViewController

@synthesize segementedControl = _segementedControl;
@synthesize tableView = _tableView;
@synthesize match = _match;
@synthesize segments = _segements;

@synthesize currentSegment = _currentSegment;

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self createSegments];
    [self.segementedControl setSelectedSegmentIndex:0];
}

- (void) createSegments {
   
    [self.segementedControl removeAllSegments];
    
    self.segments = [[NSMutableArray alloc] init];
    
    // Summary Segemnt 
    ScorecardSegment *summarySegment = [self createSegmentWithSummary];
    [self.segments addObject:summarySegment];

    // Create Inning Segments
    for (Inning *inning in self.match.innings) {
        ScorecardSegment *segment = [self createSegmentWithInning:inning];
        [self.segments addObject:segment];
    }
    
    // Add the segments to the segmented control
    for (ScorecardSegment *segment in self.segments) {
        [self.segementedControl insertSegmentWithTitle:segment.segmentName atIndex:self.segementedControl.numberOfSegments animated:NO];
    }
    
}

- (ScorecardSegment *) createSegmentWithInning:(Inning *)inning {
    
    SummaryInningScorecardSection *summarySection = [[SummaryInningScorecardSection alloc] initWithInning:inning];
    BattingInningScorecardSection *battingSection = [[BattingInningScorecardSection alloc] initWithBatsman:inning.batsmen withCurrentMatchInning:self.match.currentInnings];
    BowlingInningScorecardSection *bowlingSection = [[BowlingInningScorecardSection alloc] initWithBowlers:[inning usedBowlerSet] withCurrentMatchInning:self.match.currentInnings];
    ScorecardSegment *scorecardSegment = [[ScorecardSegment alloc] initWithName:inning.battingTeamID];
    
    // add an inning summary section
    [scorecardSegment addSection:summarySection];
    [scorecardSegment addSection:battingSection];
    [scorecardSegment addSection:bowlingSection];
    
    return scorecardSegment;
    
}

- (ScorecardSegment *) createSegmentWithSummary {
    
    SummaryInningScorecardSection *summarySection = [[SummaryInningScorecardSection alloc] initWithInning:self.match.currentInnings];
    BowlingInningScorecardSection *bowlingSection = [[BowlingInningScorecardSection alloc] initWithBowlers:[self.match.currentInnings usedBowlerSet] withCurrentMatchInning:self.match.currentInnings];
    ScorecardSegment *scorecardSegment = [[ScorecardSegment alloc] initWithName:@"Summary"];
    
    [scorecardSegment addSection:summarySection];
    [scorecardSegment addSection:bowlingSection];
    
    return scorecardSegment;
    
}

- (id <SegmentProtocol>) currentSegment {
    self.currentSegment = [self.segments objectAtIndex:self.segementedControl.selectedSegmentIndex];
    return _currentSegment;
}

- (IBAction)onSegementChange:(id)sender {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{   
    return self.currentSegment.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    
    id <SectionProtocol> scorecardSection = [self.currentSegment.sections objectAtIndex:section];
    return scorecardSection.sectionCells.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    id <SectionProtocol> scorecardSection = [self.currentSegment.sections objectAtIndex:indexPath.section];
    ScoreboardCellData *cellData = [scorecardSection.sectionCells objectAtIndex:indexPath.row];
    
    id cell = [self.tableView dequeueReusableCellWithIdentifier:cellData.reuseIdentifier];
    [scorecardSection renderCell:cell withData:cellData];

    if (cell == nil) {
        NSLog(@"Cell was == nil");
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"EmptyCell"];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    id <SectionProtocol> scorecardSection = [self.currentSegment.sections objectAtIndex:section];
    
    return scorecardSection.sectionTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id <SectionProtocol> scorecardSection = [self.currentSegment.sections objectAtIndex:indexPath.section];
    ScoreboardCellData *cellData = [scorecardSection.sectionCells objectAtIndex:indexPath.row];
    
    return cellData.cellHeight;
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setSegementedControl:nil];

    self.segments = nil;
    self.match = nil;
    [super viewDidUnload];
}
@end
