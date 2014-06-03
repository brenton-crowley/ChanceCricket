//
//  Player+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 03/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Player+Factory.h"

@implementation Player (Factory)

#define ENTITY_NAME @"Player"

+ (Player *) createPlayerFromPlayerInFile:(NSDictionary *)playerFromFile inTeam:(Team *)team inContext:(NSManagedObjectContext *)context {
    
    NSString *forename = [playerFromFile objectForKey:@"forename"];
    NSString *surname = [playerFromFile objectForKey:@"surname"];
    NSString *initialName = [playerFromFile objectForKey:@"initialName"];
    
    Player *player = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    player.playerName = initialName;
    player.playerForename = forename;
    player.playerSurname = surname;
    player.team = team;
    
    return player;
}

+ (Player *) addPlayer:(NSDictionary *)playerFromFile inTeam:(Team *)team inContext:(NSManagedObjectContext *)context {
    
    NSString *playerName = [playerFromFile objectForKey:@"initialName"];
    
    Player *player = nil;   
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"playerName = %@", playerName];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"playerName" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        // handle error
        NSLog(@"Error searching for player");
    } else if ([matches count] == 0) {
        player = [Player createPlayerFromPlayerInFile:playerFromFile inTeam:team inContext:context];
        
        NSLog(@"Player doesn't exist so create him. Player Name: %@", player.playerName);
        
    } else {
        player = [matches lastObject];
//        NSLog(@"Player:  %@ already exists in database", player.playerName);
    }
    
    return  player;
}

+ (Player *) selectPlayer:(NSString *)playerName forTeam:(Team *)team inContext:(NSManagedObjectContext *)context {
    
    Player *player = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"playerName = %@", playerName];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"playerName" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        // handle error
    } else if ([matches count] == 0) {
//        NSLog(@"Player is created");
//        player = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
//        player.playerName = playerName;
//        player.team = team;
        
    } else {
        player = [matches lastObject];
//        NSLog(@"Player:  %@ already exists in database", player.playerName);
    }
    
    return player;
}

- (Player *) playerForTeam:(Team *)team inContext:(NSManagedObjectContext *)context {
    Player *player = [Player selectPlayer:self.playerName forTeam:team inContext:context];
    
    // if no team in this context already, then we'll create one
    if(!player) {
        player = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
        player.playerName = self.playerName;
        player.playerForename = self.playerForename;
        player.playerSurname = self.playerSurname;
        player.team = team;
    }
    
    return player;
}

@end
