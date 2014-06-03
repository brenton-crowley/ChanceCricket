//
//  Wicket.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Batsman, Bowler, Inning;

@interface Wicket : NSManagedObject

@property (nonatomic, retain) Batsman *batsman;
@property (nonatomic, retain) Bowler *bowler;
@property (nonatomic, retain) Inning *inning;

@end
