//
//  Inning+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 27/02/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Inning.h"
#import "Team.h"

@interface Inning (Factory)

+ (void) addInningToMatch:(Match *) match setBattingTeam:(Team *)battingTeam setBowlingTeam:(Team *)bowlingTeam inContext:(NSManagedObjectContext *)context;
+ (Batsman *) addBatsmanToInning:(Inning *)inning setPlayer:(Player *)player inContext:(NSManagedObjectContext *)context;
+ (Bowler *) addBowlerToInning:(Inning *)inning setPlayer:(Player *)player inContext:(NSManagedObjectContext *)context;

- (void) addOver;
- (Over *) previousOver;
- (void) update;
- (double) runRate;

- (NSOrderedSet *) eligibleBowlerSet;
- (NSOrderedSet *) usedBowlerSet;

- (Team *) battingTeam;
- (Team *) bowlingTeam;

@end
