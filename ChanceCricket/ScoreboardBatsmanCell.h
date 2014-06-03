//
//  ScorecoardBatsmanCell.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreboardCellProtocol.h"

@interface ScoreboardBatsmanCell : UITableViewCell <ScoreboardCellProtocol>

- (void) setDisplayToYetToBat;
- (void) setDisplayOut;
- (void) setDisplayBatting;
- (void) setAllFieldsToBold;

@property (nonatomic, weak) IBOutlet UILabel *playerNameLabel;
//@property (nonatomic, weak) IBOutlet UILabel *statusLabel;
@property (nonatomic, weak) IBOutlet UILabel *ballsFacedLabel;
@property (nonatomic, weak) IBOutlet UILabel *strikeRateLabel;
@property (nonatomic, weak) IBOutlet UILabel *runsLabel;

@end
