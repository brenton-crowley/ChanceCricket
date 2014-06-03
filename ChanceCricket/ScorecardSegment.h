//
//  InningScorecardSegment.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Inning+Factory.h"
#import "SegmentProtocol.h"
#import "SectionProtocol.h"

@interface ScorecardSegment : NSObject <SegmentProtocol>

- (id <SegmentProtocol>) initWithSegmentData:(id)segmentData;
- (void) addSection:(id <SectionProtocol>)section;

@end
