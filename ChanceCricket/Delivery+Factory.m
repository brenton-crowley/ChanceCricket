//
//  Delivery+Handling.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 27/02/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Delivery+Factory.h"
#import "Over+Factory.h"

@interface Delivery(Handling)

+ (Delivery *) addDeliveryToOver:(Over *)over withRuns:(int)runs withWicket:(int)wicket defineName:(NSString *)name;

@end

@implementation Delivery (Handling)

#define ENTITY_NAME @"Delivery"

+ (Delivery *) addDeliveryToOver:(Over *) over withRuns:(int) runs{
    
    return [Delivery addDeliveryToOver:over withRuns:runs withWicket:0 defineName:[NSString stringWithFormat:@"%i", runs]];
}
+ (Delivery *) addDeliveryWicketToOver:(Over *) over{
    
    return [Delivery addDeliveryToOver:over withRuns:0 withWicket:1 defineName:@"W"];
}
+ (Delivery *) addDeliveryDotBallToOver:(Over *) over{
    return [Delivery addDeliveryToOver:over withRuns:0 withWicket:0 defineName:@"."];
}

+ (Delivery *) addDeliveryToOver:(Over *)over withRuns:(int)runs withWicket:(int)wicket defineName:(NSString *)name {
    
    Delivery *delivery = nil;
    delivery = [NSEntityDescription insertNewObjectForEntityForName:@"Delivery" inManagedObjectContext:over.managedObjectContext];
    delivery.deliveryID = [NSNumber numberWithInt: [[NSString stringWithFormat:@"%i%i", over.overID.intValue, (over.deliveries.count + 1)] intValue]];
    delivery.deliveryRuns = [NSNumber numberWithInt:runs];
    delivery.deliveryName = name;
    delivery.isWicket = wicket == 0 ? [NSNumber numberWithBool:NO] : [NSNumber numberWithBool:YES];
    delivery.isLegal = [NSNumber numberWithBool:YES];
    delivery.over = over;
    
    [over update];
    
    return delivery;
}

@end
