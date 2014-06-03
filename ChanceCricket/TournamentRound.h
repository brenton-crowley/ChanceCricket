//
//  TournamentRound.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Seed, Tournament, TournamentGroup, TournamentMatch;

@interface TournamentRound : NSManagedObject

@property (nonatomic, retain) NSNumber * tournamentRoundID;
@property (nonatomic, retain) NSString * tournamentRoundName;
@property (nonatomic, retain) NSNumber * matchWinPoints;
@property (nonatomic, retain) NSNumber * matchLossPoints;
@property (nonatomic, retain) NSNumber * matchTiePoints;
@property (nonatomic, retain) TournamentMatch *currentTournamentMatch;
@property (nonatomic, retain) Tournament *currentTRound;
@property (nonatomic, retain) NSOrderedSet *groups;
@property (nonatomic, retain) NSOrderedSet *matches;
@property (nonatomic, retain) NSOrderedSet *seeds;
@property (nonatomic, retain) Tournament *tournament;
@end

@interface TournamentRound (CoreDataGeneratedAccessors)

- (void)insertObject:(TournamentGroup *)value inGroupsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGroupsAtIndex:(NSUInteger)idx;
- (void)insertGroups:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGroupsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGroupsAtIndex:(NSUInteger)idx withObject:(TournamentGroup *)value;
- (void)replaceGroupsAtIndexes:(NSIndexSet *)indexes withGroups:(NSArray *)values;
- (void)addGroupsObject:(TournamentGroup *)value;
- (void)removeGroupsObject:(TournamentGroup *)value;
- (void)addGroups:(NSOrderedSet *)values;
- (void)removeGroups:(NSOrderedSet *)values;
- (void)insertObject:(TournamentMatch *)value inMatchesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMatchesAtIndex:(NSUInteger)idx;
- (void)insertMatches:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMatchesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMatchesAtIndex:(NSUInteger)idx withObject:(TournamentMatch *)value;
- (void)replaceMatchesAtIndexes:(NSIndexSet *)indexes withMatches:(NSArray *)values;
- (void)addMatchesObject:(TournamentMatch *)value;
- (void)removeMatchesObject:(TournamentMatch *)value;
- (void)addMatches:(NSOrderedSet *)values;
- (void)removeMatches:(NSOrderedSet *)values;
- (void)insertObject:(Seed *)value inSeedsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSeedsAtIndex:(NSUInteger)idx;
- (void)insertSeeds:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSeedsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSeedsAtIndex:(NSUInteger)idx withObject:(Seed *)value;
- (void)replaceSeedsAtIndexes:(NSIndexSet *)indexes withSeeds:(NSArray *)values;
- (void)addSeedsObject:(Seed *)value;
- (void)removeSeedsObject:(Seed *)value;
- (void)addSeeds:(NSOrderedSet *)values;
- (void)removeSeeds:(NSOrderedSet *)values;
@end
