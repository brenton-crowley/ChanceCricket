//
//  StandingsTableViewCell.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewSectionCellData.h"
#import "Seed+Factory.h"

@interface StandingsTableViewCell : UITableViewCell <TableViewSectionCellDataProtocol>

@property (weak, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchesLabel;
@property (weak, nonatomic) IBOutlet UILabel *winsLabel;
@property (weak, nonatomic) IBOutlet UILabel *lossesLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiesLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *netRunRateLabel;

- (void) formatBold;

@end
