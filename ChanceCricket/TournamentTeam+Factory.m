//
//  TournamentTeam+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "TournamentTeam+Factory.h"

@implementation TournamentTeam (Factory)

#define ENTITY_NAME @"TournamentTeam"

+ (TournamentTeam *) createTournamentTeamFromTeam:(Team *)team
                    inContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"teamID" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    NSNumber *tournamentTeamID = [NSNumber numberWithInt:matches.count + 1];
    
    TournamentTeam *tournamentTeam = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    tournamentTeam.teamID = tournamentTeamID;
    tournamentTeam.team = team;
    
//    NSLog(@"Create Tournament Team: %@", tournamentTeam.team.teamName);
    
    return tournamentTeam;
}

@end
