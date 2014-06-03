//
//  TournamentStandingsViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TournamentRound+Factory.h"
#import "StandingsTableViewCell.h"
#import "Seed+Factory.h"
#import "TableViewSection.h"
#import "TableViewSectionCellData.h"

@class TournamentStandingsViewController;

@protocol TournamentStandingsViewControllerDelegate <NSObject>

- (TournamentRound *)selectTournamentRoundForStandings:(TournamentStandingsViewController *)tournamentStandings;

@end

@interface TournamentStandingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TournamentRound *tournamentRound;
@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) id <TournamentStandingsViewControllerDelegate> delegate;

@end
