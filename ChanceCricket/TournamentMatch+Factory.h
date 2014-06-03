//
//  TournamentMatch+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TournamentMatch.h"
#import "TournamentRound+Factory.h"

@interface TournamentMatch (Factory)

+ (TournamentMatch *) createMatchForRound:(TournamentRound *)tournmentRound;

@end
