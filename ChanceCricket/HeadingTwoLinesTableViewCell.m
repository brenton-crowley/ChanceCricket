//
//  HeadingTwoLinesTableViewCell.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 10/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "HeadingTwoLinesTableViewCell.h"
#import "ScoreboardTableViewController.h"
#import "Batsman+Factory.h"
#import "Wicket+Factory.h"
#import "Bowler+Factory.h"
#import "Inning+Factory.h"
#import "Match+Summary.h"


@interface HeadingTwoLinesTableViewCell ()

- (void) formatForBatsmen:(Inning *)inning;
- (void) formatForBowlers:(Inning *)inning;
- (void) formatForRunRates:(Inning *)inning;
- (void) formatEmpty;

@end

@implementation HeadingTwoLinesTableViewCell

@synthesize heading;
@synthesize strikerScore;
@synthesize strikerName;
@synthesize nonStrikerScore;
@synthesize nonStrikerName;

@synthesize cellType = _cellType;

- (void) invalidate:(Inning *)inning {
    
    if ([self.cellType isEqualToString:CELL_BATSMEN]) {
        [self formatForBatsmen:inning];
    }else if ([self.cellType isEqualToString:CELL_BOWLERS]) {
        [self formatForBowlers:inning];
    }else if ([self.cellType isEqualToString:CELL_RUN_RATES]) {
        [self formatForRunRates:inning];
    }else{
        [self formatEmpty];
    }
}

- (void) formatForBatsmen:(Inning *)inning {
    self.heading.text = @"Current Batsmen"; 
    self.strikerScore.text = [NSString stringWithFormat:@"%@*", inning.currentStriker.batsmanRuns];
    self.strikerName.text = [NSString stringWithFormat:@"%@", inning.currentStriker.batsmanSurname];
    self.nonStrikerScore.text = [NSString stringWithFormat:@"%@", inning.currentNonStriker.batsmanRuns];
    self.nonStrikerName.text = [NSString stringWithFormat:@"%@", inning.currentNonStriker.batsmanSurname];
}

- (void) formatForBowlers:(Inning *)inning {
    self.heading.text = @"Current Bowlers"; 
    self.strikerScore.text = [NSString stringWithFormat:@"%i-%i", inning.currentBowler.wickets.count, [inning.currentBowler inningsRuns].intValue];
    self.strikerName.text = [NSString stringWithFormat:@"%@", inning.currentBowler.bowlerSurname];
    self.nonStrikerScore.text = [NSString stringWithFormat:@"%i-%i", inning.currentRestingBowler.wickets.count, [inning.currentRestingBowler inningsRuns].intValue];
    self.nonStrikerName.text = [NSString stringWithFormat:@"%@", inning.currentRestingBowler.bowlerSurname];
}

- (void) formatForRunRates:(Inning *)inning {
    self.heading.text = @"Inning Run Rates"; 
    self.strikerScore.text = [NSString stringWithFormat:@"%.02f", [inning.match runRate:inning]];
    self.strikerName.text = [NSString stringWithFormat:@"Current Run Rate"];
    if(inning.match.innings.count != 2){
        self.nonStrikerScore.text = [NSString stringWithFormat:@""];
        self.nonStrikerName.text = [NSString stringWithFormat:@""];
    }else{
        self.nonStrikerScore.text = [NSString stringWithFormat:@"%.02f", [inning.match runRate:inning]];
        self.nonStrikerName.text = [NSString stringWithFormat:@"Required Run Rate"];
    }
    
}

- (void) formatEmpty {
    self.heading.text = @"No Cell Type Set";
    self.strikerScore.text = [NSString stringWithFormat:@"Empty"];
    self.strikerName.text = [NSString stringWithFormat:@"Empty"];
    self.nonStrikerScore.text = [NSString stringWithFormat:@"Empty"];
    self.nonStrikerName.text = [NSString stringWithFormat:@"Empty"];
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
