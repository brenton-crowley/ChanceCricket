//
//  Wicket+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Wicket.h"

@interface Wicket (Factory)

+ (Wicket *) addWicketToInning:(Inning *)inning toBowler:(Bowler *)bowler;

@end
