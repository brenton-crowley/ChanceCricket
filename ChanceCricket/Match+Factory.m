//
//  Match+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 27/02/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Match+Factory.h"
#import "Inning+Factory.h"
#import "MatchSettingsT20+Factory.h"
#import "Team+Factory.h"

@implementation Match (Factory)

NSString * const MATCH_STATE_CREATED = @"matchStateCreated";
NSString * const MATCH_STATE_SCHEDULED = @"matchStateScheduled";
NSString * const MATCH_STATE_IN_PROGRESS = @"matchStateInProgress";
NSString * const MATCH_STATE_COMPLETED = @"matchStateCompleted";

#define ENTITY_NAME NSStringFromClass([Match class])

+ (Match *) createMatchWithHomeTeam:(Team *)homeTeam 
                        andAwayTeam:(Team *)awayTeam 
                          inContext:(NSManagedObjectContext *)context {
    
    Match *match = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
    match.matchID = match.objectID.URIRepresentation.absoluteString;
    match.state = MATCH_STATE_CREATED;
    match.matchSettings = [MatchSettingsT20 addSettingsMatch:match inContext:context];
        
        // create teams
    match.homeTeam = [homeTeam teamForContext:context];
    match.awayTeam = [awayTeam teamForContext:context];
    
    return match;
}

+ (Match *) selectMatch:(NSString *)matchID 
                  inContext:(NSManagedObjectContext *)context
{
    
    Match *match = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"matchID = %@", matchID];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"matchID" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
//    NSLog(@"Game Matches count: %i", matches.count);
    
    if (!matches || ([matches count] > 1)) {
        // handle error
    } else {
//        NSLog(@"Match already exists in database");
        match = [matches lastObject];
    }
    
    NSLog(@"Match Object ID: %@", match.objectID.URIRepresentation.absoluteString);
    
    return match;
}

- (void) addInningBattingTeam:(Team *)battingTeam setBowlingTeam:(Team *)bowlingTeam {
    [Inning addInningToMatch:self setBattingTeam:battingTeam setBowlingTeam:bowlingTeam inContext:self.managedObjectContext];
}

- (void) update {
    
}

- (Inning *) currentInnings {
    return [self.innings lastObject];
}

@end
