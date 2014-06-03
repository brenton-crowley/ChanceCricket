//
//  ScoreboardCellData.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScoreboardCellData.h"

@implementation ScoreboardCellData

@synthesize data = _data;
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize cellHeight = _cellHeight;

- (ScoreboardCellData *) initWithData:(id)data setReuseIdentifier:(NSString *)reuseIdentifier setCellHeight:(CGFloat)cellHeight {
    self.data = data;
    self.reuseIdentifier = reuseIdentifier;
    self.cellHeight = cellHeight;
    return self;
}


@end
