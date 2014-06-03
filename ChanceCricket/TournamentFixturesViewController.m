//
//  TournamentFixturesViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "TournamentFixturesViewController.h"

@interface TournamentFixturesViewController ()

@end

@implementation TournamentFixturesViewController
@synthesize fixtureFilter = _fixtureFilter;
@synthesize tableView = _tableView;
@synthesize delegate = _delegate;
@synthesize tournament = _tournament;
@synthesize isAllFiltered = _isAllFiltered;
@synthesize rounds = _rounds;
@synthesize matches = _matches;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.fixtureFilter setTitle:self.tournament.userTournamentTeam.team.teamName forSegmentAtIndex:1];
}

- (BOOL) isAllFiltered {
    return self.fixtureFilter.selectedSegmentIndex == 0 ? YES : NO;
}

- (Tournament *) tournament {
    return [self.delegate selectTournamentForFixtures:self];
}

- (NSOrderedSet *) matchesForTournamentRound:(TournamentRound *)tournamentRound {
    
    return self.isAllFiltered ? tournamentRound.matches : tournamentRound.userMatches;
}

- (NSOrderedSet *) rounds {
    
    if(!self.isAllFiltered){
        __block NSMutableOrderedSet *userRounds = [[NSMutableOrderedSet alloc] init];
        [self.tournament.tournamentRounds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            TournamentRound *tournamentRound = [self.tournament.tournamentRounds objectAtIndex:idx];
            if(tournamentRound.userMatches.count == 0) *stop = YES;
            else [userRounds addObject:tournamentRound];
        }];
        
        _rounds = [userRounds copy];
    }else{
        _rounds = self.tournament.tournamentRounds;
    }
    
    return _rounds;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    TournamentRound *tournamentRound = [self.rounds objectAtIndex:section];
    
    return tournamentRound.tournamentRoundName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.rounds.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TournamentRound *tournamentRound = [self.tournament.tournamentRounds objectAtIndex:section];
    
    return [self matchesForTournamentRound:tournamentRound].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    TableViewSection *tableViewSection = [self.sections objectAtIndex:indexPath.section];
//    TableViewSectionCellData *cellData = [tableViewSection.sectionCellDatas objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fixtureCell"];
//    if(!cell) cell = [[StandingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellData.cellReuseID];
    
//    [cellData renderCell:cell withData:cellData.data atIndexPath:indexPath];
    
    TournamentRound *tournamentRound = [self.rounds objectAtIndex:indexPath.section];
    TournamentMatch *tournamentMatch = [[self matchesForTournamentRound:tournamentRound] objectAtIndex:indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"Match %@ %@", tournamentMatch.matchNumber, tournamentMatch.match ? [NSString stringWithFormat:@"%@ vs %@", tournamentMatch.match.homeTeam.teamName, tournamentMatch.match.awayTeam.teamName] : @"TBC"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", tournamentMatch.match ? [tournamentMatch.match matchSummary] : @"TBC"];
    
    return cell;
}

- (IBAction)onFilterChange:(id)sender {
//    NSLog(@"onFilterChange is All: %@", self.isAllFiltered ? @"YES" : @"NO");
    
    [self.tableView reloadData];
}



- (void)viewDidUnload
{
    [self setFixtureFilter:nil];
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
