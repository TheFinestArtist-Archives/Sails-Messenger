//
//  NSDictionary+Sails.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "NSDictionary+Sails.h"

@implementation NSDictionary (Sails)

- (NSDictionary *)dictionaryByReplacingNullsWithStrings {
    
    NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary:self];
    const id null = [NSNull null];
    const NSString *blank = @"";
    
    for(NSString *key in self) {
        const id object = [self objectForKey:key];
        if(object == null) {
            [replaced setObject:blank forKey:key];
        }
    }
    return [NSDictionary dictionaryWithDictionary:replaced];
}

@end
