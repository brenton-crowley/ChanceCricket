//
//  ScoreboardBowlerCell.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreboardCellProtocol.h"

@interface ScoreboardBowlerCell : UITableViewCell <ScoreboardCellProtocol>

- (void) setAllFieldsToBold;
- (void) setDisplayBowling;
- (void) setDisplayInactive;
- (void) setDisplayOversComplete;

@property (nonatomic, weak) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *oversLabel;
@property (nonatomic, weak) IBOutlet UILabel *wicketsLabel;
@property (nonatomic, weak) IBOutlet UILabel *runsLabel;
@property (nonatomic, weak) IBOutlet UILabel *economyLabel;

@end
