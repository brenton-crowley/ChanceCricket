//
//  CommentaryItem.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 30/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "CommentaryItem.h"

@implementation CommentaryItem

@synthesize commentaryText = _commentaryText;
@synthesize primaryColour = _primaryColour;
@synthesize updateDelay = _updateDelay;

#define DEFAULT_UPDATE_DELAY 1

- (NSString *) commentaryText {
    if(!_commentaryText) _commentaryText = @"Default Commentary Text";
    return  _commentaryText;
}

- (UIColor *)primaryColour {
    if(!_primaryColour) _primaryColour = [UIColor greenColor];
    return _primaryColour;
}

- (double) updateDelay {
    if(_updateDelay == 0) _updateDelay = DEFAULT_UPDATE_DELAY;
    return _updateDelay;
}

- (id) initWithPrimaryColour:(UIColor *)primaryColour {
    self.primaryColour = primaryColour;
    
    return self;
}

- (id) initWithCommentaryText:(NSString *)commentaryText {
    self.commentaryText = commentaryText;
    return self;
}

- (id) initWithCommentaryText:(NSString *)commentaryText 
                  updateDelay:(double)updateDelay {
    self.commentaryText = commentaryText;
    self.updateDelay = updateDelay;
    
    return self;
}

- (id) initWithCommentaryText:(NSString *)commentaryText 
                primaryColour:(UIColor *)primaryColour 
                  updateDelay:(double)updateDelay {
    self.commentaryText = commentaryText;
    self.primaryColour = primaryColour;
    self.updateDelay = updateDelay;
    
    return self;
}

@end
