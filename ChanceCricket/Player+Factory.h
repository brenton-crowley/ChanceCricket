//
//  Player+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 03/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Player.h"

@interface Player (Factory)

+ (Player *) createPlayerFromPlayerInFile:(NSDictionary *)playerFromFile inTeam:(Team *)team inContext:(NSManagedObjectContext *)context;
+ (Player *) addPlayer:(NSDictionary *)playerFromFile inTeam:(Team *)team inContext:(NSManagedObjectContext *)context;

+ (Player *) selectPlayer:(NSString *)playerName forTeam:(Team *)team inContext:(NSManagedObjectContext *)context;

- (Player *) playerForTeam:(Team *)team inContext:(NSManagedObjectContext *)context;

@end
