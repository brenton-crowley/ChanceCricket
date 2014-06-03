//
//  CommentaryItemSequence.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 30/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentaryItem.h"

@interface CommentaryItemSequence : NSObject

- (CommentaryItem *) commentaryItemToExecute;
- (void) addCommentaryItem:(id)commentaryItem;

@property (strong, nonatomic) NSMutableArray *commentaryItems;
@property (strong, nonatomic) NSMutableArray *currentCommentaryItemBeingExecuted;
@property (strong, nonatomic) UIColor *primaryColour;
@property (strong, nonatomic) UIColor *secondaryColour;

@end
