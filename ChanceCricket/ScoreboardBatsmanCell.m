//
//  ScorecoardBatsmanCell.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreboardBatsmanCell.h"

@implementation ScoreboardBatsmanCell

@synthesize playerNameLabel = _playerNameLabel;
@synthesize ballsFacedLabel = _ballsFacedLabel;
@synthesize strikeRateLabel = _strikeRateLabel;
@synthesize runsLabel = _runsLabel;
//@synthesize statusLabel = _statusLabel;

#define CELL_REUSE_ID @"ScoreboardBatsmanCell"
#define CELL_HEIGHT 34

#define YET_TO_BAT_ALPHA 0.45
#define OUT_ALPHA 0.55
#define BATTING_ALPHA 1

+ (CGFloat) cellHeight {
    return CELL_HEIGHT;
}

+ (NSString *)cellReuseID {
    return CELL_REUSE_ID;
}

- (void) setDisplayToYetToBat {
    self.playerNameLabel.alpha = YET_TO_BAT_ALPHA;
    self.ballsFacedLabel.alpha = YET_TO_BAT_ALPHA;
    self.strikeRateLabel.alpha = YET_TO_BAT_ALPHA;
    self.runsLabel.alpha = YET_TO_BAT_ALPHA;
    
    self.runsLabel.text = @"";
    self.ballsFacedLabel.text = @"";
    self.strikeRateLabel.text = @"";
}

- (void) setDisplayOut {
    self.playerNameLabel.alpha = OUT_ALPHA;
    self.ballsFacedLabel.alpha = OUT_ALPHA;
    self.strikeRateLabel.alpha = OUT_ALPHA;
    self.runsLabel.alpha = OUT_ALPHA;
}

- (void) setDisplayBatting {
    self.playerNameLabel.alpha = BATTING_ALPHA;
    self.ballsFacedLabel.alpha = BATTING_ALPHA;
    self.strikeRateLabel.alpha = BATTING_ALPHA;
    self.runsLabel.alpha = BATTING_ALPHA;
}

- (void) setAllFieldsToBold {
    self.playerNameLabel.font = [UIFont boldSystemFontOfSize:self.playerNameLabel.font.pointSize];
    self.ballsFacedLabel.font = [UIFont boldSystemFontOfSize:self.ballsFacedLabel.font.pointSize];
    self.strikeRateLabel.font = [UIFont boldSystemFontOfSize:self.strikeRateLabel.font.pointSize];
    self.runsLabel.font = [UIFont boldSystemFontOfSize:self.runsLabel.font.pointSize];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
