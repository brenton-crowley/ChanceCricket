//
//  ScoreboardTableViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 10/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Inning+Factory.h"
#import "HeadingTwoLinesTableViewCell.h"
#import "LastWicketTableViewCell.h"
#import "ScoreboardTableCellProtocol.h"
#import "Batsman+Factory.h"
#import "Wicket+Factory.h"
#import "Bowler+Factory.h"
#import "Inning+Factory.h"
#import "Match+Summary.h"

@protocol ScoreboardTableViewControllerDelegate

- (Inning *) inningForScoreboardTableView;

@end

@interface ScoreboardTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

extern NSString * const CELL_BATSMEN;
extern NSString * const CELL_BOWLERS;
extern NSString * const CELL_LAST_WICKET;
extern NSString * const CELL_RUN_RATES;

- (void) update;

@property (nonatomic) BOOL isActive;
@property (nonatomic, assign) IBOutlet HeadingTwoLinesTableViewCell *headingTwoLinesTableViewCell;
@property (nonatomic, assign) IBOutlet LastWicketTableViewCell *lastWicketTableViewCell;
@property (nonatomic, strong) NSTimer *invalidateViewTimer;
@property (nonatomic, strong) id <ScoreboardTableCellProtocol> currentCell;
@property (nonatomic, strong) id <ScoreboardTableCellProtocol> queuedCell;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *cellTypes;
@property (nonatomic, strong) id <ScoreboardTableViewControllerDelegate> delegate;

@end
