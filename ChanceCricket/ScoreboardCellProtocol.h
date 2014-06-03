//
//  ScoreboardCellProtocol.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScoreboardCellProtocol <NSObject>

+ (CGFloat) cellHeight;
+ (NSString *) cellReuseID;

@end
