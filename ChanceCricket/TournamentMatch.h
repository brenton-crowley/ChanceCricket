//
//  TournamentMatch.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Match, Seed, TournamentRound;

@interface TournamentMatch : NSManagedObject

@property (nonatomic, retain) NSString * matchID;
@property (nonatomic, retain) NSNumber * matchNumber;
@property (nonatomic, retain) Seed *awaySeed;
@property (nonatomic, retain) TournamentRound *currentRMatch;
@property (nonatomic, retain) Seed *homeSeed;
@property (nonatomic, retain) Match *match;
@property (nonatomic, retain) TournamentRound *round;

@end
