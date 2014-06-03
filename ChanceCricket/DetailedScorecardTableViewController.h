//
//  DetailedScorecardTableViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "Match.h"

@interface DetailedScorecardTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segementedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Match *match;
@property (nonatomic, strong) NSMutableArray *segments;

@end
