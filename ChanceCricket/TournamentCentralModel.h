//
//  TournamentCentrallModel.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchDatabase.h"
#import "Tournament+Factory.h"
#import "TournamentRound+Factory.h"
#import "MatchSimulator.h"
#import "Match+Summary.h"
#import "Settings.h"

@interface TournamentCentralModel : NSObject <MatchSimulatorDelegate>

extern NSString * const TOURNAMENT_UPDATED;

@property (nonatomic, strong) NSString *tournamentID;
@property (nonatomic, strong) UIManagedDocument *database;
@property (nonatomic, strong) Tournament *tournament;
@property (nonatomic, strong) MatchSimulator *matchSimulator;

- (void) initTournament:(NSString *)tournamentID;
- (void) setCurrentMatchToNextScheduledMatch;
- (void) setCurrentRoundToNextRound;
- (void) simulateCurrentMatch;

@end
