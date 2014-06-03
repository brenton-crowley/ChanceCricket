//
//  Inning+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 27/02/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Inning+Factory.h"
#import "Match+Factory.h"
#import "Over+Factory.h"
#import "Delivery+Factory.h"
#import "Batsman+Factory.h"
#import "Bowler+Factory.h"
#import "Wicket+Factory.h"
#import "MatchSettings.h"
#import "Player+Factory.h"
#import "Team+Factory.h"
#import "Bowler+Factory.h"

@implementation Inning (Factory)

#define ENTITY_NAME @"Inning"

+ (void) addInningToMatch:(Match *) match setBattingTeam:(Team *)battingTeam setBowlingTeam:(Team *)bowlingTeam inContext:(NSManagedObjectContext *)context {
    
    Inning *inning = nil;
    inning = [NSEntityDescription insertNewObjectForEntityForName:@"Inning" inManagedObjectContext:context];
    inning.inningID = [NSNumber numberWithInt: [[NSString stringWithFormat:@"%i%i", match.matchID.intValue, (match.innings.count + 1)] intValue]];    
    inning.inningRuns = 0;
    inning.match = match;
    inning.battingTeamID = battingTeam.teamID;
    inning.bowlingTeamID = bowlingTeam.teamID;
    // will use enumeration to go through the team's player list and add each as a batsman
    // change to populate with batting order
    
    for (Player *batsman in battingTeam.players) {
        [Inning addBatsmanToInning:inning setPlayer:batsman inContext:context];
    }
    
    for (Player *bowler in [bowlingTeam.players reversedOrderedSet]) {
        [Inning addBowlerToInning:inning setPlayer:bowler inContext:context];
    }

    inning.currentStriker = [inning.batsmen objectAtIndex:0];
    inning.currentNonStriker = [inning.batsmen objectAtIndex:1];
    inning.currentBowler = [inning.bowlers objectAtIndex:0];
    inning.currentRestingBowler = [inning.bowlers objectAtIndex:1];
}

+ (Batsman *) addBatsmanToInning:(Inning *)inning setPlayer:(Player *)player inContext:(NSManagedObjectContext *)context {
    Batsman *batsman = [Batsman addBatsmanToInning:inning setPlayer:player];
//    NSLog(@"Add Batsman ID: %i", inning.inningID.intValue);
    return batsman;
}

+ (Bowler *) addBowlerToInning:(Inning *)inning setPlayer:(Player *)player inContext:(NSManagedObjectContext *)context {
    Bowler *bowler = [Bowler addBowlerToInning:inning setPlayer:player];
//    //    NSLog(@"Add Bowler ID: %i", inning.inningID.intValue);
    return bowler;
}

- (void) rotateBowlers {
    Bowler *currentBowler = self.currentBowler;
    self.currentBowler = self.currentRestingBowler;
    self.currentRestingBowler = currentBowler;
}

- (void) rotateStrike {
    Batsman *currentStriker = self.currentStriker;
    self.currentStriker = self.currentNonStriker;
    self.currentNonStriker = currentStriker;
}

- (void) addOver {
    
    [self rotateStrike];
    [self rotateBowlers];
       
    [Over addOverToInning:self toBowler:self.currentBowler];
}

- (void) updateBatsmen {
    
    Over *over = [self.overs lastObject];
    Delivery *delivery = [over.deliveries lastObject];
    
    int deliveryRuns = delivery.deliveryRuns.intValue;
    
    self.currentStriker.batsmanRuns = [NSNumber numberWithInt:self.currentStriker.batsmanRuns.intValue + deliveryRuns];
    NSMutableOrderedSet *deliveries = [self.currentStriker.deliveries mutableCopy];
    [deliveries addObject:delivery];
    self.currentStriker.deliveries = deliveries;
    
    if(deliveryRuns == 1 || deliveryRuns == 3) [self rotateStrike];
    
}

- (void) update {
    
    [self updateBatsmen];
    
    Over *over = [self.overs lastObject];
    Delivery *delivery = [over.deliveries lastObject];
    self.inningRuns = [NSNumber numberWithInt: self.inningRuns.intValue + delivery.deliveryRuns.intValue];
    
    if(delivery.isWicket.boolValue){
        [Wicket addWicketToInning:self toBowler:over.bowler];
        if(self.wickets.count != self.match.matchSettings.wicketLimit.intValue) self.currentStriker = [self.batsmen objectAtIndex:self.wickets.count + 1];
    }

//    
    [self.match update];
    
}

- (Over *) previousOver {
    Over *over = nil;

    if (self.overs.count > 1) over = [self.overs objectAtIndex:self.overs.count - 1];
    else if(self.overs.count == 1) over = [self.overs lastObject];

    return over;
}

- (NSOrderedSet *) eligibleBowlerSet {
    
    NSMutableArray *ineligibleBowlers = [[NSMutableArray alloc] init];
    
    [self.bowlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Bowler *bowler = obj;
        if(bowler.overs.count == self.match.matchSettings.bowlerOverLimit.intValue ||
           [self.currentBowler isEqual:bowler]) {
            [ineligibleBowlers addObject:bowler]; 
//            NSLog(@"INELIGIBLE BOWLER: %@", bowler.bowlerName);
        };
    }];
    
    NSMutableOrderedSet *bowlers = [self.bowlers mutableCopy];
    [bowlers removeObjectsInArray:ineligibleBowlers];
    
//    NSLog(@"TOTAL ELIGIBLE BOWLERS: %i", bowlers.count);
    
    return (NSOrderedSet *)bowlers;
}

- (NSOrderedSet *) usedBowlerSet {
    
    NSMutableArray *unusedBowlers = [[NSMutableArray alloc] init];
    
    [self.bowlers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Bowler *bowler = obj;
        if(bowler.overs.count == 0) {
            [unusedBowlers addObject:bowler]; 
        };
    }];
    
    NSMutableOrderedSet *bowlers = [self.bowlers mutableCopy];
    [bowlers removeObjectsInArray:unusedBowlers];
    [bowlers reversedOrderedSet];
    
    return (NSOrderedSet *)bowlers;
}

- (double) runRate {
    
    double runRate = 0;
    
    if(self.overs.count){
        Over *currentOver = [self.overs lastObject];
        int totalDeliveries = ((self.overs.count - 1) * 6) + currentOver.deliveries.count;
        runRate = self.inningRuns.doubleValue / totalDeliveries;
    }
    
    return runRate * 6;
}

- (Team *) battingTeam {
    return [Team selectTeam:self.battingTeamID inContext:self.managedObjectContext];
}
- (Team *) bowlingTeam {
    return [Team selectTeam:self.bowlingTeamID inContext:self.managedObjectContext];
}

@end
