//
//  TournamentRound+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TournamentRound+Factory.h"

@implementation TournamentRound (Factory)

#define ENTITY_NAME @"TournamentRound"

+ (TournamentRound *) createTournamentRound:(NSDictionary *)roundFromFile
                              forTournament:(Tournament *)tournament
                                  inContext:(NSManagedObjectContext *)context {
  
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"tournamentRoundID" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    NSNumber *tournamentRoundID = [NSNumber numberWithInt:matches.count + 1];
    NSString *tournamentRoundName = [NSString stringWithFormat:@"%@", [roundFromFile valueForKey:@"roundName"]];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSUInteger seeds = [numberFormatter numberFromString:[NSString stringWithFormat:@"%@", [roundFromFile objectForKey:@"seeds"]]].integerValue;
    
    // properties
    TournamentRound *tournamentRound = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    tournamentRound.tournamentRoundID = tournamentRoundID;
    tournamentRound.tournamentRoundName = tournamentRoundName;
    tournamentRound.tournament = tournament;
    
    NSDictionary *pointValues = [roundFromFile objectForKey:@"points"];
    // point values for matched
    tournamentRound.matchWinPoints = [pointValues objectForKey:@"win"];
    tournamentRound.matchLossPoints = [pointValues objectForKey:@"loss"];
    tournamentRound.matchTiePoints = [pointValues objectForKey:@"tie"];
    
    NSLog(@"Round: %@", tournamentRound.tournamentRoundName);
    NSLog(@"Win Value: %@, Loss Value: %@, Tie Value: %@", tournamentRound.matchWinPoints, tournamentRound.matchLossPoints, tournamentRound.matchTiePoints);
    
    // relationships
    tournamentRound.seeds = [tournamentRound generateSeeds:seeds];
    tournamentRound.groups = [tournamentRound generateGroups:[roundFromFile valueForKey:@"groups"]]; 
    tournamentRound.matches = [tournamentRound generateMatches:[roundFromFile valueForKey:@"matches"]];
    
    // default to the first created round
    if(tournamentRound.tournament.tournamentRounds.count == 1) {
        tournament.currentRound = tournamentRound;
        [tournamentRound seedRoundWithTournamentTeams:tournament.tournamentTeams];
    }
    
    return tournamentRound;
}

- (NSOrderedSet *) generateSeeds:(NSUInteger)nSeeds{
    
    NSMutableOrderedSet *mutableSeeds = [[NSMutableOrderedSet alloc] init];
    
    for (int i = 0; i < nSeeds; i++) {
        Seed *seed = [Seed createSeedForRound:self];
        seed.seedNumber = [NSNumber numberWithInteger:i + 1];
        
        [mutableSeeds addObject:seed];
    }
        
    return [mutableSeeds copy];
}

- (NSOrderedSet *) generateGroups:(NSDictionary *)groups{
    
    NSMutableOrderedSet *mutableGroups = [[NSMutableOrderedSet alloc] init];
    
    for (id groupKey in groups) {
        NSArray *rawGroup = [groups objectForKey:groupKey];

        TournamentGroup *group = [TournamentGroup createGroupForRound:self];
        group.groupName = groupKey;
        // we need to add a seed to the groups
        for (int i = 0; i < rawGroup.count; i++) {
            NSNumber *seedNumber = [rawGroup objectAtIndex:i];
            Seed *seed = [self.seeds objectAtIndex:seedNumber.integerValue - 1];
            seed.group = group; 
        }
        [mutableGroups addObject:group];
    }
    
    return [self sortsGroups:[mutableGroups copy]];
}

- (NSOrderedSet *) sortsGroups:(NSOrderedSet *)groups {
    
    NSComparator comparator = ^(TournamentGroup *groupOne, TournamentGroup* groupTwo) {
        
        NSString *rank1 = groupOne.groupName;
        NSString *rank2 = groupTwo.groupName;  
        NSComparisonResult result = (NSComparisonResult)[rank1 compare:rank2];
        return result;
    };    
    NSArray *sortedArray = [NSArray arrayWithArray:[groups sortedArrayUsingComparator:comparator]];
    return [NSOrderedSet orderedSetWithArray:sortedArray];
    
}

