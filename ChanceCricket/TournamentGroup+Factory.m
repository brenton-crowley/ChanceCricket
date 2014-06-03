//
//  TournamentGroup+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TournamentGroup+Factory.h"

@implementation TournamentGroup (Factory)

#define ENTITY_NAME @"TournamentGroup"

+ (TournamentGroup *) createGroupForRound:(TournamentRound *)tournmentRound {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"groupID" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [tournmentRound.managedObjectContext executeFetchRequest:request error:&error];
    
    NSNumber *groupID = [NSNumber numberWithInt:matches.count + 1];
    
    TournamentGroup *tournamentGroup = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:tournmentRound.managedObjectContext];
    tournamentGroup.groupID = groupID;
    tournamentGroup.round = tournmentRound; 
    
    return tournamentGroup;
}

- (NSArray *) seedsOrderedByGroupRanking {
    NSArray *rankedSeeds = [self rankSeedsByPoints:[self seedsAsArray]];
    
    return rankedSeeds;
}

- (NSArray *) rankSeedsByPoints:(NSArray *)seeds {
    
    NSComparator comparator = ^(Seed *seedOne, Seed* seedTwo) {
        
        NSNumber *rank1 = [NSNumber numberWithInteger:[seedOne numberOfPoints]];
        NSNumber *rank2 = [NSNumber numberWithInteger:[seedTwo numberOfPoints]];  
        NSComparisonResult result = (NSComparisonResult)[rank2 compare:rank1];
        if(result == 0) result = [self sortByNetRunRateSeedOne:seedTwo againstSeedTwo:seedOne];
        return result;
    };    
    NSArray *sortedArray = [NSArray arrayWithArray:[seeds sortedArrayUsingComparator:comparator]];
    return sortedArray;
    
}

- (NSComparisonResult) sortByNetRunRateSeedOne:(Seed *)seedOne againstSeedTwo:(Seed *)seedTwo {
    NSComparisonResult result = (NSComparisonResult)[[NSNumber numberWithDouble:[seedOne netRunRate]] compare:[NSNumber numberWithDouble:[seedTwo netRunRate]]];
    
    // higher number of wickets taken per ball
    
    // result in head to head
    
    // draw lots
    
    // seed ranking
    if(result == 0) result = [self sortBySeedingSeedOne:seedOne againstSeedTwo:seedTwo];
    return result;
}

- (NSComparisonResult) sortBySeedingSeedOne:(Seed *)seedOne againstSeedTwo:(Seed *)seedTwo {
    NSComparisonResult result = (NSComparisonResult)[seedTwo.seedNumber compare:seedOne.seedNumber];
    return result;
}

- (NSArray *) seedsAsArray {
    NSMutableArray *seedsAsArray = [[NSMutableArray alloc] init];
    
    for (Seed *seed in self.seeds) {
        [seedsAsArray addObject:seed];
    }
    
    return [seedsAsArray copy];
}


@end
