//
//  User.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "User.h"
#import "Chat.h"
#import "SailsDateFormatter.h"
#import "NSDictionary+Sails.h"

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    dictionary = [dictionary dictionaryByReplacingNullsWithStrings];
    self = [super init];
    
    if (self) {
        self.id = [[dictionary objectForKey:@"id"] integerValue];
        self.createdAt = [SailsDateFormatter dateFromString:[dictionary objectForKey:@"createdAt"]];
        self.updatedAt = [SailsDateFormatter dateFromString:[dictionary objectForKey:@"updatedAt"]];
        self.username = [dictionary objectForKey:@"username"];
        self.password = [dictionary objectForKey:@"password"];
        
        NSMutableArray *chats = [NSMutableArray array];
        for (NSDictionary *dic in [dictionary objectForKey:@"chats"]) {
            Chat *chat = [[Chat alloc] initWithDictionary:dic];
            [chats addObject:chat];
        }
        self.chats = chats;
        
        self.friends = [dictionary objectForKey:@"friends"];
    }
    return self;
}

@end
