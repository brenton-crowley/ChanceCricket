//
//  MatchSelectionTableViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 16/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "CoreDataTableViewController.h"
#import "Match+Factory.h"
#import "MatchDatabase.h"
#import "Team+Factory.h"
#import "Settings.h"

@protocol MatchSelectionTableViewControllerDelegate <NSObject>

- (void) matchSelectionComplete:(id)sender withMatchID:(NSString *)matchID;

@end

@interface MatchSelectionTableViewController : CoreDataTableViewController

@property (strong, nonatomic) UITableViewCell *selectedCell;
@property (nonatomic, strong) id <MatchSelectionTableViewControllerDelegate> delegate;
@property (nonatomic, strong) NSString *selectedMatchID;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@end
