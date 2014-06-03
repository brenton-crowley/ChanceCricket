//
//  TeamSelectionTableViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 16/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Team+Factory.h"
#import "MatchDatabase.h"
#import "Settings.h"

@class TeamSelectionTableViewController;

@protocol TeamSelectionTableViewControllerDelegate <NSObject>

- (void) teamSelectionComplete:(NSArray *)teams;

- (NSUInteger) numberOfTeamsToSelect;
- (NSArray *) teamsToExcludeFromSelection;

@end

@interface TeamSelectionTableViewController : CoreDataTableViewController

@property (strong, nonatomic) NSMutableArray *selectedTeams;
@property (strong, nonatomic) UITableViewCell *selectedCell;
@property (strong, nonatomic) NSString *excludedTeam;
@property (strong, nonatomic) Team *selectedTeam;
@property (nonatomic, strong) id <TeamSelectionTableViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end
