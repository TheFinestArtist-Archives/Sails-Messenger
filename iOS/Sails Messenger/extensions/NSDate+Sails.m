//
//  NSDate+Sails.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "NSDate+Sails.h"

@implementation NSDate (Sails)

+ (NSDate *)dateFromString:(NSString *)dateString {
    if (dateString == (NSString *) [NSNull null])
        return nil;
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateformatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    return [dateformatter dateFromString:dateString];
}

@end
