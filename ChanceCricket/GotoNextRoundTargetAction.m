//
//  GotoNextRoundTargetAction.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 24/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "GotoNextRoundTargetAction.h"

@implementation GotoNextRoundTargetAction

@synthesize tournamentMatchCentreVC = _tournamentMatchCentreVC;

- (GotoNextRoundTargetAction *) initWithTournamentMatchCentreVC:(UIViewController *)tournamentMatchCentreVC {
    
    self.tournamentMatchCentreVC = tournamentMatchCentreVC;
    
    return self;
}

- (void) invokeAction {
    // goto next round
    NSLog(@"Goto next round");
    
    TournamentMatchCentreViewController *tournamentMatchCentreVC = (TournamentMatchCentreViewController *)self.tournamentMatchCentreVC;
    
    [tournamentMatchCentreVC.delegate gotoNextRoundForMatchCentre:tournamentMatchCentreVC];
}

@end
