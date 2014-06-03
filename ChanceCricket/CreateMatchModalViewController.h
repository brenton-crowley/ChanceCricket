//
//  CreateMatchModalViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamSelectionTableViewController.h"
#import "Team+Factory.h"
#import "MatchDatabase.h"
#import "MatchViewController.h"

@protocol CreateMatchModalViewControllerDelegate <NSObject>

- (void) gotoMatch:(NSString *)matchID;

@end

@interface CreateMatchModalViewController : UITableViewController <TeamSelectionTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet UITableViewCell *homeTeamCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *awayTeamCell;

@property (strong, nonatomic) Team *teamToExcludeFromSelection;
@property (strong, nonatomic) Team *homeTeam;
@property (strong, nonatomic) Team *awayTeam;
@property (strong, nonatomic) id <CreateMatchModalViewControllerDelegate> delegate;

@end
