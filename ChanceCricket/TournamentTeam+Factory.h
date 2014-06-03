//
//  TournamentTeam+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "TournamentTeam.h"
#import "Team.h"

@interface TournamentTeam (Factory)

+ (TournamentTeam *) createTournamentTeamFromTeam:(Team *)team
                                        inContext:(NSManagedObjectContext *)context;

@end
