//
//  Batsman+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Batsman.h"
#import "Player.h"

@interface Batsman (Factory)

+ (Batsman *) addBatsmanToInning:(Inning *)inning setPlayer:(Player *)player;

- (int) ballsFaced;
- (double) strikeRate;

@end
