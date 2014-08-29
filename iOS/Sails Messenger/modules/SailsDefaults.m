//
//  SailsDefaults.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "SailsDefaults.h"

@implementation SailsDefaults

+ (User *)getUser {
    NSString *jsonString = [[NSUserDefaults standardUserDefaults] stringForKey:SailsUserKey];
    if (jsonString == nil)
        return nil;
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    User *user = [[User alloc] initWithDictionary:json];
    return user;
}

+ (void)setUser:(id)responseObject {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [defaults setObject:jsonString forKey:SailsUserKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)clear {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * keys = [defaults dictionaryRepresentation];
    for (id key in keys)
        [defaults removeObjectForKey:key];
    [defaults synchronize];
}

@end
