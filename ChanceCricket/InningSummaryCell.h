//
//  InningSummaryCell.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreboardCellProtocol.h"

@interface InningSummaryCell : UITableViewCell <ScoreboardCellProtocol>

@property (nonatomic, weak) IBOutlet UILabel *rightTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *leftTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *rightSubtitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *leftSubtitleLabel;

@end
