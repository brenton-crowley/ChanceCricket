//
//  Seed+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Seed.h"
#import "TournamentMatch.h"
#import "Match+Factory.h"
#import "Match+Summary.h"
#import "TournamentTeam+Factory.h"
#import "Team+Factory.h"
#import "TournamentRound+Factory.h"
#import "Inning+Factory.h"
#import "MatchSettings.h"
#import "Over+Factory.h"

@interface Seed (Factory)

+ (Seed *) createSeedForRound:(TournamentRound *)tournmentRound;


- (NSInteger) numberOfMatchesPlayed;
- (NSInteger) numberOfWins;
- (NSInteger) numberOfLosses;
- (NSInteger) numberOfTies;
- (NSInteger) numberOfPoints;
- (double) netRunRate;

@end
