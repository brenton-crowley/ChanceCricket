//
//  TableViewSection.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableViewSection.h"

@implementation TableViewSection

@synthesize sectionCellDatas = _sectionCellDatas;
@synthesize sectionTitle = _sectionTitle;
@synthesize data = _data;

- (id <TableViewSectionProtocol>) initWithTitle:(NSString *)sectionTitle andData:(id)data {
    self.sectionTitle = sectionTitle;
    self.data = data;
    return self;    
}

- (id <TableViewSectionProtocol>) initWithTitle:(NSString *)sectionTitle; {
    self.sectionTitle = sectionTitle;
    return self;
}
- (id <TableViewSectionProtocol>) initWithTitle:(NSString *)sectionTitle andSectionCellDatas:(NSMutableArray *)sectionCellDatas {
    self.sectionTitle = sectionTitle;
    self.sectionCellDatas = sectionCellDatas;
    return self;
}

- (NSMutableArray *) sectionCellDatas {
    if(!_sectionCellDatas) _sectionCellDatas = [[NSMutableArray alloc] init];
    return _sectionCellDatas;
}

- (void) addSectionCellData:(id <TableViewSectionCellDataProtocol>)sectionCellData {
    [self.sectionCellDatas addObject:sectionCellData]; 
}

@end
