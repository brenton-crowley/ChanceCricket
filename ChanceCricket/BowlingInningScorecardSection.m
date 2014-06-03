//
//  BowlingInningScorecardSection.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreboardBowlerCell.h"
#import "BowlingInningScorecardSection.h"
#import "Over+Factory.h"
#import "Match.h"
#import "MatchSettings.h"

@implementation BowlingInningScorecardSection

@synthesize sectionTitle = _sectionTitle;
@synthesize bowlers = _bowlers;
@synthesize sectionCells = _sectionCells;
@synthesize currentMatchInning = _currentMatchInning;

#define SECTION_TITLE @"Bowling"

- (NSString *) sectionTitle {
    return SECTION_TITLE;
}

- (BowlingInningScorecardSection *) initWithBowlers:(NSOrderedSet *)bowlers withCurrentMatchInning:(Inning *)inning{
    self.bowlers = bowlers;
    self.currentMatchInning = inning;
    return self;
}

- (NSMutableArray *) sectionCells {
    
    if(!_sectionCells) {
        
        _sectionCells = [NSMutableArray arrayWithObject:[[ScoreboardCellData alloc] initWithData:nil setReuseIdentifier:[ScoreboardBowlerCell cellReuseID] setCellHeight:[ScoreboardBowlerCell cellHeight]]];
        
        for (Bowler *bowler in self.bowlers) {
            
            ScoreboardCellData *cellData = [[ScoreboardCellData alloc] initWithData:bowler setReuseIdentifier:[ScoreboardBowlerCell cellReuseID] setCellHeight:[ScoreboardBowlerCell cellHeight]];
            [_sectionCells addObject:cellData];
        }
    
    }
    return _sectionCells;
}

- (void) formatBowlerCell:(ScoreboardBowlerCell *)bowlerCell withBowler:(Bowler *)bowler {
    
    if(bowler.inning != self.currentMatchInning){
        [bowlerCell setDisplayInactive];
    }else{
        if(self.currentMatchInning.currentBowler == bowler){
            [bowlerCell setDisplayBowling];
        }else if(bowler.overs.count == self.currentMatchInning.match.matchSettings.bowlerOverLimit.intValue){
            [bowlerCell setDisplayOversComplete];
        }else{
            [bowlerCell setDisplayInactive];
        }
    }
    
}

- (void) renderCell:(id)cell withData:(ScoreboardCellData *)cellData {
    
    ScoreboardBowlerCell *bowlerCell = (ScoreboardBowlerCell *)cell;
    Bowler *bowler = (Bowler *)cellData.data;
    
    if(bowlerCell && bowler){
        
        bowlerCell.playerNameLabel.text = [NSString stringWithFormat:@"%@", bowler.bowlerName];
        bowlerCell.oversLabel.text = [NSString stringWithFormat:@"%@", [Over shortFormattedStringForOvers:bowler.overs]];
        bowlerCell.wicketsLabel.text = [NSString stringWithFormat:@"%i",  bowler.wickets.count];
        bowlerCell.runsLabel.text = [NSString stringWithFormat:@"%i",  [bowler inningsRuns].intValue];
        bowlerCell.economyLabel.text = [NSString stringWithFormat:@"%0.2f",  [bowler economyRate]];
        
        [self formatBowlerCell:bowlerCell withBowler:bowler];
    }else{
        if(bowlerCell && !bowler) [bowlerCell setAllFieldsToBold];
    }
}

@end
