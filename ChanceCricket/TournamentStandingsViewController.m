//
//  TournamentStandingsViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "TournamentStandingsViewController.h"

@interface TournamentStandingsViewController ()

@end

@implementation TournamentStandingsViewController

@synthesize tableView = _tableView;
@synthesize tournamentRound = _tournamentRound;
@synthesize delegate = _delegate;
@synthesize sections = _sections;

- (TournamentRound *) tournamentRound {
    return [self.delegate selectTournamentRoundForStandings:self];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (NSArray *) sections {
    
    if(!_sections) {
        NSMutableArray *sections = [[NSMutableArray alloc] init];
        
        for (TournamentGroup *group in self.tournamentRound.groups) {
            TableViewSection *tableViewSection = [[TableViewSection alloc] initWithTitle:group.groupName andData:group];
            [sections addObject:tableViewSection];
            
            [tableViewSection addSectionCellData:[[TableViewSectionCellData alloc] initWithCellReuseID:@"StandingsCell"]];
            
            TournamentGroup *group = tableViewSection.data;
            for (Seed *seed in [group seedsOrderedByGroupRanking]) {
                TableViewSectionCellData *cellData = [[TableViewSectionCellData alloc] initWithCellReuseID:@"StandingsCell" andData:seed];
                [tableViewSection addSectionCellData:cellData];
            }
            
        }
        _sections = [sections copy];
    }
    return _sections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
#warning BUG HERE WHEN I CLICKED ON THE STANDINGS WHEN IN FINAL MODE - Groups maybe don't exist, before match is played. Worked after the match is played. It Broke after directly pressing gotoNext Round. Bug probably lies there. Check for it again after progressing to next round, click the standings table.
    TournamentGroup *group = [self.tournamentRound.groups objectAtIndex:section];
    return group.groupName;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    TableViewSection *tableViewSection = [self.sections objectAtIndex:section];    
    return tableViewSection.sectionCellDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewSection *tableViewSection = [self.sections objectAtIndex:indexPath.section];
    TableViewSectionCellData *cellData = [tableViewSection.sectionCellDatas objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellData.cellReuseID];
    if(!cell) cell = [[StandingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellData.cellReuseID];
    
    [cellData renderCell:cell withData:cellData.data atIndexPath:indexPath];

    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
