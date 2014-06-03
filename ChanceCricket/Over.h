//
//  Over.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Bowler, Delivery, Inning;

@interface Over : NSManagedObject

@property (nonatomic, retain) NSString * overHistory;
@property (nonatomic, retain) NSNumber * overID;
@property (nonatomic, retain) NSNumber * overRuns;
@property (nonatomic, retain) NSNumber * overWickets;
@property (nonatomic, retain) Bowler *bowler;
@property (nonatomic, retain) NSOrderedSet *deliveries;
@property (nonatomic, retain) Inning *inning;
@end

@interface Over (CoreDataGeneratedAccessors)

- (void)insertObject:(Delivery *)value inDeliveriesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromDeliveriesAtIndex:(NSUInteger)idx;
- (void)insertDeliveries:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeDeliveriesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInDeliveriesAtIndex:(NSUInteger)idx withObject:(Delivery *)value;
- (void)replaceDeliveriesAtIndexes:(NSIndexSet *)indexes withDeliveries:(NSArray *)values;
- (void)addDeliveriesObject:(Delivery *)value;
- (void)removeDeliveriesObject:(Delivery *)value;
- (void)addDeliveries:(NSOrderedSet *)values;
- (void)removeDeliveries:(NSOrderedSet *)values;
@end
