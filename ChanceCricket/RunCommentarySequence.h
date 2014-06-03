//
//  RunCommentarySequence.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 31/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "CommentaryItemSequence.h"
#import "RunCommentaryItem.h"
#import "BoundaryCommentaryItem.h"
#import "Delivery+Factory.h"
#import "Batsman+Factory.h"
#import "Bowler+Factory.h"
#import "Wicket+Factory.h"
#import "Over+Factory.h"
#import "Inning+Factory.h"
#import "UIColor+ColorWithHex.h"

@interface RunCommentarySequence : CommentaryItemSequence

- (id)initOneWithDelivery:(Delivery *)delivery;
- (id)initTwoWithDelivery:(Delivery *)delivery;
- (id)initThreeWithDelivery:(Delivery *)delivery;
- (id)initFourWithDelivery:(Delivery *)delivery;
- (id)initSixWithDelivery:(Delivery *)delivery;

@end
