//
//  Over+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 27/02/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Over+Factory.h"
#import "Inning+Factory.h"
#import "Delivery+Factory.h"

@implementation Over (Factory)

#define ENTITY_NAME @"Over"

+ (void) addOverToInning:(Inning *) inning toBowler:(Bowler *)bowler {
    
    Over *over = nil;
    over = [NSEntityDescription insertNewObjectForEntityForName:@"Over" inManagedObjectContext:inning.managedObjectContext];
    over.overID = [NSNumber numberWithInt: [[NSString stringWithFormat:@"%i%i", inning.inningID.intValue, (inning.overs.count + 1)] intValue]];
    
    over.overRuns = 0;
    over.overWickets = 0;
    over.inning = inning;
    over.overHistory = [NSString stringWithFormat:@""];
    over.bowler = bowler;
    
    NSLog(@"Add Over ID: %i", over.overID.intValue);
    
    //[Delivery addDeliveryToOver:over inContext:context];
}

- (void) update {
    Delivery *delivery = [self.deliveries lastObject];
    if(delivery.isWicket.boolValue) self.overWickets = [NSNumber numberWithInt: self.overWickets.intValue + 1];
    self.overRuns = [NSNumber numberWithInt: self.overRuns.intValue + delivery.deliveryRuns.intValue];
    self.overHistory = [self.overHistory stringByAppendingString:delivery.deliveryName];
//    NSLog(@"Runs in Over: %i", self.overRuns.intValue);
    
//    NSLog(@"Over History: %@", self.overHistory);
    [self.inning update];
    
}

+ (NSString *) fullFormattedStringForOvers:(NSOrderedSet *)overs {
    
    int oversNumber = 0;
    int deliveriesNumber = 0;

    if(overs.count){
        
        oversNumber = overs.count;
        deliveriesNumber = ((Over *)[overs lastObject]).deliveries.count;
        if(deliveriesNumber == 6)deliveriesNumber = 0;
        else oversNumber -= 1;
    }
    
    
    return [NSString stringWithFormat:@"%i.%i", oversNumber, deliveriesNumber];
}

+ (NSString *) shortFormattedStringForOvers:(NSOrderedSet *)overs {
    
    int oversNumber = 0;
    int deliveriesNumber = 0;
    
    if(overs.count){
        oversNumber = overs.count;
        deliveriesNumber = ((Over *)[overs lastObject]).deliveries.count;
        
        if(deliveriesNumber == 6)deliveriesNumber = 0;
        else oversNumber -= 1;
    }
    
    
    
    NSString *formattedString = deliveriesNumber != 0 ? [NSString stringWithFormat:@"%i.%i", oversNumber, deliveriesNumber] : [NSString stringWithFormat:@"%i", oversNumber];
    
    return formattedString;
}

+ (NSNumber *) totalDeliveries:(NSOrderedSet *)overs {
    
    __block int deliveries = 0;
    
    if(overs.count != 0) {
        [overs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            Over *over = obj;
            deliveries += over.deliveries.count;
        }];
    }
    
    return [NSNumber numberWithInt:deliveries];
}

@end
