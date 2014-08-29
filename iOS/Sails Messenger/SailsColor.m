//
//  SailsColor.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//


//sails-turquoise: #0b8fa2 => 11, 143, 162
//sails-emerald : #41bac2 => 65, 186, 194
//sails-black : #001c20 => 0, 28, 32
//sails-grey : #e4f0f1 => 228, 240, 241

#import "SailsColor.h"

@implementation SailsColor

+ (UIColor *)turquoise:(CGFloat)alpha {
    return [UIColor colorWithRed:11/255 green:143/255 blue:162/255 alpha:alpha];
}

+ (UIColor *)emerald:(CGFloat)alpha {
    return [UIColor colorWithRed:65/255 green:186/255 blue:194/255 alpha:alpha];
}

+ (UIColor *)grey:(CGFloat)alpha {
    return [UIColor colorWithRed:0/255 green:28/255 blue:32/255 alpha:alpha];
}

+ (UIColor *)black:(CGFloat)alpha {
    return [UIColor colorWithRed:228/255 green:240/255 blue:241/255 alpha:alpha];
}

@end
