//
//  UIColor+Sails.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "UIColor+Sails.h"

@implementation UIColor (Sails)

+ (UIColor *)turquoise:(CGFloat)alpha {
    return [UIColor colorWithRed:11.0f/255.0f green:143.0f/255.0f blue:162.0f/255.0f alpha:alpha];
}

+ (UIColor *)emerald:(CGFloat)alpha {
    return [UIColor colorWithRed:65.0f/255.0f green:186.0f/255.0f blue:194.0f/255.0f alpha:alpha];
}

+ (UIColor *)black:(CGFloat)alpha {
    return [UIColor colorWithRed:0.0f/255.0f green:28.0f/255.0f blue:32.0f/255.0f alpha:alpha];
}

+ (UIColor *)grey:(CGFloat)alpha {
    return [UIColor colorWithRed:228.0f/255.0f green:240.0f/255.0f blue:241.0f/255.0f alpha:alpha];
}

@end
