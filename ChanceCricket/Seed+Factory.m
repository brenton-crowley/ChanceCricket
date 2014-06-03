//
//  Seed+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Seed+Factory.h"

@implementation Seed (Factory)

#define ENTITY_NAME @"Seed"

+ (Seed *) createSeedForRound:(TournamentRound *)tournmentRound {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"seedID" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [tournmentRound.managedObjectContext executeFetchRequest:request error:&error];
    
    NSNumber *seedID = [NSNumber numberWithInt:matches.count + 1];
    
    Seed *seed = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:tournmentRound.managedObjectContext];
    seed.seedID = seedID;
    
    return seed;
}

- (NSArray *) playedMatchesForSet:(NSSet *)set {
    
    NSMutableArray *playedMatches = [[NSMutableArray alloc] init];
    int i = 0;
    NSOrderedSet *homeMatches = [NSOrderedSet orderedSetWithSet:set];
    while (i < homeMatches.count) {
        TournamentMatch *tournamentMatch = [homeMatches objectAtIndex:i];
        if([tournamentMatch.match.state isEqualToString:MATCH_STATE_COMPLETED]) [playedMatches addObject:tournamentMatch];
        i++;
    }
    
    return [playedMatches copy];
}

- (NSArray *) playedHomeMatches {
    return [self playedMatchesForSet:self.tMatchHomeSeed];
}

- (NSArray *) playedAwayMatches {
    return [self playedMatchesForSet:self.tMatchAwaySeed];
}

- (NSArray *) playedMatches {
    
    NSMutableArray *playedMatches = [NSMutableArray arrayWithArray:[self playedHomeMatches]];
    [playedMatches addObjectsFromArray:[self playedAwayMatches]];
    
    return [playedMatches copy];
}

- (NSInteger) numberOfMatchesPlayed {
    NSInteger numberOfMatchesPlayed = [self playedMatches].count;
    return numberOfMatchesPlayed;
}

- (NSInteger) numberOfWins {
    
    NSInteger numberOfWins = 0;
    
    int length = [self playedMatches].count;
    for (int i = 0; i < length; i++) {
        TournamentMatch *tournamentMatch = [[self playedMatches] objectAtIndex:i];
        if([tournamentMatch.match winningTeam] && [[tournamentMatch.match winningTeam] isEqual:self.tournamentTeam.team]) numberOfWins++;
    }
    
    return numberOfWins;
    
}

- (NSInteger) numberOfLosses {
    
    NSInteger numberOfLosses = 0;
    
    int length = [self playedMatches].count;
    for (int i = 0; i < length; i++) {
        TournamentMatch *tournamentMatch = [[self playedMatches] objectAtIndex:i];
        if([tournamentMatch.match winningTeam] && ![[tournamentMatch.match winningTeam] isEqual:self.tournamentTeam.team]) numberOfLosses++;
    }
    
    return numberOfLosses;
    
}

- (NSInteger) numberOfTies {
    
    NSInteger numberOfTies = 0;
    
    int length = [self playedMatches].count;
    for (int i = 0; i < length; i++) {
        TournamentMatch *tournamentMatch = [[self playedMatches] objectAtIndex:i];
        if(![tournamentMatch.match winningTeam]) numberOfTies++;
    }
    
    return numberOfTies;
    
}

- (NSInteger) numberOfPoints {
    
    NSInteger winPoints = [self numberOfWins] * self.touramentRound.matchWinPoints.integerValue;
    NSInteger tiePoints = [self numberOfTies] * self.touramentRound.matchTiePoints.integerValue;
    
    NSInteger numberOfPoints = winPoints + tiePoints;
    
    return numberOfPoints;
    
}

- (NSArray *) matchInningsAreBatting:(BOOL)isForBatting {
    
    NSMutableArray *innings = [[NSMutableArray alloc] init];
    
    int length = [self playedMatches].count;
    for (int i = 0; i < length; i++) {
        TournamentMatch *tournamentMatch = [[self playedMatches] objectAtIndex:i];
        for (Inning *inning in tournamentMatch.match.innings) {
            NSString *inningType = isForBatting ? inning.battingTeamID : inning.bowlingTeamID;
            if([inningType  isEqualToString:self.tournamentTeam.team.teamID]) [innings addObject:inning];
        }
    }
    return [innings copy];
}

- (NSInteger) netRunRateTotalRunsFromInnings:(NSArray *)innings {

    NSInteger runsFromInning = 0;
    
    for (int i = 0; i < innings.count; i++) {
        Inning *inning = [innings objectAtIndex:i];
        runsFromInning += inning.inningRuns.integerValue;
    }
    
//        NSLog(@"Total NRR Runs from innings: %i", runsFromInning);
    
    return runsFromInning;
}

- (double) netRunRateTotalOversForInnings:(NSArray *)innings {
    
    double oversFromInning = 0;
    
    for (int i = 0; i < innings.count; i++) {
        Inning *inning = [innings objectAtIndex:i];
        if(inning.wickets.count == inning.match.matchSettings.wicketLimit.integerValue) oversFromInning += inning.match.matchSettings.inningOverLimit.integerValue;
        else {
            Over *lastOver = [inning.overs lastObject];
            oversFromInning += inning.overs.count - 1 + (lastOver.deliveries.count / 6.0); 
        }
    }
//    NSLog(@"Total NRR overs from innings: %0.2f", oversFromInning);
    return oversFromInning;
}

- (double) forTotalOversFromInnings {
    return [self netRunRateTotalOversForInnings:[self matchInningsAreBatting:YES]];
}

- (NSInteger) forTotalRunsFromInnings {
    return [self netRunRateTotalRunsFromInnings:[self matchInningsAreBatting:YES]];
}

- (double) againstTotalOversFromInnings {
    return [self netRunRateTotalOversForInnings:[self matchInningsAreBatting:NO]];
}

- (NSInteger) againstTotalRunsFromInnings {
    return [self netRunRateTotalRunsFromInnings:[self matchInningsAreBatting:NO]];
}

- (double) netRunRate {
    
    double forRate = [self forTotalRunsFromInnings] / [self forTotalOversFromInnings];
    double againstRate = [self againstTotalRunsFromInnings] / [self againstTotalOversFromInnings];
    
    double netRunRate = forRate - againstRate;
    
    return !isnan(netRunRate) ? netRunRate : 0;
    
}


@end
