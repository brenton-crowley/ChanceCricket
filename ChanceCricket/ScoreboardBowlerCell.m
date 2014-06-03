//
//  ScoreboardBowlerCell.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreboardBowlerCell.h"

@implementation ScoreboardBowlerCell

@synthesize playerNameLabel = _playerNameLabel;
@synthesize oversLabel = _oversLabel;
@synthesize runsLabel = _runsLabel;
@synthesize wicketsLabel = _wicketsLabel;
@synthesize economyLabel = _economyLabel;

#define CELL_REUSE_ID @"ScoreboardBowlerCell"
#define CELL_HEIGHT 34

#define INACTIVE_ALPHA 0.7
#define BOWLING_ALPHA 1
#define COMPLETE_ALPHA 0.4

+ (CGFloat) cellHeight {
    return CELL_HEIGHT;
}

+ (NSString *)cellReuseID {
    return CELL_REUSE_ID;
}

- (void) setAllFieldsToBold {
    self.playerNameLabel.font = [UIFont boldSystemFontOfSize:self.playerNameLabel.font.pointSize];
    self.oversLabel.font = [UIFont boldSystemFontOfSize:self.oversLabel.font.pointSize];
    self.wicketsLabel.font = [UIFont boldSystemFontOfSize:self.wicketsLabel.font.pointSize];
    self.runsLabel.font = [UIFont boldSystemFontOfSize:self.runsLabel.font.pointSize];
    self.economyLabel.font = [UIFont boldSystemFontOfSize:self.economyLabel.font.pointSize];
}

- (void) setDisplayBowling {
    self.playerNameLabel.alpha = BOWLING_ALPHA;
    self.oversLabel.alpha = BOWLING_ALPHA;
    self.wicketsLabel.alpha = BOWLING_ALPHA;
    self.runsLabel.alpha = BOWLING_ALPHA;
    self.economyLabel.alpha = BOWLING_ALPHA;
}

- (void) setDisplayInactive {
    
    self.playerNameLabel.alpha = INACTIVE_ALPHA;
    self.oversLabel.alpha = INACTIVE_ALPHA;
    self.wicketsLabel.alpha = INACTIVE_ALPHA;
    self.runsLabel.alpha = INACTIVE_ALPHA;
    self.economyLabel.alpha = INACTIVE_ALPHA;
}

- (void) setDisplayOversComplete {
    self.playerNameLabel.alpha = COMPLETE_ALPHA;
    self.oversLabel.alpha = COMPLETE_ALPHA;
    self.wicketsLabel.alpha = COMPLETE_ALPHA;
    self.runsLabel.alpha = COMPLETE_ALPHA;
    self.economyLabel.alpha = COMPLETE_ALPHA;
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
