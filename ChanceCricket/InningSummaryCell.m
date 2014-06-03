//
//  InningSummaryCell.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "InningSummaryCell.h"

@implementation InningSummaryCell

@synthesize rightTitleLabel = _rightTitleLabel;
@synthesize rightSubtitleLabel = _rightSubtitleLabel;
@synthesize leftTitleLabel = _leftTitleLabel;
@synthesize leftSubtitleLabel = _leftSubtitleLabel;

#define CELL_REUSE_ID @"InningSummaryCell"
#define CELL_HEIGHT 44

+ (CGFloat) cellHeight {
    return CELL_HEIGHT;
}

+ (NSString *)cellReuseID {
    return CELL_REUSE_ID;
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
