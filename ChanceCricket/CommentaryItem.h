//
//  CommentaryItem.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 30/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentaryItem : NSObject

- (id) initWithPrimaryColour:(UIColor *)primaryColour;
- (id) initWithCommentaryText:(NSString *)commentaryText;

- (id) initWithCommentaryText:(NSString *)commentaryText 
                  updateDelay:(double)updateDelay;

- (id) initWithCommentaryText:(NSString *)commentaryText 
                primaryColour:(UIColor *)primaryColour 
                  updateDelay:(double)updateDelay;

@property (strong, nonatomic) NSString *commentaryText;
@property (strong, nonatomic) UIColor *primaryColour;
@property (nonatomic) double updateDelay;

// TODO properties
// isAnimated
// may have an image attached to it

@end
