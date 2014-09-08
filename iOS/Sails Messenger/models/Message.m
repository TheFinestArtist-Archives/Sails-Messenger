//
//  Message.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "Message.h"
#import "Chat.h"
#import "User.h"
#import "NSDate+Sails.h"
#import "NSDictionary+Sails.h"

@implementation SimpleMessage

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    dictionary = [dictionary dictionaryByReplacingNullsWithStrings];
    self = [super init];
    
    if (self) {
        self.id = [[dictionary objectForKey:@"id"] integerValue];
        self.createdAt = [NSDate dateFromString:[dictionary objectForKey:@"createdAt"]];
        self.updatedAt = [NSDate dateFromString:[dictionary objectForKey:@"updatedAt"]];
        self.content = [dictionary objectForKey:@"content"];
        self.chat = [[dictionary objectForKey:@"chat"] integerValue];
        self.author = [[dictionary objectForKey:@"author"] integerValue];
    }
    return self;
}

@end

@implementation Message

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    dictionary = [dictionary dictionaryByReplacingNullsWithStrings];
    self = [super init];
    
    if (self) {
        self.id = [[dictionary objectForKey:@"id"] integerValue];
        self.createdAt = [NSDate dateFromString:[dictionary objectForKey:@"createdAt"]];
        self.updatedAt = [NSDate dateFromString:[dictionary objectForKey:@"updatedAt"]];
        self.content = [dictionary objectForKey:@"content"];
        self.chat = [[SimpleChat alloc] initWithDictionary:[dictionary objectForKey:@"chat"]];
        self.author = [[SimpleUser alloc] initWithDictionary:[dictionary objectForKey:@"author"]];
    }
    return self;
}

@end
