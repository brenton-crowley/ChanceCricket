//
//  TitleSectionCellData.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TitleSectionCellData.h"

@implementation TitleSectionCellData

@synthesize cellTitle = _cellTitle;

- (TitleSectionCellData *) initWithTitle:(NSString *)title {
    self.cellTitle = title;
    return self;
}

- (void)renderCell:(id)cellToRender {
    UITableViewCell *cell = cellToRender;
    cell.textLabel.text = self.cellTitle;
}
@end
