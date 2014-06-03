//
//  DotCommentarySequence.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 31/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "DotCommentarySequence.h"

@implementation DotCommentarySequence

- (id)initWithDelivery:(Delivery *)delivery {
    
    [self addCommentaryItem:[[DotCommentaryItem alloc] initWithCommentaryText:@"No Run"]];
    
    return self;
}

@end
