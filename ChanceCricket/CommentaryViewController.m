//
//  CommentaryViewController.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 09/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "CommentaryViewController.h"

@implementation CommentaryViewController

@synthesize commentaryView;
@synthesize executionList = _executionList; // this is the model, add, remove, clear, override
@synthesize currentCommentaryItemSequenceExecuting = _currentCommentaryItemSequenceExecuting;
@synthesize validationTimer = _validationTimer;
@synthesize isActive = _isActive;
@synthesize executionHistory = _executionHistory;
@synthesize updateTimer = _updateTimer;

#define UPDATE_TIMER_INTERVAL 1

- (CommentaryItemSequence *) currentCommentaryItemSequenceExecuting {
    if(self.executionList.count > 0) _currentCommentaryItemSequenceExecuting = [self.executionList objectAtIndex:0];
    else _currentCommentaryItemSequenceExecuting = nil;
    return  _currentCommentaryItemSequenceExecuting;
}

- (NSMutableArray *) executionHistory {
    if (!_executionHistory) _executionHistory = [[NSMutableArray alloc] init];
    return _executionHistory;
}

- (NSMutableArray *) exectionList {
    if(!_executionList) _executionList = [[NSMutableArray alloc] init];
    return _executionList;
}

- (void) setIsActive:(BOOL)isActive {
    _isActive = isActive;
    
    [self validateTimers];
}

- (void) validateTimers {
    if (self.isActive) {
        [self executeNextCommentaryItem];
        self.validationTimer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_TIMER_INTERVAL target:self selector:@selector(onValidationTimerInterval:) userInfo:self repeats:YES];
        
    }else{
        [self.validationTimer invalidate];
        [self.updateTimer invalidate];
        self.updateTimer = nil;
        self.validationTimer = nil;
    }
}

- (void) onValidationTimerInterval:(NSTimer *)timer {
    // just check to see if we have some items. If not, add some
//    NSLog(@"self.executionList.count: %i", self.executionList.count);
//    if(!self.currentCommentaryItemSequenceExecuting) NSLog(@"No items to execute");
}

- (void) removeCommentaryItemFromQueue {
    if(self.currentCommentaryItemSequenceExecuting) {   
        // if the current items ==
        if(self.currentCommentaryItemSequenceExecuting.commentaryItems.count > 0){
            // remove the first item in the current list
            CommentaryItem *commentaryItem = self.currentCommentaryItemSequenceExecuting.commentaryItemToExecute;
            [self.executionHistory insertObject:commentaryItem atIndex:0];
            [self.currentCommentaryItemSequenceExecuting.commentaryItems removeObject:commentaryItem];
        }
    }
    
    if(!self.currentCommentaryItemSequenceExecuting.commentaryItemToExecute){
        [self.exectionList removeObject:self.currentCommentaryItemSequenceExecuting];
    }
}


- (void) addCommentaryItemSequence:(id)commentaryItemSequence {
    [self.exectionList addObject:commentaryItemSequence];
}

- (void) scheduleUpdateTimer:(double)updateDelay {
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:updateDelay target:self selector:@selector(onUpdateTimerInterval:) userInfo:self repeats:NO];
}

- (void) onUpdateTimerInterval:(NSTimer *)timer {
    [self removeCommentaryItemFromQueue];
    [self executeNextCommentaryItem];
}

- (void) executeNextCommentaryItem {
    
    if(self.currentCommentaryItemSequenceExecuting.commentaryItemToExecute){
        [self invalidateCommentaryViewWithCommentaryItem:self.currentCommentaryItemSequenceExecuting.commentaryItemToExecute];
        
        [self scheduleUpdateTimer:self.currentCommentaryItemSequenceExecuting.commentaryItemToExecute.updateDelay];
    }else{
        // comment out and the last item will stick
//        [self invalidateCommentaryView:@"No more to execute" setBackgroundColour:[UIColor lightGrayColor]];
    }
}

- (void) invalidateCommentaryViewWithCommentaryItem:(CommentaryItem *)commentaryItem {
    [self invalidateCommentaryView:commentaryItem.commentaryText setBackgroundColour:commentaryItem.primaryColour];
}

- (void) invalidateCommentaryView:(NSString *)commentaryText setBackgroundColour:(UIColor *)backgroundColour {
    self.commentaryView.label.text = commentaryText;
//    self.commentaryView.backgroundColor = backgroundColour;
}

-(void) showBoundaryChanceText {    
    [self forceToFrontAndShowCommentarySequenece:[[ChanceEventCommentarySequence alloc]initBoundaryChanceWithDelivery:nil]];
}
-(void) showWicketChanceText {
    [self forceToFrontAndShowCommentarySequenece:[[ChanceEventCommentarySequence alloc]initWicketChanceWithDelivery:nil]];
}
-(void) showWicketText:(Delivery *)delivery {
    [self forceToFrontAndShowCommentarySequenece:[[WicketCommentarySequence alloc]initWithDelivery:delivery]];
}

-(void) showDotText:(Delivery *)delivery {
    NSLog(@"Current Type of class: %@", [self.currentCommentaryItemSequenceExecuting class]);
    [self forceToFrontAndShowCommentarySequenece:[[DotCommentarySequence alloc] initWithDelivery:delivery]];
}

-(void) showRunsText:(int)runs forDelivery:(Delivery *)delivery {

    switch (runs) {
        case 1:
            [self forceToFrontAndShowCommentarySequenece:[[RunCommentarySequence alloc]initOneWithDelivery:delivery]];
            break;
        case 2:
            [self forceToFrontAndShowCommentarySequenece:[[RunCommentarySequence alloc]initTwoWithDelivery:delivery]];
            break;
        case 3:
            [self forceToFrontAndShowCommentarySequenece:[[RunCommentarySequence alloc]initThreeWithDelivery:delivery]];
            break;
        case 4:
            [self forceToFrontAndShowCommentarySequenece:[[RunCommentarySequence alloc]initFourWithDelivery:delivery]];
            break;
        case 6:
            [self forceToFrontAndShowCommentarySequenece:[[RunCommentarySequence alloc]initSixWithDelivery:delivery]];
            break;
        default:
            [self showDotText:delivery];
            break;
    }
    
    self.commentaryView.primaryColourHex = delivery.over.inning.battingTeam.primaryHex.intValue;
    self.commentaryView.secondaryColourHex = delivery.over.inning.battingTeam.secondaryHex.intValue;
    NSLog(@"Primary: %i", delivery.over.inning.battingTeam.primaryHex.intValue);
    NSLog(@"Secondary: %i", delivery.over.inning.battingTeam.secondaryHex.intValue);
    [self.commentaryView setNeedsDisplay];
    
}

- (void) forceToFrontAndShowCommentarySequenece:(CommentaryItemSequence *)itemSequence {
    [self.updateTimer invalidate];
    self.executionList = [NSMutableArray arrayWithObject:itemSequence];
    [self executeNextCommentaryItem];
}

-(void) parentViewDidUnload {
    [self setCommentaryView:nil];
}

@end
