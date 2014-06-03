//
//  ScoreboardSectionProtocol.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreboardCellData.h"

@protocol SectionProtocol <NSObject>

- (void) renderCell:(id)cell withData:(ScoreboardCellData *)cellData;

@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSMutableArray *sectionCells;

@end
