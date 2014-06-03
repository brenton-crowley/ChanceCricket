//
//  TournamentTeam.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Seed, Team, Tournament;

@interface TournamentTeam : NSManagedObject

@property (nonatomic, retain) NSNumber * teamID;
@property (nonatomic, retain) Team *team;
@property (nonatomic, retain) Tournament *tournament;
@property (nonatomic, retain) Tournament *userInTourament;
@property (nonatomic, retain) NSSet *seeds;
@end

@interface TournamentTeam (CoreDataGeneratedAccessors)

- (void)addSeedsObject:(Seed *)value;
- (void)removeSeedsObject:(Seed *)value;
- (void)addSeeds:(NSSet *)values;
- (void)removeSeeds:(NSSet *)values;

@end
