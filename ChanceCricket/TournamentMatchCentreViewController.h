//
//  TournamentMatchCentreViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TournamentMatch+Factory.h"
#import "TournamentTeam+Factory.h"
#import "Seed+Factory.h"
#import "Match+Factory.h"
#import "MatchViewController.h"
#import "TargetActionProtocol.h"
#import "GotoMatchTargetAction.h"
#import "SimulateMatchTargetAction.h"
#import "GotoNextRoundTargetAction.h"
#import "GotoNextScheduledMatchTargetAction.h"

@class TournamentMatchCentreViewController;

@protocol TournamentMatchCentreViewControllerDelegate <NSObject>

- (TournamentMatch *)selectTournamentMatchForMatchCentre:(TournamentMatchCentreViewController *)matchCentre;
- (void) gotoNextSchedluedMatchForMatchCentre:(TournamentMatchCentreViewController *)matchCentre;
- (void) gotoNextRoundForMatchCentre:(TournamentMatchCentreViewController *)matchCentre;
- (void) simulateCurrentMatch:(TournamentMatchCentreViewController *)matchCentre;

@end

@interface TournamentMatchCentreViewController : UIViewController <MatchViewControllerDelegate>

@property (nonatomic, strong) TournamentMatch *tournamentMatch;
@property (nonatomic, strong) id <TournamentMatchCentreViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchProgressLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (nonatomic, strong) id <TargetActionProtocol> targetAction;
@property (weak, nonatomic) IBOutlet UIButton *viewMatchButton;


@end
