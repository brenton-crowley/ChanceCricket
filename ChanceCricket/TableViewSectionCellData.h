//
//  TableViewSectionCellData.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableViewSectionCellDataProtocol <NSObject>

- (void) renderCell:(id)cell withData:(id)data atIndexPath:(NSIndexPath *)indexPath;

@optional

@property (nonatomic, strong) NSString *cellReuseID;
@property (nonatomic, strong) id data;

- (id <TableViewSectionCellDataProtocol>) initWithCellReuseID:(NSString *)cellReuseID;
- (id <TableViewSectionCellDataProtocol>) initWithCellReuseID:(NSString *)cellReuseID andData:(id)data;
- (id <TableViewSectionCellDataProtocol>) initWithCellData:(id <TableViewSectionCellDataProtocol>)data;

- (void) renderCell:(id)cell;


@end

@interface TableViewSectionCellData : NSObject <TableViewSectionCellDataProtocol>

@end
