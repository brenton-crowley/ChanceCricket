//
//  CommentaryItemSequence.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 30/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "CommentaryItemSequence.h"

@implementation CommentaryItemSequence

@synthesize commentaryItems = _commentaryItems;
@synthesize currentCommentaryItemBeingExecuted = _currentCommentaryItemBeingExecuted;
@synthesize primaryColour = _primaryColour;
@synthesize secondaryColour = _secondaryColour;

- (CommentaryItem *) commentaryItemToExecute {
    CommentaryItem *commentaryItem = nil;
    if(self.commentaryItems.count > 0) commentaryItem = [self.commentaryItems objectAtIndex:0];
    return commentaryItem;
}

- (NSMutableArray *) commentaryItems {
    if(!_commentaryItems) _commentaryItems = [[NSMutableArray alloc] init];
    return _commentaryItems;
}

- (void) addCommentaryItem:(id)commentaryItem {
    [self.commentaryItems addObject:commentaryItem];
}



@end
