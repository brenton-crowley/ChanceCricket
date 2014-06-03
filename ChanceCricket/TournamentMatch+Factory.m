//
//  TournamentMatch+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TournamentMatch+Factory.h"

@implementation TournamentMatch (Factory)

#define ENTITY_NAME @"TournamentMatch"

+ (TournamentMatch *) createMatchForRound:(TournamentRound *)tournmentRound {
    
    TournamentMatch *tournamentMatch = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:tournmentRound.managedObjectContext];
    tournamentMatch.matchID = tournamentMatch.objectID.URIRepresentation.absoluteString;
    tournamentMatch.round = tournmentRound;
    
    // default to first created match in round
    if(tournamentMatch.round.matches.count == 1) {
        tournamentMatch.round.currentTournamentMatch = tournamentMatch;
    }
    return tournamentMatch;
}

@end
