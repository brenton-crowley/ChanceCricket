//
//  GotoNextScheduledMatchTargetAction.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 24/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "GotoNextScheduledMatchTargetAction.h"

@implementation GotoNextScheduledMatchTargetAction

@synthesize tournamentMatchCentreVC = _tournamentMatchCentreVC;

- (GotoNextScheduledMatchTargetAction *) initWithTournamentMatchCentreVC:(UIViewController *)tournamentMatchCentreVC {
    
    self.tournamentMatchCentreVC = tournamentMatchCentreVC;
    
    return self;
}

- (void) invokeAction {
    // goto next match
    NSLog(@"Goto Next Scheduled Match");
    TournamentMatchCentreViewController *tournamentMatchCentreVC = (TournamentMatchCentreViewController *)self.tournamentMatchCentreVC;
    
    [tournamentMatchCentreVC.delegate gotoNextSchedluedMatchForMatchCentre:tournamentMatchCentreVC];
}

@end
