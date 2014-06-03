//
//  BattingInningScorecardSection.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SectionProtocol.h"
#import "Batsman+Factory.h"

@interface BattingInningScorecardSection : NSObject <SectionProtocol>

@property (strong, nonatomic) NSOrderedSet *batsmen;
@property (strong, nonatomic) Inning *currentMatchInning;

- (BattingInningScorecardSection *) initWithBatsman:(NSOrderedSet *)batsmen withCurrentMatchInning:(Inning *)inning;

@end
