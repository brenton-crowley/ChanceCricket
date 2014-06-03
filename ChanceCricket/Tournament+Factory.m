//
//  Tournament+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tournament+Factory.h"
#import "TournamentRound+Factory.h"

@implementation Tournament (Factory)

#define ENTITY_NAME @"Tournament"

+ (Tournament *) selectTournament:(NSString *)tournamentID 
                        inContext:(NSManagedObjectContext *)context {
    
    Tournament *tournament = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"tournamentID = %@", tournamentID];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tournamentID" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    //    NSLog(@"Game Matches count: %i", matches.count);
    
    if (!matches || ([matches count] > 1)) {
        // handle error
    } else {
        //        NSLog(@"Match already exists in database");
        tournament = [matches lastObject];
    }
    
    return tournament;
}

+ (Tournament *) createTournamentWithTeams:(NSArray *)selectedTeams 
                        setUserTeam:(Team *)userTeam 
                          inContext:(NSManagedObjectContext *)context {
    
    Tournament *tournament = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    tournament.tournamentID = tournament.objectID.URIRepresentation.absoluteString;
    
    //create tournament teams    
    tournament.tournamentTeams = [tournament generateTournamentTeams:selectedTeams setUserTeam:userTeam];
    
    // create rounds
    [tournament generateRounds];
    
    return tournament;
}

- (NSOrderedSet *) generateRounds {
    
    NSOrderedSet *rounds = [[NSOrderedSet alloc] init];
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"data_tournaments.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) plistPath = [[NSBundle mainBundle] pathForResource:@"data_tournaments" ofType:@"plist"];
    
    NSDictionary *tournamentsData = [NSDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:plistPath]];
    if (!tournamentsData) NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    
    NSDictionary *tournments = [tournamentsData objectForKey:@"tournaments"];
    NSDictionary *worldCupTournament = [tournments objectForKey:@"t20WorldCup"];
    NSArray *rawRounds = [worldCupTournament objectForKey:@"rounds"];
    
    for (int i = 0; i < rawRounds.count; i++) {
        NSDictionary *rawRound = [rawRounds objectAtIndex:i];
        // create round
        TournamentRound *tournamentRound = [TournamentRound createTournamentRound:rawRound forTournament:self inContext:self.managedObjectContext];
        NSLog(@"Round: %@", tournamentRound.tournamentRoundName);
    }
    
    return rounds;
}

- (NSOrderedSet *) generateTournamentTeams:(NSArray *)selectedTeams setUserTeam:(Team *)selectedUserTeam {
  
    NSMutableOrderedSet *mutableTeams = [[NSMutableOrderedSet alloc] init];
    
    for (int i = 0; i < selectedTeams.count; i++) {
        Team *selectedTeam = [selectedTeams objectAtIndex:i];
        Team *migratedTeam = [selectedTeam teamForContext:self.managedObjectContext];
        TournamentTeam *tournamentTeam = [TournamentTeam createTournamentTeamFromTeam:migratedTeam inContext:self.managedObjectContext];
        [mutableTeams addObject:tournamentTeam];
        
        if(migratedTeam.teamName == selectedUserTeam.teamName) self.userTournamentTeam = tournamentTeam;
    }
    
    return [mutableTeams copy];
    
}

- (TournamentRound *) getNextRound {
    TournamentRound *nextRound = nil;
    
    // get the current match in the list, and increment 1 to return the next
    NSUInteger targetRoundIndex = [self.tournamentRounds indexOfObject:self.currentRound] + 1;
//    NSUInteger targetRoundIndex = self.tournamentRounds.count;
    
    if(targetRoundIndex < self.tournamentRounds.count) nextRound = [self.tournamentRounds objectAtIndex:targetRoundIndex]; 
    
    return nextRound;
}


@end
