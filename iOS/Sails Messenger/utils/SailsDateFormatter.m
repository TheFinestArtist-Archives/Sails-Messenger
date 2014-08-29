//
//  SailsDateFormatter.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "SailsDateFormatter.h"

@implementation SailsDateFormatter

+ (NSDate *)dateFromString:(NSString *)dateString {
    if (dateString == (NSString *) [NSNull null])
        return nil;
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
    [dateformatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    return [dateformatter dateFromString:dateString];
}

@end
