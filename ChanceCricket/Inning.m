//
//  Inning.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Inning.h"
#import "Batsman.h"
#import "Bowler.h"
#import "Match.h"
#import "Over.h"
#import "Wicket.h"


@implementation Inning

@dynamic battingTeamID;
@dynamic bowlingTeamID;
@dynamic inningID;
@dynamic inningRuns;
@dynamic batsmen;
@dynamic bowlers;
@dynamic currentBowler;
@dynamic currentNonStriker;
@dynamic currentRestingBowler;
@dynamic currentStriker;
@dynamic match;
@dynamic overs;
@dynamic wickets;

@end
