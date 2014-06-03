//
//  SummaryInningScorecardSection.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SummaryInningScorecardSection.h"
#import "InningSummaryCell.h"
#import "Over+Factory.h"
#import "Match+Summary.h"
#import "MatchSettings.h"
#import "Bowler+Factory.h"
#import "Wicket+Factory.h"
#import "Batsman+Factory.h"

@implementation SummaryInningScorecardSection

@synthesize sectionTitle = _sectionTitle;
@synthesize sectionCells = _sectionCells;
@synthesize inning = _inning;

#define SECTION_TITLE @"Latest"

- (NSString *) sectionTitle {
    return SECTION_TITLE;
}

- (SummaryInningScorecardSection *) initWithInning:(Inning *)inning {
    self.inning = inning;
    return self;
}

- (NSMutableArray *) sectionCells {
    
    if(!_sectionCells) _sectionCells = [NSMutableArray arrayWithObject:[[ScoreboardCellData alloc] initWithData:nil setReuseIdentifier:[InningSummaryCell cellReuseID] setCellHeight:[InningSummaryCell cellHeight]]];
    
    return _sectionCells;
}

- (void) renderCell:(id)cell withData:(ScoreboardCellData *)cellData {
    
    InningSummaryCell *inningCell = (InningSummaryCell *)cell;
    
    if(inningCell){
        
        inningCell.rightTitleLabel.text = [NSString stringWithFormat:@"%i for %@", self.inning.wickets.count, self.inning.inningRuns];
        inningCell.leftTitleLabel.text = [NSString stringWithFormat:@"Over %@", [Over fullFormattedStringForOvers:self.inning.overs]];
        inningCell.rightSubtitleLabel.text = [NSString stringWithFormat:@"RR: %0.2f", [self.inning runRate]];
        
        Wicket *wicket = [self.inning.wickets lastObject];
        NSString *lastWicketText = wicket != nil ? [NSString stringWithFormat:@"Last Wicket: %@ %@", wicket.batsman.batsmanName, wicket.batsman.batsmanRuns] : [NSString stringWithFormat:@""];
        inningCell.leftSubtitleLabel.text = lastWicketText;
        
    }else{
        
    }
}

@end
