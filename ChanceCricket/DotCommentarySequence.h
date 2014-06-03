//
//  DotCommentarySequence.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 31/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "CommentaryItemSequence.h"
#import "DotCommentaryItem.h"
#import "Delivery+Factory.h"
#import "Batsman+Factory.h"
#import "Bowler+Factory.h"
#import "Wicket+Factory.h"
#import "Over+Factory.h"


@interface DotCommentarySequence : CommentaryItemSequence

- (id)initWithDelivery:(Delivery *)delivery;

@end
