//
//  Match+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 27/02/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "Match.h"

@interface Match (Factory)

extern NSString * const MATCH_STATE_CREATED;
extern NSString * const MATCH_STATE_SCHEDULED;
extern NSString * const MATCH_STATE_IN_PROGRESS;
extern NSString * const MATCH_STATE_COMPLETED;

+ (Match *) createMatchWithHomeTeam:(Team *)homeTeam andAwayTeam:(Team *)awayTeam inContext:(NSManagedObjectContext *)context;
+ (Match *) selectMatch:(NSString *)matchID 
              inContext:(NSManagedObjectContext *)context;

- (void) addInningBattingTeam:(Team *)battingTeam setBowlingTeam:(Team *)bowlingTeam;
- (void) update;
- (Inning *) currentInnings;

@end
