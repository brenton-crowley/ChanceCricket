//
//  GotoMatchTargetAction.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 24/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "GotoMatchTargetAction.h"

@implementation GotoMatchTargetAction

@synthesize viewController = _viewController;
@synthesize segueID = _segueID;

- (GotoMatchTargetAction *)initWithSegueID:(NSString *)segueID forViewController:(UIViewController *)viewController{
    
    self.viewController = viewController;
    self.segueID = segueID;
    
    return self;
}

- (void) invokeAction {
    [self.viewController performSegueWithIdentifier:self.segueID sender:self.viewController];
}

@end
