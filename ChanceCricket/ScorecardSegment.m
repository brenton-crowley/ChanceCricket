//
//  InningScorecardSegment.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScorecardSegment.h"
#import "BattingInningScorecardSection.h"
#import "BowlingInningScorecardSection.h"

@implementation ScorecardSegment

@synthesize sections = _sections;
@synthesize segmentName = _segmentName;
@synthesize segmentData = _segmentData;

- (id <SegmentProtocol>) initWithName:(NSString *)segmentName {
    self.segmentName = segmentName;
    return self;
}

- (id <SegmentProtocol>) initWithSegmentData:(id)segmentData {
    self.segmentData = segmentData;
    return self;
}

- (void) addSection:(id <SectionProtocol>)section {
    [self.sections addObject:section];
}

- (NSMutableArray *) sections {
    if(!_sections) _sections = [[NSMutableArray alloc] init];
    return _sections;
}

@end
