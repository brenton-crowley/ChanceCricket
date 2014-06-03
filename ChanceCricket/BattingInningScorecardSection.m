//
//  BattingInningScorecardSection.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattingInningScorecardSection.h"
#import "ScoreboardCellData.h"
#import "ScoreboardBatsmanCell.h"
#import "Inning+Factory.h"

@implementation BattingInningScorecardSection

@synthesize batsmen = _batsmen;
@synthesize sectionCells = _sectionCells;
@synthesize sectionTitle = _sectionTitle;
@synthesize currentMatchInning = _currentMatchInning;

#define SECTION_TITLE @"Batting"

- (NSString *) sectionTitle {
    return SECTION_TITLE;
}

- (BattingInningScorecardSection *) initWithBatsman:(NSOrderedSet *)batsmen withCurrentMatchInning:(Inning *)inning{
    self.batsmen = batsmen;
    self.currentMatchInning = inning;
    return self;
}

- (NSMutableArray *) sectionCells {
    
    if(!_sectionCells) {
        
        _sectionCells = [NSMutableArray arrayWithObject:[[ScoreboardCellData alloc] initWithData:nil setReuseIdentifier:[ScoreboardBatsmanCell cellReuseID] setCellHeight:[ScoreboardBatsmanCell cellHeight]]];
        
        for (Batsman *batsman in self.batsmen) {
            
            ScoreboardCellData *cellData = [[ScoreboardCellData alloc] initWithData:batsman setReuseIdentifier:[ScoreboardBatsmanCell cellReuseID] setCellHeight:[ScoreboardBatsmanCell cellHeight]];
            [_sectionCells addObject:cellData];
        }
        
    }
    return _sectionCells;
}

- (void) formatBatsmanCell:(ScoreboardBatsmanCell *)batsmanCell withBatsman:(Batsman *)batsman {
    
    if(batsman.wicket){
        [batsmanCell setDisplayOut];
        //                batsmanCell.statusLabel.text = [NSString stringWithFormat:@"b: %@", batsman.wicket.bowler.bowlerName];
    }else if(self.currentMatchInning.currentStriker == batsman ||
             self.currentMatchInning.currentNonStriker == batsman){
        [batsmanCell setDisplayBatting];
        //                batsmanCell.statusLabel.text = [NSString stringWithFormat:@"N.O"];
    }else{
        [batsmanCell setDisplayToYetToBat];
    }
    
}

- (void) renderCell:(id)cell withData:(ScoreboardCellData *)cellData {
    
    ScoreboardBatsmanCell *batsmanCell = (ScoreboardBatsmanCell *)cell;
    Batsman *batsman = (Batsman *)cellData.data;
    
    if(batsman && batsmanCell){
        
        batsmanCell.playerNameLabel.text = [NSString stringWithFormat:@"%@", batsman.batsmanName];
        batsmanCell.ballsFacedLabel.text = [NSString stringWithFormat:@"%i", [batsman ballsFaced]];
        batsmanCell.strikeRateLabel.text = [NSString stringWithFormat:@"%.02f", [batsman strikeRate]];
        batsmanCell.runsLabel.text = [NSString stringWithFormat:@"%@", batsman.batsmanRuns];
        
        [self formatBatsmanCell:batsmanCell withBatsman:batsman];

    }else{
        if(batsmanCell && !batsman) [batsmanCell setAllFieldsToBold];
    }
}

@end
