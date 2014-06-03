//
//  ChanceCricketViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchEngine.h"
#import "DieEngine.h"
#import "Match+Factory.h"
#import "Inning+Factory.h"
#import "Match+Summary.h"
#import "Bowler+Factory.h"
#import "Batsman+Factory.h"
#import "Wicket+Factory.h"
#import "CommentaryViewController.h"
#import "ScoreboardTableViewController.h"

@class MatchViewController;

@protocol MatchViewControllerDelegate 

- (NSString *)getFilenameWhereMatchExistsMatchVC:(MatchViewController *)matchVC;
- (void)matchVC:(MatchViewController *)matchVC didFinish:(Match *)match;

@end

@interface MatchViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, MatchEngineDelegate, DieEngineDelegate, ScoreboardTableViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *dieLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *oversLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet UILabel *runRateLabel;

@property (strong, nonatomic) IBOutlet CommentaryViewController *commentaryViewController;
@property (strong, nonatomic) IBOutlet ScoreboardTableViewController *scoreboardTableViewController;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSString *matchID;
@property (strong, nonatomic) id <MatchViewControllerDelegate> delegate;

@end
