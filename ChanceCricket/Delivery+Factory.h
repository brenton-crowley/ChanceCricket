//
//  Delivery+Handling.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 27/02/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Delivery.h"

@interface Delivery (Factory)

+ (Delivery *) addDeliveryToOver:(Over *)over withRuns:(int) runs;
+ (Delivery *) addDeliveryWicketToOver:(Over *)over;
+ (Delivery *) addDeliveryDotBallToOver:(Over *)over;

@end
