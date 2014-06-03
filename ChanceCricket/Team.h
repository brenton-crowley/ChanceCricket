//
//  Team.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 09/04/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Match, Player, TournamentTeam;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * teamID;
@property (nonatomic, retain) NSString * teamName;
@property (nonatomic, retain) NSString * teamShortName;
@property (nonatomic, retain) NSNumber * primaryHex;
@property (nonatomic, retain) NSNumber * secondaryHex;
@property (nonatomic, retain) NSSet *awayMatches;
@property (nonatomic, retain) NSSet *homeMatches;
@property (nonatomic, retain) NSOrderedSet *players;
@property (nonatomic, retain) NSSet *tournamentTeam;
@end

@interface Team (CoreDataGeneratedAccessors)

- (void)addAwayMatchesObject:(Match *)value;
- (void)removeAwayMatchesObject:(Match *)value;
- (void)addAwayMatches:(NSSet *)values;
- (void)removeAwayMatches:(NSSet *)values;

- (void)addHomeMatchesObject:(Match *)value;
- (void)removeHomeMatchesObject:(Match *)value;
- (void)addHomeMatches:(NSSet *)values;
- (void)removeHomeMatches:(NSSet *)values;

- (void)insertObject:(Player *)value inPlayersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPlayersAtIndex:(NSUInteger)idx;
- (void)insertPlayers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePlayersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPlayersAtIndex:(NSUInteger)idx withObject:(Player *)value;
- (void)replacePlayersAtIndexes:(NSIndexSet *)indexes withPlayers:(NSArray *)values;
- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSOrderedSet *)values;
- (void)removePlayers:(NSOrderedSet *)values;
- (void)addTournamentTeamObject:(TournamentTeam *)value;
- (void)removeTournamentTeamObject:(TournamentTeam *)value;
- (void)addTournamentTeam:(NSSet *)values;
- (void)removeTournamentTeam:(NSSet *)values;

@end
