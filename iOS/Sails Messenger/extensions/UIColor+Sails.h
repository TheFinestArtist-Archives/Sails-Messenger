//
//  UIColor+Sails.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

//sails-turquoise: #0b8fa2 => 11, 143, 162
//sails-emerald : #41bac2 => 65, 186, 194
//sails-black : #001c20 => 0, 28, 32
//sails-grey : #e4f0f1 => 228, 240, 241

#import <Foundation/Foundation.h>

@interface UIColor (Sails)

+ (UIColor *)turquoise:(CGFloat)alpha;

+ (UIColor *)emerald:(CGFloat)alpha;

+ (UIColor *)grey:(CGFloat)alpha;

+ (UIColor *)black:(CGFloat)alpha;

@end
