//
//  TournamentGroup+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TournamentGroup.h"
#import "Seed+Factory.h"

@interface TournamentGroup (Factory)

+ (TournamentGroup *) createGroupForRound:(TournamentRound *)tournmentRound;

- (NSOrderedSet *) seedsOrderedByGroupRanking;

@end
