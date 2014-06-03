//
//  CommentaryViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 09/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentaryView.h"
#import "Wicket+Factory.h"
#import "Batsman+Factory.h"
#import "Bowler+Factory.h"
#import "Delivery+Factory.h"
#import "Over+Factory.h"
#import "CommentaryItemSequence.h"
#import "CommentaryItem.h"
#import "RunCommentaryItem.h"
#import "BoundaryCommentaryItem.h"
#import "WicketCommentaryItem.h"
#import "DotCommentaryItem.h"
#import "ChanceEventCommentaryItem.h"
#import "WicketCommentarySequence.h"
#import "RunCommentarySequence.h"
#import "DotCommentarySequence.h"
#import "ChanceEventCommentarySequence.h"
#import "UIColor+ColorWithHex.h"

@interface CommentaryViewController : NSObject

//-(void) pauseTimer;
//-(void) startTimer;
-(void) showBoundaryChanceText;
-(void) showWicketChanceText;
-(void) showWicketText:(Delivery *)delivery;
-(void) showDotText:(Delivery *)delivery;
-(void) showRunsText:(int)runs forDelivery:(Delivery *)delivery;

-(void) parentViewDidUnload;

@property (weak, nonatomic) IBOutlet CommentaryView *commentaryView;
@property (strong, nonatomic) NSMutableArray *executionList;
@property (strong, nonatomic) NSMutableArray *executionHistory;
@property (strong, nonatomic) CommentaryItemSequence *currentCommentaryItemSequenceExecuting;
@property (strong, nonatomic) NSTimer *validationTimer;
@property (strong, nonatomic) NSTimer *updateTimer;
@property (nonatomic) BOOL isActive;


@end
