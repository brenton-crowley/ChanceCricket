//
//  Tournament+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tournament.h"
#import "Team.h"
#import "TournamentTeam+Factory.h"

@interface Tournament (Factory)

+ (Tournament *) createTournamentWithTeams:(NSArray *)selectedTeams 
                               setUserTeam:(Team *)userTeam 
                                 inContext:(NSManagedObjectContext *)context;

+ (Tournament *) selectTournament:(NSString *)tournamentID 
                        inContext:(NSManagedObjectContext *)context;

- (TournamentRound *) getNextRound;

@end
