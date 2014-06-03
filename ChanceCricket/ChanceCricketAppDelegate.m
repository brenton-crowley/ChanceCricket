//
//  ChanceCricketAppDelegate.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChanceCricketAppDelegate.h"
#import "MatchDatabase.h"
#import "Team+Factory.h"

@interface ChanceCricketAppDelegate ()

//@property (nonatomic, strong) UIManagedDocument *database;

@end

@implementation ChanceCricketAppDelegate

//@synthesize database = _database;
@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    // This loads teams that are defined in an external plist file. If the teams do not exist, it will create them in the database
    [MatchDatabase openFile:DOCUMENT_ROOT usingBlock:^(UIManagedDocument *database) {
        [self initialiseTeamsFromFile:database];
        [MatchDatabase saveDatabase:database usingCompletionBlock:nil];
    }];
    
    return YES;
}

- (void) initialiseLoadedPlayers:(NSArray *)loadedPlayers forTeam:(Team *)team inContext:(NSManagedObjectContext *)context {
       
    // maybe put a conditional in here and see if the length are equal to one another. that way we can skip the looping of players, although it could be erroneous so I'll leave it for now.
    NSDictionary *loadedPlayer;
    
    for (int i = 0; i < loadedPlayers.count; i++) {
        loadedPlayer = [loadedPlayers objectAtIndex:i];                
        [team addPlayer:loadedPlayer inContext:context];
    }
    
}

- (void) initialiseTeamsFromFile:(UIManagedDocument *)database {
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:@"data_teams.plist"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) plistPath = [[NSBundle mainBundle] pathForResource:@"data_teams" ofType:@"plist"];

    NSDictionary *teamsData = [NSDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:plistPath]];
    if (!teamsData) NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    
    NSDictionary *teams = [teamsData objectForKey:@"teams"];
    
    for (id teamKeyInTeams in teams) {
        
        // team parsing
        NSDictionary *rawTeam = [teams objectForKey:teamKeyInTeams];
        Team *team = [Team addTeam:rawTeam withID:teamKeyInTeams inContext:database.managedObjectContext];
        
        //player parsing
        NSArray *rawPlayers = [rawTeam objectForKey:@"players"];
        [self initialiseLoadedPlayers:rawPlayers forTeam:team inContext:database.managedObjectContext];
    }

}

//- (void) managedDocumentOpened:(UIManagedDocument *)database {
//    NSLog(@"Document opened");
//    
//    [self initialiseTeamsFromFile:database];
//    
//    [self saveDatabase:database];
//}

@end
