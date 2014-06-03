//
//  CreateGroupsTableViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewSection.h"
#import "TableViewSectionCellData.h"
#import "AddTeamsCellData.h"
#import "TitleSectionCellData.h"
#import "TeamSelectionTableViewController.h"
#import "MatchDatabase.h"
#import "Tournament+Factory.h"
#import "Settings.h"

@class CreateTournamentTableViewController;

@protocol CreateTournamentTableViewControllerDelegate <NSObject>

- (void)tournamentTVC:(CreateTournamentTableViewController *)tournamentTVC createdTournamentID:(NSString *)tournamentID;

@end

@interface CreateTournamentTableViewController : UITableViewController <TeamSelectionTableViewControllerDelegate>

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) TableViewSection *userSection;
@property (nonatomic, strong) TableViewSection *teamsSection;
@property (nonatomic, strong) NSMutableArray *selectedTeams;
@property (nonatomic, strong) Team *userTeam;
@property (nonatomic, strong) id <CreateTournamentTableViewControllerDelegate> delegate;

@end
