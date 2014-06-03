//
//  GotoMatchTargetAction.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 24/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TargetActionProtocol.h"

@interface GotoMatchTargetAction : NSObject <TargetActionProtocol>

- (GotoMatchTargetAction *)initWithSegueID:(NSString *)segueID forViewController:(UIViewController *)viewController;

@property (nonatomic, strong) UIViewController *viewController;
@property (nonatomic, strong) NSString *segueID;

@end
