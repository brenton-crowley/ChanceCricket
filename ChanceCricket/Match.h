//
//  Match.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Inning, MatchSettings, Team, TournamentMatch;

@interface Match : NSManagedObject

@property (nonatomic, retain) NSString * matchID;
@property (nonatomic, retain) id metadata;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) Team *awayTeam;
@property (nonatomic, retain) Team *homeTeam;
@property (nonatomic, retain) NSOrderedSet *innings;
@property (nonatomic, retain) MatchSettings *matchSettings;
@property (nonatomic, retain) TournamentMatch *tournamentMatch;
@end

@interface Match (CoreDataGeneratedAccessors)

- (void)insertObject:(Inning *)value inInningsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromInningsAtIndex:(NSUInteger)idx;
- (void)insertInnings:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeInningsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInInningsAtIndex:(NSUInteger)idx withObject:(Inning *)value;
- (void)replaceInningsAtIndexes:(NSIndexSet *)indexes withInnings:(NSArray *)values;
- (void)addInningsObject:(Inning *)value;
- (void)removeInningsObject:(Inning *)value;
- (void)addInnings:(NSOrderedSet *)values;
- (void)removeInnings:(NSOrderedSet *)values;
@end
