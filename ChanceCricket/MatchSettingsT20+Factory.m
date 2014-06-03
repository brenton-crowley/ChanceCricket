//
//  MatchSettingT20+Factory.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MatchSettingsT20+Factory.h"
#import "Match.h"

@implementation MatchSettingsT20 (Factory)

#define ENTITY_NAME @"MatchSettingsT20"

NSString* const SETTINGS_NAME = @"T20 Settings";
int const INNING_OVER_LIMIT = 20;
int const INNINGS_LIMIT = 2;
int const DELIVERIES_PER_OVER = 6;
int const BOWLER_OVER_LIMIT = 4;

+ (MatchSettingsT20 *) addSettingsMatch:(Match *) match inContext:(NSManagedObjectContext *)context {
    
    // should probably make a fetch request to see if one already exists. If it does just grab those settings
    
    MatchSettingsT20 *matchSettings = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:ENTITY_NAME];
    request.predicate = [NSPredicate predicateWithFormat:@"settingsName = %@", SETTINGS_NAME];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"settingsName" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    
    NSError *error;
    NSArray *databaseMatches = [context executeFetchRequest:request error:&error];
    
//    NSLog(@"Settings count: %i", databaseMatches.count);
    
    if (!databaseMatches || ([databaseMatches count] > 1)) {
        // handle error
    } else if ([databaseMatches count] == 0) {
        
        matchSettings = [NSEntityDescription insertNewObjectForEntityForName:ENTITY_NAME inManagedObjectContext:context];
        matchSettings.settingsName = SETTINGS_NAME;
        matchSettings.inningOverLimit = [NSNumber numberWithInt:INNING_OVER_LIMIT];
        matchSettings.inningsLimit = [NSNumber numberWithInt:INNINGS_LIMIT];
        matchSettings.deliveriesPerOver = [NSNumber numberWithInt:DELIVERIES_PER_OVER];
        matchSettings.bowlerOverLimit = [NSNumber numberWithInt:BOWLER_OVER_LIMIT];
        
    } else {
        matchSettings = [databaseMatches lastObject];
    }
    
    return matchSettings;
//    NSLog(@"Add Match Settings To Match: %@", matchSettings.match);
    
}


@end
