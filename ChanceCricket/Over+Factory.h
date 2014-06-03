//
//  Over+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 27/02/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Over.h"

@interface Over (Factory)

+ (NSString *) fullFormattedStringForOvers:(NSOrderedSet *)overs;
+ (NSString *) shortFormattedStringForOvers:(NSOrderedSet *)overs;
+ (NSNumber *) totalDeliveries:(NSOrderedSet *)overs;

+ (void) addOverToInning:(Inning *) inning toBowler:(Bowler *)bowler;
- (void) update;

@end
