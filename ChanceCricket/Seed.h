//
//  Seed.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TournamentGroup, TournamentMatch, TournamentRound, TournamentTeam;

@interface Seed : NSManagedObject

@property (nonatomic, retain) NSNumber * seedID;
@property (nonatomic, retain) NSNumber * seedNumber;
@property (nonatomic, retain) TournamentGroup *group;
@property (nonatomic, retain) NSSet *tMatchAwaySeed;
@property (nonatomic, retain) NSSet *tMatchHomeSeed;
@property (nonatomic, retain) TournamentRound *touramentRound;
@property (nonatomic, retain) TournamentTeam *tournamentTeam;
@end

@interface Seed (CoreDataGeneratedAccessors)

- (void)addTMatchAwaySeedObject:(TournamentMatch *)value;
- (void)removeTMatchAwaySeedObject:(TournamentMatch *)value;
- (void)addTMatchAwaySeed:(NSSet *)values;
- (void)removeTMatchAwaySeed:(NSSet *)values;

- (void)addTMatchHomeSeedObject:(TournamentMatch *)value;
- (void)removeTMatchHomeSeedObject:(TournamentMatch *)value;
- (void)addTMatchHomeSeed:(NSSet *)values;
- (void)removeTMatchHomeSeed:(NSSet *)values;

@end
