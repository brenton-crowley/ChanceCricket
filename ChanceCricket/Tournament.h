//
//  Tournament.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TournamentRound, TournamentTeam;

@interface Tournament : NSManagedObject

@property (nonatomic, retain) NSString * tournamentID;
@property (nonatomic, retain) TournamentRound *currentRound;
@property (nonatomic, retain) NSOrderedSet *tournamentRounds;
@property (nonatomic, retain) NSOrderedSet *tournamentTeams;
@property (nonatomic, retain) TournamentTeam *userTournamentTeam;
@end

@interface Tournament (CoreDataGeneratedAccessors)

- (void)insertObject:(TournamentRound *)value inTournamentRoundsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTournamentRoundsAtIndex:(NSUInteger)idx;
- (void)insertTournamentRounds:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTournamentRoundsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTournamentRoundsAtIndex:(NSUInteger)idx withObject:(TournamentRound *)value;
- (void)replaceTournamentRoundsAtIndexes:(NSIndexSet *)indexes withTournamentRounds:(NSArray *)values;
- (void)addTournamentRoundsObject:(TournamentRound *)value;
- (void)removeTournamentRoundsObject:(TournamentRound *)value;
- (void)addTournamentRounds:(NSOrderedSet *)values;
- (void)removeTournamentRounds:(NSOrderedSet *)values;
- (void)insertObject:(TournamentTeam *)value inTournamentTeamsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTournamentTeamsAtIndex:(NSUInteger)idx;
- (void)insertTournamentTeams:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTournamentTeamsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTournamentTeamsAtIndex:(NSUInteger)idx withObject:(TournamentTeam *)value;
- (void)replaceTournamentTeamsAtIndexes:(NSIndexSet *)indexes withTournamentTeams:(NSArray *)values;
- (void)addTournamentTeamsObject:(TournamentTeam *)value;
- (void)removeTournamentTeamsObject:(TournamentTeam *)value;
- (void)addTournamentTeams:(NSOrderedSet *)values;
- (void)removeTournamentTeams:(NSOrderedSet *)values;
@end
