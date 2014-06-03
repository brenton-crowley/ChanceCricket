//
//  TournamentFixturesViewController.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 23/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tournament+Factory.h"
#import "TournamentRound+Factory.h"
#import "Match+Summary.h"

@class TournamentFixturesViewController;

@protocol TournamentFixturesViewControllerDelegate <NSObject>

- (Tournament *)selectTournamentForFixtures:(TournamentFixturesViewController *)tournamentFixtures;

@end

@interface TournamentFixturesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *fixtureFilter;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) id <TournamentFixturesViewControllerDelegate> delegate;
@property (strong, nonatomic) Tournament *tournament;
@property (nonatomic) BOOL isAllFiltered;
@property (strong, nonatomic) NSOrderedSet *rounds;
@property (strong, nonatomic) NSOrderedSet *matches;

@end
