//
//  Batsman.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Delivery, Inning, Wicket;

@interface Batsman : NSManagedObject

@property (nonatomic, retain) NSString * batsmanName;
@property (nonatomic, retain) NSNumber * batsmanRuns;
@property (nonatomic, retain) NSString * batsmanSurname;
@property (nonatomic, retain) NSOrderedSet *deliveries;
@property (nonatomic, retain) Inning *inning;
@property (nonatomic, retain) Inning *nonStrikeInning;
@property (nonatomic, retain) Inning *strikeInning;
@property (nonatomic, retain) Wicket *wicket;
@end

@interface Batsman (CoreDataGeneratedAccessors)

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
