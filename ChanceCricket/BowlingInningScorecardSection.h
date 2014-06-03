//
//  BowlingInningScorecardSection.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionProtocol.h"
#import "Bowler+Factory.h"
#import "ScoreboardBowlerCell.h"

@interface BowlingInningScorecardSection : NSObject <SectionProtocol>

@property (strong, nonatomic) NSOrderedSet *bowlers;
@property (strong, nonatomic) Inning *currentMatchInning;

- (BowlingInningScorecardSection *) initWithBowlers:(NSOrderedSet *)bowlers withCurrentMatchInning:(Inning *)inning;

@end
