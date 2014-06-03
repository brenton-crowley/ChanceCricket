//
//  TournamentRound+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TournamentRound.h"
#import "Tournament+Factory.h"
#import "Seed+Factory.h"
#import "TournamentGroup+Factory.h"
#import "TournamentMatch+Factory.h"
#import "Match+Factory.h"
#import "Tournament+Factory.h"

@interface TournamentRound (Factory)

+ (TournamentRound *) createTournamentRound:(NSDictionary *)roundFromFile
                              forTournament:(Tournament *)tournament
                                 inContext:(NSManagedObjectContext *)context;

- (void) seedRoundWithTournamentTeams:(NSOrderedSet *)tournamentTeams;
- (NSOrderedSet *) returnQualifiedTeamsFromPreviousRound:(NSOrderedSet *)groupsFromPreviousRound;
- (TournamentMatch *) getNextMatch;
- (NSOrderedSet *) userMatches;

@end
