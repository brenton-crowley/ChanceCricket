//
//  Player.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * playerForename;
@property (nonatomic, retain) NSNumber * playerID;
@property (nonatomic, retain) NSString * playerName;
@property (nonatomic, retain) NSString * playerSurname;
@property (nonatomic, retain) Team *team;

@end
