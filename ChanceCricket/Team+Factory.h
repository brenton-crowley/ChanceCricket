//
//  Team+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 03/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Team.h"

@interface Team (Factory)

+ (Team *) addTeam:(NSDictionary *)teamFromFile withID:(id)teamID inContext:(NSManagedObjectContext *)context;
+ (Team *) selectTeam:(id)teamID inContext:(NSManagedObjectContext *)context;

- (void) addPlayer:(NSDictionary *)player inContext:(NSManagedObjectContext *)context;
- (Team *) teamForContext:(NSManagedObjectContext *)context;

@end
