//
//  LastWicketTableViewCell.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 10/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreboardTableCellProtocol.h"

@interface LastWicketTableViewCell : UITableViewCell <ScoreboardTableCellProtocol>

@property (weak, nonatomic) IBOutlet UILabel *heading;

@property (weak, nonatomic) IBOutlet UILabel *batsmanRuns;
@property (weak, nonatomic) IBOutlet UILabel *batsmanName;
@property (weak, nonatomic) IBOutlet UILabel *wicketDetail;
@end
