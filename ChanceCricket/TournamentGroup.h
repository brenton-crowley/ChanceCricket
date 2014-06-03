//
//  TournamentGroup.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Seed, TournamentRound;

@interface TournamentGroup : NSManagedObject

@property (nonatomic, retain) NSNumber * groupID;
@property (nonatomic, retain) NSString * groupName;
@property (nonatomic, retain) TournamentRound *round;
@property (nonatomic, retain) NSSet *seeds;
@end

@interface TournamentGroup (CoreDataGeneratedAccessors)

- (void)addSeedsObject:(Seed *)value;
- (void)removeSeedsObject:(Seed *)value;
- (void)addSeeds:(NSSet *)values;
- (void)removeSeeds:(NSSet *)values;

@end
