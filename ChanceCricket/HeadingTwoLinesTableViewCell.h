//
//  HeadingTwoLinesTableViewCell.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 10/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ScoreboardTableCellProtocol.h"

@interface HeadingTwoLinesTableViewCell : UITableViewCell <ScoreboardTableCellProtocol>

@property (weak, nonatomic) IBOutlet UILabel *heading;
@property (weak, nonatomic) IBOutlet UILabel *strikerScore;
@property (weak, nonatomic) IBOutlet UILabel *strikerName;
@property (weak, nonatomic) IBOutlet UILabel *nonStrikerScore;
@property (weak, nonatomic) IBOutlet UILabel *nonStrikerName;
@end
