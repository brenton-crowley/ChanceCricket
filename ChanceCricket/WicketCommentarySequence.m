//
//  WicketCommentarySequence.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 31/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "WicketCommentarySequence.h"

@implementation WicketCommentarySequence

- (id)initWithDelivery:(Delivery *)delivery {
    
    Wicket *wicket = [delivery.over.bowler.wickets lastObject];    
    Bowler *bowler = wicket.bowler;
    Batsman *batsman = wicket.batsman;
    
    self.commentaryItems = [[NSMutableArray alloc] init];
    
    [self addCommentaryItem:[[WicketCommentaryItem alloc] initWithCommentaryText:@"He's OUT!"]];
    [self addCommentaryItem:[[WicketCommentaryItem alloc] initWithCommentaryText:[NSString stringWithFormat:@"%@ departs for %@. That's wicket number %i for %@.", batsman.batsmanName, batsman.batsmanRuns, bowler.wickets.count, bowler.bowlerName]]];
    
    return self;
}


@end
