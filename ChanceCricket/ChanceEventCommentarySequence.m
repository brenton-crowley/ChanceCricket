//
//  ChanceEventCommentarySequence.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 31/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "ChanceEventCommentarySequence.h"

@implementation ChanceEventCommentarySequence

- (id)initBoundaryChanceWithDelivery:(Delivery *)delivery {
    
    [self addCommentaryItem:[[ChanceEventCommentaryItem alloc] initWithCommentaryText:@"Big Swing..."]];
    
    return self;
}

- (id)initWicketChanceWithDelivery:(Delivery *)delivery {
    
    [self addCommentaryItem:[[ChanceEventCommentaryItem alloc] initWithCommentaryText:@"HOWZAT!?!"]];
    
    return self;
}

@end
