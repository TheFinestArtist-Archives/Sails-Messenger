//
//  Chat.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "Chat.h"
#import "User.h"
#import "Message.h"
#import "SailsDateFormatter.h"
#import "NSDictionary+Sails.h"

@implementation Chat

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    dictionary = [dictionary dictionaryByReplacingNullsWithStrings];
    self = [super init];
    
    if (self) {
        self.id = [[dictionary objectForKey:@"id"] integerValue];
        self.createdAt = [SailsDateFormatter dateFromString:[dictionary objectForKey:@"createdAt"]];
        self.updatedAt = [SailsDateFormatter dateFromString:[dictionary objectForKey:@"updatedAt"]];
        
        NSMutableArray *chatters = [NSMutableArray array];
        for (NSDictionary *dic in [dictionary objectForKey:@"chatters"]) {
            User *chatter = [[User alloc] initWithDictionary:dic];
            [chatters addObject:chatter];
        }
        self.chatters = chatters;
        
        NSMutableArray *messages = [NSMutableArray array];
        for (NSDictionary *dic in [dictionary objectForKey:@"messages"]) {
            Message *message = [[Message alloc] initWithDictionary:dic];
            [messages addObject:message];
        }
        self.messages = messages;
    }
    return self;
}

@end
