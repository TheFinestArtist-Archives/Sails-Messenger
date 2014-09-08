//
//  User.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "User.h"
#import "Chat.h"
#import "NSDate+Sails.h"
#import "NSDictionary+Sails.h"

@implementation SimpleUser

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    dictionary = [dictionary dictionaryByReplacingNullsWithStrings];
    self = [super init];
    
    if (self) {
        self.id = [[dictionary objectForKey:@"id"] integerValue];
        self.createdAt = [NSDate dateFromString:[dictionary objectForKey:@"createdAt"]];
        self.updatedAt = [NSDate dateFromString:[dictionary objectForKey:@"updatedAt"]];
        self.username = [dictionary objectForKey:@"username"];
        self.password = [dictionary objectForKey:@"password"];
        self.friends = [dictionary objectForKey:@"friends"];
    }
    return self;
}

@end

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    dictionary = [dictionary dictionaryByReplacingNullsWithStrings];
    self = [super init];
    
    if (self) {
        self.id = [[dictionary objectForKey:@"id"] integerValue];
        self.createdAt = [NSDate dateFromString:[dictionary objectForKey:@"createdAt"]];
        self.updatedAt = [NSDate dateFromString:[dictionary objectForKey:@"updatedAt"]];
        self.username = [dictionary objectForKey:@"username"];
        self.password = [dictionary objectForKey:@"password"];
        
        NSMutableArray *chats = [NSMutableArray array];
        for (NSDictionary *dic in [dictionary objectForKey:@"chats"]) {
            SimpleChat *chat = [[SimpleChat alloc] initWithDictionary:dic];
            [chats addObject:chat];
        }
        self.chats = chats;
        
        self.friends = [dictionary objectForKey:@"friends"];
    }
    return self;
}

@end
