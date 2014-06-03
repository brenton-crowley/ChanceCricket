//
//  RunCommentarySequence.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 31/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "RunCommentarySequence.h"

@implementation RunCommentarySequence

- (id)initOneWithDelivery:(Delivery *)delivery {
    
    Batsman *batsman = delivery.batsman;
    
    self.commentaryItems = [[NSMutableArray alloc] init];
    
    [self addCommentaryItem:[[RunCommentaryItem alloc] initWithCommentaryText:[NSString stringWithFormat:@"A single to %@.", batsman.batsmanName]]];
    
    return self;
}

- (id)initTwoWithDelivery:(Delivery *)delivery {
    
    Batsman *batsman = delivery.batsman;
    
    self.commentaryItems = [[NSMutableArray alloc] init];
    
    [self addCommentaryItem:[[RunCommentaryItem alloc] initWithCommentaryText:[NSString stringWithFormat:@"Finds the gap for 2. That takes %@ to %@.", batsman.batsmanName, batsman.batsmanRuns]]];
    
    return self;
}

- (id)initThreeWithDelivery:(Delivery *)delivery {
    
    Batsman *batsman = delivery.batsman;
    
    self.commentaryItems = [[NSMutableArray alloc] init];
    
    [self addCommentaryItem:[[RunCommentaryItem alloc] initWithCommentaryText:[NSString stringWithFormat:@"Superbly placed! 3 runs are the result.", batsman.batsmanName]]];
    
    return self;
}

- (id)initFourWithDelivery:(Delivery *)delivery {
    
    Batsman *batsman = delivery.batsman;
    
    self.commentaryItems = [[NSMutableArray alloc] init];
    
    [self addCommentaryItem:[[BoundaryCommentaryItem alloc] initWithCommentaryText:[NSString stringWithFormat:@"%@ timed that to perfection. 4 runs.", batsman.batsmanName]]];
    
    return self;
}

- (id)initSixWithDelivery:(Delivery *)delivery {
    
    Batsman *batsman = delivery.batsman;
    
    self.commentaryItems = [[NSMutableArray alloc] init];
    
    [self addCommentaryItem:[[BoundaryCommentaryItem alloc] initWithCommentaryText:[NSString stringWithFormat:@"%@ has cleared the rope for 6! He's now on %@.", batsman.batsmanName, batsman.batsmanRuns]]];
    
    return self;
}

@end
