//
//  SegmentProtocol.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SectionProtocol.h"

@protocol SegmentProtocol <NSObject>

@property (nonatomic, strong) NSMutableArray *sections;
@property (nonatomic, strong) NSString *segmentName;
@property (nonatomic, strong) id segmentData;

- (id <SegmentProtocol>) initWithSegmentData:(id)segmentData;
- (id <SegmentProtocol>) initWithName:(NSString *)segmentName;

- (void) addSection:(id <SectionProtocol>)section;

@end
