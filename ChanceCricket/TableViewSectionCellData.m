//
//  TableViewSectionCellData.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewSectionCellData.h"

@implementation TableViewSectionCellData

@synthesize cellReuseID = _cellReuseID;
@synthesize data = _data;

- (id <TableViewSectionCellDataProtocol>) initWithCellReuseID:(NSString *)cellReuseID {
    self.cellReuseID = cellReuseID;
    return self;
}
- (id <TableViewSectionCellDataProtocol>) initWithCellReuseID:(NSString *)cellReuseID andData:(id)data {
    self.cellReuseID = cellReuseID;
    self.data = data;
    return self;
}

- (id <TableViewSectionCellDataProtocol>) initWithCellData:(id <TableViewSectionCellDataProtocol>)data {
    self.data = data;
    return self;
}

- (void) renderCell:(id)cell {
// override    
}

- (void) renderCell:(id)cell withData:(id)data atIndexPath:(NSIndexPath *)indexPath {
    if([cell conformsToProtocol:@protocol(TableViewSectionCellDataProtocol)]) [(id <TableViewSectionCellDataProtocol>)cell renderCell:cell withData:data atIndexPath:indexPath];
}

@end
