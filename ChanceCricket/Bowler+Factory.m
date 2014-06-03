//
//  Bowler+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Bowler+Factory.h"
#import "Over+Factory.h"

@implementation Bowler (Factory)

+ (Bowler *) addBowlerToInning:(Inning *)inning setPlayer:(Player *)player {
    
    Bowler *bowler = nil;
    bowler = [NSEntityDescription insertNewObjectForEntityForName:@"Bowler" inManagedObjectContext:inning.managedObjectContext];
    bowler.inning = inning;
    bowler.bowlerName = player.playerName;
    bowler.bowlerSurname = player.playerSurname;
    
//    NSLog(@"Bowler ADDED");
    
    return bowler;
}

- (NSNumber *) inningsRuns {
    
    __block int inningsRuns = 0;
    
    [self.overs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        Over *over = obj;
        inningsRuns += over.overRuns.intValue;
    }];
    
    return [NSNumber numberWithInt:inningsRuns];    
}

- (double) economyRate {
        
    double economyRate = 0.00;
    
    if([Over totalDeliveries:self.overs].intValue != 0) economyRate = ([self inningsRuns].doubleValue / [Over totalDeliveries:self.overs].doubleValue) * 6;
    
    return economyRate;
}

@end
