//
//  CommentaryView.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 09/03/2012.
//  Copyright (c) 2012 N/A. All rights reserved.
//

#import "CommentaryView.h"

@interface CommentaryView ()

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, 
                        CGColorRef  endColor);

@end

@implementation CommentaryView

@synthesize label = _label;
@synthesize primaryColourHex = _primaryColourHex;
@synthesize secondaryColourHex = _secondaryColourHex;

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, 
                        CGColorRef  endColor) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = [NSArray arrayWithObjects:(__bridge id)startColor, (__bridge id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, 
                                                        (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    
    UInt32 baseColour = self.primaryColourHex;
//
//    CGColorRef highlightColour = [self lightenDarkenColour:baseColour byAmount:20].CGColor;
    CGColorRef primaryColour = [self colorWithHex:baseColour].CGColor;    
    CGColorRef highlightColour = [self lightenDarkenColor:baseColour byAmount:0.0].CGColor;

    CGRect paperRect = self.bounds;

    drawLinearGradient(context, paperRect, primaryColour, highlightColour);
        
    self.label.textColor = [self colorWithHex:self.secondaryColourHex];
}

- (UIColor *)colorWithHex:(UInt32)hexadecimal {
	CGFloat red, green, blue;
	
	// Bit shift right the hexadecimal's first 2 values
	red = (hexadecimal >> 16) & 0xFF;
	// Bit shift right the hexadecimal's 2 middle values
	green = (hexadecimal >> 8) & 0xFF;
	// Bit shift right the hexadecimal's last 2 values
	blue = hexadecimal & 0xFF;
	
    return [UIColor colorWithRed: red / 255.0f green: green / 255.0f blue: blue / 255.0f alpha: 1.0f];
}

- (UIColor *)lightenDarkenColor:(UInt32)col byAmount:(double)amt {
    UInt32 num = col;
    UInt32 r = (num >> 16) + amt;
    UInt32 b = ((num >> 8) & 0x00FF) + amt;
    UInt32 g = (num & 0x0000FF) + amt;
    UInt32 newColor = g | (b << 8) | (r << 16);
    return [self colorWithHex:newColor];
}

@end
