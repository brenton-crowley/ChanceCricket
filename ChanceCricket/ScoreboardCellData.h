//
//  ScoreboardCellData.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreboardCellData : NSObject

- (ScoreboardCellData *) initWithData:(id)data setReuseIdentifier:(NSString *)reuseIdentifier setCellHeight:(CGFloat)cellHeight;

@property (strong, nonatomic) id data;
@property (strong, nonatomic) NSString *reuseIdentifier;

@property (nonatomic) CGFloat cellHeight;

@end
