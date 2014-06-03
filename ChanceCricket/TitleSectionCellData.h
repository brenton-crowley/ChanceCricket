//
//  TitleSectionCellData.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewSectionCellData.h"

@interface TitleSectionCellData : TableViewSectionCellData <TableViewSectionCellDataProtocol>

@property (nonatomic, strong) NSString *cellTitle;

- (TitleSectionCellData *) initWithTitle:(NSString *)title;

@end