- (NSOrderedSet *) generateMatches:(NSArray *)matches{
        
    NSMutableOrderedSet *mutableMatches = [[NSMutableOrderedSet alloc] init];
    
    for (int i = 0; i < matches.count; i++) {
        NSDictionary *rawMatch = [matches objectAtIndex:i];
        
        Seed *homeSeed = [self.seeds objectAtIndex:((NSNumber *)[rawMatch valueForKey:@"home"]).integerValue - 1];
        Seed *awaySeed = [self.seeds objectAtIndex:((NSNumber *)[rawMatch valueForKey:@"away"]).integerValue - 1];
        
        TournamentMatch *match = [TournamentMatch createMatchForRound:self];
        match.homeSeed = homeSeed;
        match.awaySeed = awaySeed;
        match.matchNumber = [NSNumber numberWithInt:i + 1];
        
//        NSLog(@"Match %@ - Home Team: %@", match.matchID, match.homeSeed.tournamentTeam.team.teamShortName);
//        NSLog(@"Match %@ - Away Team: %@", match.matchID, match.awaySeed.tournamentTeam.team.teamShortName);
        NSLog(@"Match Created ID: %@, Home Team Seed: %@ vs. Away Team Seed: %@", match.matchID, match.homeSeed.seedNumber, match.awaySeed.seedNumber);
        
        [mutableMatches addObject:match];
    }
    
    return [mutableMatches copy];
}

// seed the round with an ordered list of tournament teams
// get the list of seeds in the round in numerical order. Then associate each seeds with a tournament team.
// make sure that the list of tournament teams that are being passes in match the number of seeds in the round

- (void) seedRoundWithTournamentTeams:(NSOrderedSet *)tournamentTeams {
    
    if(tournamentTeams.count != self.seeds.count){
        NSException *exception = [NSException exceptionWithName:@"Invalid Number of Teams" reason:@"Number of TournamentTeams must match the number of seeds in the round" userInfo:nil];
        [exception raise];
    }
    
    for (int i = 0; i < self.seeds.count; i++) {
        Seed *seed = [self.seeds objectAtIndex:i];
        TournamentTeam *tournamentTeam = [tournamentTeams objectAtIndex:seed.seedNumber.integerValue - 1];
        seed.tournamentTeam = tournamentTeam;
    }
    
    [self createMatchesInTournamentMatches];
}

- (void) createMatchesInTournamentMatches {
    for (TournamentMatch *tournamentMatch in self.matches) {
        if(!tournamentMatch.match){
            tournamentMatch.match = [Match createMatchWithHomeTeam:tournamentMatch.homeSeed.tournamentTeam.team andAwayTeam:tournamentMatch.awaySeed.tournamentTeam.team inContext:self.managedObjectContext];
            tournamentMatch.match.state = MATCH_STATE_SCHEDULED;
        }
    }
}


- (TournamentMatch *) getNextMatch {
    TournamentMatch *nextMatch = nil;
    
    // get the current match in the list, and increment 1 to return the next
    NSUInteger targetMatchIndex = [self.matches indexOfObject:self.currentTournamentMatch] + 1;
//    NSUInteger targetMatchIndex = self.matches.count;

    if(targetMatchIndex < self.matches.count) nextMatch = [self.matches objectAtIndex:targetMatchIndex]; 
    
    return nextMatch;
}

- (NSOrderedSet *) returnQualifiedTeamsFromPreviousRound:(NSOrderedSet *)groupsFromPreviousRound {
    NSMutableOrderedSet *tournamentTeamsForNextRound = [[NSMutableOrderedSet alloc] init];
    
    NSInteger nSeedsToParse = self.seeds.count;
    NSInteger nSeedsToQualifyFromEachPreviousGroup = nSeedsToParse / groupsFromPreviousRound.count;
    
    for (int i = 0; i < groupsFromPreviousRound.count; i++) {
        TournamentGroup *previousGroup = [groupsFromPreviousRound objectAtIndex:i];
        NSOrderedSet *rankedGroup = [previousGroup seedsOrderedByGroupRanking];
        
        for (int j = 0; j < nSeedsToQualifyFromEachPreviousGroup; j++) {
            Seed *seed = [rankedGroup objectAtIndex:j];
            [tournamentTeamsForNextRound addObject:seed.tournamentTeam];
        }
    }
    
    return [tournamentTeamsForNextRound copy];
}

- (NSOrderedSet *) userMatches {
    __block NSMutableOrderedSet *userMatches = [[NSMutableOrderedSet alloc] init];
    
    [self.matches enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TournamentMatch *tournamentMatch = [self.matches objectAtIndex:idx];
        if(!tournamentMatch.match) *stop = YES;
        
        if([tournamentMatch.homeSeed.tournamentTeam isEqual:self.tournament.userTournamentTeam] || 
           [tournamentMatch.awaySeed.tournamentTeam isEqual:self.tournament.userTournamentTeam]) [userMatches addObject:tournamentMatch];
    }];
    
    return userMatches;
}

@end
