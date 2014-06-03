//
//  LastWicketTableViewCell.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 10/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "LastWicketTableViewCell.h"
#import "Batsman+Factory.h"
#import "Wicket+Factory.h"
#import "Bowler+Factory.h"

@implementation LastWicketTableViewCell

@synthesize heading;
@synthesize batsmanRuns;
@synthesize batsmanName;
@synthesize wicketDetail;

@synthesize cellType = _cellType;

- (void) invalidate:(Inning *)inning {
    
    Wicket *wicket = [inning.wickets lastObject];
    
    self.heading.text = @"Last Wicket"; 
    self.batsmanRuns.text = [NSString stringWithFormat:@"%@", wicket.batsman.batsmanRuns];
    self.batsmanName.text = [NSString stringWithFormat:@"%@", wicket.batsman.batsmanName];
    self.wicketDetail.text = [NSString stringWithFormat:@"b:%@", wicket.bowler.bowlerName];
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
