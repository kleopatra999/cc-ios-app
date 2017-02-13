//
//  UIColor+DVNTAdditions.m
//  DVNTUtilities
//
//  Created by deviantART.
//  Copyright (c) 2014 deviantART. All rights reserved.
//

#import "UIColor+DVNTAdditions.h"

@implementation UIColor (DVNTAdditions)

#pragma mark - Lightening/Darkening

// Grabbed from Stackoverflow
// TODO: REMOVE
+ (UIColor *)dvnt_darkenColor:(UIColor *)oldColor percentOfOriginal:(float)amount {
    float percentage      = amount / 100.0;
    size_t  totalComponents = CGColorGetNumberOfComponents(oldColor.CGColor);
    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
    
    CGFloat* oldComponents = (CGFloat *)CGColorGetComponents(oldColor.CGColor);
    CGFloat newComponents[4];
    
    if (isGreyscale) {
        newComponents[0] = oldComponents[0]*percentage;
        newComponents[1] = oldComponents[0]*percentage;
        newComponents[2] = oldComponents[0]*percentage;
        newComponents[3] = oldComponents[1];
    } else {
        newComponents[0] = oldComponents[0]*percentage;
        newComponents[1] = oldComponents[1]*percentage;
        newComponents[2] = oldComponents[2]*percentage;
        newComponents[3] = oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}

+ (UIColor *)dvnt_lightenColor:(UIColor *)oldColor byPercentage:(float)amount {
    float percentage      = amount / 100.0;
    size_t  totalComponents = CGColorGetNumberOfComponents(oldColor.CGColor);
    bool  isGreyscale     = totalComponents == 2 ? YES : NO;
    
    CGFloat* oldComponents = (CGFloat *)CGColorGetComponents(oldColor.CGColor);
    CGFloat newComponents[4];
    
    if (isGreyscale) {
        newComponents[0] = oldComponents[0]*percentage + oldComponents[0] > 1.0 ? 1.0 : oldComponents[0]*percentage + oldComponents[0];
        newComponents[1] = oldComponents[0]*percentage + oldComponents[0] > 1.0 ? 1.0 : oldComponents[0]*percentage + oldComponents[0];
        newComponents[2] = oldComponents[0]*percentage + oldComponents[0] > 1.0 ? 1.0 : oldComponents[0]*percentage + oldComponents[0];
        newComponents[3] = oldComponents[0]*percentage + oldComponents[1] > 1.0 ? 1.0 : oldComponents[1]*percentage + oldComponents[1];
    } else {
        newComponents[0] = oldComponents[0]*percentage + oldComponents[0] > 1.0 ? 1.0 : oldComponents[0]*percentage + oldComponents[0];
        newComponents[1] = oldComponents[1]*percentage + oldComponents[1] > 1.0 ? 1.0 : oldComponents[0]*percentage + oldComponents[1];
        newComponents[2] = oldComponents[2]*percentage + oldComponents[2] > 1.0 ? 1.0 : oldComponents[0]*percentage + oldComponents[2];
        newComponents[3] = oldComponents[3]*percentage + oldComponents[3] > 1.0 ? 1.0 : oldComponents[0]*percentage + oldComponents[3];
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGColorRef newColor = CGColorCreate(colorSpace, newComponents);
	CGColorSpaceRelease(colorSpace);
    
	UIColor *retColor = [UIColor colorWithCGColor:newColor];
	CGColorRelease(newColor);
    
    return retColor;
}


@end
