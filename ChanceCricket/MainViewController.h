//
//  MainViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MatchViewController.h"
#import "CreateMatchModalViewController.h"
#import "MatchSelectionTableViewController.h"
#import "Settings.h"
#import "CreateTournamentTableViewController.h"
#import "TournamentCentralViewController.h"

@interface MainViewController : UIViewController <CreateMatchModalViewControllerDelegate, MatchSelectionTableViewControllerDelegate, CreateTournamentTableViewControllerDelegate, MatchViewControllerDelegate>

@property (nonatomic, strong) NSString *matchID;
@property (nonatomic, strong) NSString *tournamentID;
@property (weak, nonatomic) IBOutlet UIButton *resumeMatchButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeTournamentButton;

@end
