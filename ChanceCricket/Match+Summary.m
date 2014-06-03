//
//  Match+Validation.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Match+Summary.h"
#import "Match+Factory.h"
#import "MatchSettings.h"
#import "Match.h"
#import "Inning+Factory.h"
#import "Over+Factory.h"
#import "Team+Factory.h"

@implementation Match (Summary)

- (NSString *) formattedScore {
    return [NSString stringWithFormat:@"%i / %i", self.currentInnings.wickets.count, self.currentInnings.inningRuns.intValue];
}

- (NSString *) completedSummary {
    NSString *summary;
    if([self winningTeam]){
        if ([[self winningTeam].teamID isEqualToString:self.homeTeam.teamID]) {
            // home team won by runs
            NSInteger runsWonBy = [self aggregatedScoreFromInnings:[self homeInnings]] - [self aggregatedScoreFromInnings:[self awayInnings]];
            summary = [NSString stringWithFormat:@"%@ defeated %@ by %i runs.", self.homeTeam.teamName, self.awayTeam.teamName, runsWonBy];
        }else{
            // away team won by wickets
            Inning *awayInning = [[self awayInnings] lastObject];
            NSInteger wicketsWonBy = self.matchSettings.wicketLimit.integerValue - awayInning.wickets.count;
            summary = [NSString stringWithFormat:@"%@ defeated %@ by %i wickets.", self.awayTeam.teamName, self.homeTeam.teamName, wicketsWonBy];
        }
    }else{
        summary = [NSString stringWithFormat:@"Match between %@ and %@ was tied.", self.homeTeam.teamName, self.awayTeam.teamName];
    }
    return summary;
}

- (NSString *) inProgressSummary {
    
    Inning *inning = self.currentInnings;
    Team *team = [Team selectTeam:inning.battingTeamID inContext:self.managedObjectContext];
    
    NSString *summary = [NSString stringWithFormat:@"%@ is currently %@ from %@", team.teamName, [self formattedScore], [Over fullFormattedStringForOvers:inning.overs]];
    
    return summary;
}

- (NSString *) matchSummary {
    NSString *summary;
    
    if([self.state isEqualToString:MATCH_STATE_COMPLETED]){
        summary = [self completedSummary];
    }else if ([self.state isEqualToString:MATCH_STATE_IN_PROGRESS]) {
        summary = [self inProgressSummary];
    }else{
        summary = @"";
    }
    
    return summary;
}

- (NSArray *) homeInnings {
    
    NSMutableArray *homeInnings = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < self.innings.count; i++) {
        Inning *inning = [self.innings objectAtIndex:i];
        if([inning.battingTeamID isEqualToString:self.homeTeam.teamID]){
            [homeInnings addObject:inning];
        }
    }
    
    return [homeInnings copy];
}

- (NSArray *) awayInnings {
    
    NSMutableArray *awayInnings = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < self.innings.count; i++) {
        Inning *inning = [self.innings objectAtIndex:i];
        if([inning.battingTeamID isEqualToString:self.awayTeam.teamID]) [awayInnings addObject:inning];
    }
    return [awayInnings copy];
}

- (NSUInteger) aggregatedScoreFromInnings:(NSArray *)innings {
    
    NSUInteger aggregatedScore = 0;
    
    for (int i = 0 ; i < innings.count; i++) {
        Inning *inning = [innings objectAtIndex:i];
        aggregatedScore += inning.inningRuns.integerValue;
    }
    
    return aggregatedScore;
}

- (NSArray *) winningInnings {
    
    NSArray *winningsInnings = [[NSMutableArray alloc] init];
    if([self winningTeam]){        
        NSArray *homeInnings = [self homeInnings];
        NSArray *awayInnings = [self awayInnings];

        winningsInnings = [self aggregatedScoreFromInnings:homeInnings] > [self aggregatedScoreFromInnings:awayInnings] ? homeInnings : awayInnings; 
    }
    
    return winningsInnings;
}

- (Team *) winningTeam {
    
    Team *winningTeam = nil;
            
//    NSLog(@"Home Innings: %i", [self homeInnings].count);
//    NSLog(@"Away Innings: %i", [self awayInnings].count);
    
//    NSLog(@"Home Aggregated Score: %i", [self aggregatedScoreFromInnings:[self homeInnings]]);
//    NSLog(@"Away Aggregated Score: %i", [self aggregatedScoreFromInnings:[self awayInnings]]);
    
    NSUInteger homeScore = [self aggregatedScoreFromInnings:[self homeInnings]];
    NSUInteger awayScore = [self aggregatedScoreFromInnings:[self awayInnings]];
    
    if(homeScore > awayScore) winningTeam = self.homeTeam;
    else if (awayScore > homeScore) winningTeam = self.awayTeam;
    
    return winningTeam;
}

- (int) targetScore {
    
    int targetScore = 0;
    
    if(self.innings.count == self.matchSettings.inningsLimit.intValue){
        Inning *firstInning = [self.innings objectAtIndex:0];
        targetScore = firstInning.inningRuns.intValue;
    }
    
    return targetScore;
}

- (double) runRate:(Inning *)inning {
    
    double runRate = 0;
    
    if(inning.overs.count){
        Over *currentOver = [inning.overs lastObject];
        int totalDeliveries = ((inning.overs.count - 1) * 6) + currentOver.deliveries.count;
        runRate = inning.inningRuns.doubleValue / totalDeliveries;
    }
    
    return runRate * 6;
}

@end
