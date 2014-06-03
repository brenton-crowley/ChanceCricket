//
//  CommentaryView.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 09/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "ColorSpaceUtilities.h"

@interface CommentaryView : UIView

@property (nonatomic, weak) IBOutlet UILabel *label;
@property (nonatomic) UInt32 primaryColourHex;
@property (nonatomic) UInt32 secondaryColourHex;

@end
