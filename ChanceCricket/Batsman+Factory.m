//
//  Batsman+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Batsman+Factory.h"
#import "Inning+Factory.h"

@implementation Batsman (Factory)

+ (Batsman *) addBatsmanToInning:(Inning *)inning setPlayer:(Player *)player {
    
    Batsman *batsman = nil;
    batsman = [NSEntityDescription insertNewObjectForEntityForName:@"Batsman" inManagedObjectContext:inning.managedObjectContext];
    batsman.batsmanRuns = [NSNumber numberWithInt:0];
    batsman.inning = inning;
    batsman.batsmanName = player.playerName;
    batsman.batsmanSurname = player.playerSurname;
    
    return batsman;
}

- (int) ballsFaced {
    
    int ballsFaced = 0;
    if(self.deliveries.count != 0) ballsFaced = self.deliveries.count;
    return ballsFaced;
    
}

- (double) strikeRate {
    
    double strikeRate = 0.00;
    if(self.deliveries.count != 0) strikeRate = (self.batsmanRuns.doubleValue / self.deliveries.count) * 100.00;
    return strikeRate;
}

@end
