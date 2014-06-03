//
//  Bowler.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Inning, Over, Wicket;

@interface Bowler : NSManagedObject

@property (nonatomic, retain) NSString * bowlerName;
@property (nonatomic, retain) NSString * bowlerSurname;
@property (nonatomic, retain) Inning *currentBowlerInning;
@property (nonatomic, retain) Inning *currentRestingBowlerInning;
@property (nonatomic, retain) Inning *inning;
@property (nonatomic, retain) NSOrderedSet *overs;
@property (nonatomic, retain) NSOrderedSet *wickets;
@end

@interface Bowler (CoreDataGeneratedAccessors)

- (void)insertObject:(Over *)value inOversAtIndex:(NSUInteger)idx;
- (void)removeObjectFromOversAtIndex:(NSUInteger)idx;
- (void)insertOvers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeOversAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInOversAtIndex:(NSUInteger)idx withObject:(Over *)value;
- (void)replaceOversAtIndexes:(NSIndexSet *)indexes withOvers:(NSArray *)values;
- (void)addOversObject:(Over *)value;
- (void)removeOversObject:(Over *)value;
- (void)addOvers:(NSOrderedSet *)values;
- (void)removeOvers:(NSOrderedSet *)values;
- (void)insertObject:(Wicket *)value inWicketsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromWicketsAtIndex:(NSUInteger)idx;
- (void)insertWickets:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeWicketsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInWicketsAtIndex:(NSUInteger)idx withObject:(Wicket *)value;
- (void)replaceWicketsAtIndexes:(NSIndexSet *)indexes withWickets:(NSArray *)values;
- (void)addWicketsObject:(Wicket *)value;
- (void)removeWicketsObject:(Wicket *)value;
- (void)addWickets:(NSOrderedSet *)values;
- (void)removeWickets:(NSOrderedSet *)values;
@end
