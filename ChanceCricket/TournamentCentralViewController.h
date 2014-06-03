//
//  TouramentCentralViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TournamentCentralModel.h"
#import "TournamentMatchCentreViewController.h"
#import "TournamentRound+Factory.h"
#import "TournamentStandingsViewController.h"
#import "TournamentFixturesViewController.h"

@interface TournamentCentralViewController : UITabBarController <UITabBarControllerDelegate, 
TournamentMatchCentreViewControllerDelegate, TournamentFixturesViewControllerDelegate>

@property (nonatomic, strong) TournamentCentralModel *model;
@property (nonatomic, strong) NSString *tournamentID;

@end
