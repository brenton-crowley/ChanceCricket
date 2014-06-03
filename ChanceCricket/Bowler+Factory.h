//
//  Bowler+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bowler.h"
#import "Inning.h"
#import "Player.h"

@interface Bowler (Factory)

+ (Bowler *) addBowlerToInning:(Inning *)inning setPlayer:(Player *)player;

- (NSNumber *) inningsRuns;
- (double) economyRate;

@end
