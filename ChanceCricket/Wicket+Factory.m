//
//  Wicket+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Wicket+Factory.h"
#import "Inning+Factory.h"
#import "Batsman+Factory.h"

@implementation Wicket (Factory)

+ (Wicket *) addWicketToInning:(Inning *)inning toBowler:(Bowler *)bowler {
    
    Wicket *wicket = nil;
    wicket = [NSEntityDescription insertNewObjectForEntityForName:@"Wicket" inManagedObjectContext:inning.managedObjectContext];
    wicket.inning = inning;
    wicket.batsman = inning.currentStriker;
    wicket.bowler = bowler;
    NSLog(@"ADD WICKET - Batsman out for: %@ TOTAL WICKETS: %i", wicket.batsman.batsmanRuns, inning.wickets.count);
    
    return wicket;
    //[Over addOverToInning:inning inContext:context];
}

@end
