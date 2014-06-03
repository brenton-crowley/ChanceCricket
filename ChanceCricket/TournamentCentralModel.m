//
//  TournamentCentrallModel.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "TournamentCentralModel.h"

@implementation TournamentCentralModel

@synthesize tournamentID = _tournamentID;
@synthesize database = _database;
@synthesize tournament = _tournament;
@synthesize matchSimulator = _matchSimulator;

NSString * const TOURNAMENT_UPDATED = @"tournamentUpdated";

- (void) dispatchNotification:(NSString *) identifier {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    NSNotification *notification = [NSNotification notificationWithName:identifier object:self];
    [notificationCenter postNotification: notification];
}

- (void) initTournament:(NSString *)tournamentID {
    self.tournamentID = tournamentID;
    
    [self openFile];
}

- (void) openFile {
    [MatchDatabase openFile:DOCUMENT_TOURNAMENTS usingBlock:^(UIManagedDocument *database) {
        self.database = database;   
        [self setupTournament];
    }];
}

- (void) setupTournament {
    [self dispatchNotification:TOURNAMENT_UPDATED];
}

- (Tournament *) tournament {
    _tournament = [Tournament selectTournament:self.tournamentID inContext:self.database.managedObjectContext];
    return _tournament;
}

- (void) setCurrentMatchToNextScheduledMatch {
    self.tournament.currentRound.currentTournamentMatch = [self.tournament.currentRound getNextMatch];
    [MatchDatabase saveDatabase:self.database usingCompletionBlock:^(UIManagedDocument *database) {
        [self dispatchNotification:TOURNAMENT_UPDATED];
    }];
}

- (void) setCurrentRoundToNextRound {
    
    [MatchDatabase openFile:DOCUMENT_TOURNAMENTS usingBlock:^(UIManagedDocument *database) {
        self.database = database;

        TournamentRound *nextRound = [self.tournament getNextRound];
        NSOrderedSet *qualifiedTournamentTeams = [nextRound returnQualifiedTeamsFromPreviousRound:self.tournament.currentRound.groups];
        [nextRound seedRoundWithTournamentTeams:qualifiedTournamentTeams];
        
        self.tournament.currentRound = nextRound;
        
        [MatchDatabase saveDatabase:self.database usingCompletionBlock:^(UIManagedDocument *database) {
            [self dispatchNotification:TOURNAMENT_UPDATED];
        }];

    }];
    
}

- (void) simulateCurrentMatch {
    NSLog(@"SimulateCurrentMatch in Model");
        
    self.matchSimulator = [[MatchSimulator alloc] initWithMatchID:self.tournament.currentRound.currentTournamentMatch.match.matchID setFilename:DOCUMENT_TOURNAMENTS];
    self.matchSimulator.delegate = self;
    
    [self.matchSimulator start];
    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperations:[NSArray arrayWithObject:self.matchSimulator] waitUntilFinished:NO];
}

- (void) matchSimulator:(MatchSimulator *)matchSimulator didFinishMatch:(Match *)match {
    NSLog(@"Match did complete simulation. WINNING TEAM: %@, Match State of local Match: %@, MatchState In Core Data: %@", [match winningTeam].teamShortName, match.state, self.tournament.currentRound.currentTournamentMatch.match.state);
    
//    matchSimulator = nil;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        [self dispatchNotification:TOURNAMENT_UPDATED];
        [self openFile];
    }];
}


@end
