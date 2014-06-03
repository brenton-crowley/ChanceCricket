//
//  ScoreboardTableCellProtocol.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 10/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Inning+Factory.h"

@protocol ScoreboardTableCellProtocol <NSObject>

- (void) invalidate:(Inning *)inning;

@property (nonatomic, strong) NSString *cellType;

@end
