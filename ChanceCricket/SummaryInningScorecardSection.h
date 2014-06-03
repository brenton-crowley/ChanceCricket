//
//  SummaryInningScorecardSection.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionProtocol.h"
#import "Inning+Factory.h"
#import "ScoreboardCellData.h"

@interface SummaryInningScorecardSection : NSObject <SectionProtocol>

- (SummaryInningScorecardSection *) initWithInning:(Inning *)inning;

@property (nonatomic, strong) Inning *inning;

@end
