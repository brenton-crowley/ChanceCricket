//
//  TableViewSection.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TableViewSectionCellData.h"

@protocol TableViewSectionProtocol <NSObject>

- (id <TableViewSectionProtocol>) initWithTitle:(NSString *)sectionTitle;
- (id <TableViewSectionProtocol>) initWithTitle:(NSString *)sectionTitle andData:(id)data;
- (id <TableViewSectionProtocol>) initWithTitle:(NSString *)sectionTitle andSectionCellDatas:(NSMutableArray *)sectionCellDatas;
- (void) addSectionCellData:(id <TableViewSectionCellDataProtocol>)sectionCellData;

@property (nonatomic, strong) NSMutableArray *sectionCellDatas;
@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) id data;

@end

@interface TableViewSection : NSObject <TableViewSectionProtocol>

@end
