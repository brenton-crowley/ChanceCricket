//
//  Inning.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Batsman, Bowler, Match, Over, Wicket;

@interface Inning : NSManagedObject

@property (nonatomic, retain) NSString * battingTeamID;
@property (nonatomic, retain) NSString * bowlingTeamID;
@property (nonatomic, retain) NSNumber * inningID;
@property (nonatomic, retain) NSNumber * inningRuns;
@property (nonatomic, retain) NSOrderedSet *batsmen;
@property (nonatomic, retain) NSOrderedSet *bowlers;
@property (nonatomic, retain) Bowler *currentBowler;
@property (nonatomic, retain) Batsman *currentNonStriker;
@property (nonatomic, retain) Bowler *currentRestingBowler;
@property (nonatomic, retain) Batsman *currentStriker;
@property (nonatomic, retain) Match *match;
@property (nonatomic, retain) NSOrderedSet *overs;
@property (nonatomic, retain) NSOrderedSet *wickets;
@end

@interface Inning (CoreDataGeneratedAccessors)

- (void)insertObject:(Batsman *)value inBatsmenAtIndex:(NSUInteger)idx;
- (void)removeObjectFromBatsmenAtIndex:(NSUInteger)idx;
- (void)insertBatsmen:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeBatsmenAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInBatsmenAtIndex:(NSUInteger)idx withObject:(Batsman *)value;
- (void)replaceBatsmenAtIndexes:(NSIndexSet *)indexes withBatsmen:(NSArray *)values;
- (void)addBatsmenObject:(Batsman *)value;
- (void)removeBatsmenObject:(Batsman *)value;
- (void)addBatsmen:(NSOrderedSet *)values;
- (void)removeBatsmen:(NSOrderedSet *)values;
- (void)insertObject:(Bowler *)value inBowlersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromBowlersAtIndex:(NSUInteger)idx;
- (void)insertBowlers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeBowlersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInBowlersAtIndex:(NSUInteger)idx withObject:(Bowler *)value;
- (void)replaceBowlersAtIndexes:(NSIndexSet *)indexes withBowlers:(NSArray *)values;
- (void)addBowlersObject:(Bowler *)value;
- (void)removeBowlersObject:(Bowler *)value;
- (void)addBowlers:(NSOrderedSet *)values;
- (void)removeBowlers:(NSOrderedSet *)values;
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
