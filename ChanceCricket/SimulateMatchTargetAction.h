//
//  SimulateMatchTargetAction.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 24/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TargetActionProtocol.h"
#import "TournamentMatchCentreViewController.h"

@interface SimulateMatchTargetAction : NSObject <TargetActionProtocol>

- (SimulateMatchTargetAction *) initWithTournamentMatchCentreVC:(UIViewController *)tournamentMatchCentreVC;

@property (nonatomic, strong) UIViewController *tournamentMatchCentreVC;

@end
