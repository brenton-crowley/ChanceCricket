//
//  SimulateMatchTargetAction.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 24/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "SimulateMatchTargetAction.h"

@implementation SimulateMatchTargetAction

@synthesize tournamentMatchCentreVC = _tournamentMatchCentreVC;

- (SimulateMatchTargetAction *) initWithTournamentMatchCentreVC:(UIViewController *)tournamentMatchCentreVC {
    
    self.tournamentMatchCentreVC = tournamentMatchCentreVC;
    
    return self;
}

- (void) invokeAction {
    TournamentMatchCentreViewController *tournamentMatchCentreVC = (TournamentMatchCentreViewController *)self.tournamentMatchCentreVC;
    [tournamentMatchCentreVC.delegate simulateCurrentMatch:tournamentMatchCentreVC];
}

@end
