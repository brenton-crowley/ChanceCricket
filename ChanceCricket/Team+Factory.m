//
//  Team+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 03/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Team+Factory.h"
#import "Player+Factory.h"

@implementation Team (Factory)

#define ENTITY_NAME @"Team"

- (void) addPlayer:(NSDictionary *)player inContext:(NSManagedObjectContext *)context {
    
    // run a check to see if the player already exists in the team
    // team contains
    [Player addPlayer:player inTeam:self inContext:context];
}

+ (Team *) createTeamFromTeamInFile:(NSDictionary *)teamFromFile withID:(id)teamIDFromFile inContext:(NSManagedObjectContext *)context {
    
    NSString *teamID = [NSString stringWithFormat:@"%@", teamIDFromFile];
    NSString *teamName = [teamFromFile objectForKey:@"teamName"];
    NSString *shortName = [teamFromFile objectForKey:@"shortName"];
    NSNumber *primaryHex = [teamFromFile objectForKey:@"primaryHex"];
    NSNumber *secondaryHex = [teamFromFile objectForKey:@"secondaryHex"];
//    NSArray *players = [teamFromFile objectForKey:@"players"];
    
    Team *team = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    team.teamID = teamID;
    team.teamName = teamName;
    team.teamShortName = shortName;
    team.primaryHex = primaryHex;
    team.secondaryHex = secondaryHex;
    
    return team;
}

+ (Team *) addTeam:(NSDictionary *)teamFromFile withID:(id)teamID inContext:(NSManagedObjectContext *)context {
    
    Team *team = nil;
    
//    NSString *teamName = [teamFromFile objectForKey:@"teamName"];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"teamID = %@", teamID];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"teamID" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
//    NSLog(@"Team count: %i", matches.count);
    
    if (!matches || ([matches count] > 1)) {
        // handle error
        NSLog(@"Error Fetching the team in the database");
    } else if ([matches count] == 0) {
        team = [Team createTeamFromTeamInFile:teamFromFile withID:(id)teamID inContext:context];
//        NSLog(@"We need to add the team to the database. Team Added: %@", team.teamName);
        
    } else {
        team = [matches lastObject];
//        NSLog(@"Team already exists in database. Existing Team: %@", team.teamName);
    }

    
    return team;
    
}

- (Team *) teamForContext:(NSManagedObjectContext *)context {
    
    // should do some kind of selection first, to check whether the team exists in the document or not
    
    Team *team = [Team selectTeam:self.teamID inContext:context];
    
    // if no team in this context already, then we'll create one
    if(!team) {
        team = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
        team.teamID = self.teamID;
        team.teamName = self.teamName;
        team.teamShortName = self.teamShortName;
        team.primaryHex = self.primaryHex;
        team.secondaryHex = self.secondaryHex;
        
        [self playersForTeam:(Team *)team forContext:context];
    }
    
    return team;
    
}

- (void) playersForTeam:(Team *)forTeam forContext:(NSManagedObjectContext *)context {
        
    for (Player *player in self.players) {
        [player playerForTeam:forTeam inContext:context];
    }    
}

+ (Team *) selectTeam:(id)teamID inContext:(NSManagedObjectContext *)context {
    
    Team *team = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"teamID = %@", teamID];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"teamID" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
//    NSLog(@"Team count: %i", matches.count);
    
    if (!matches || [matches count] != 1) {
        // handle error
//        NSLog(@"Error Selecting  team. Matches found: %i", matches.count);
    }else {
//        NSLog(@"Team already exists in database");
        team = [matches lastObject];
    }
    
    return team;
}

@end
