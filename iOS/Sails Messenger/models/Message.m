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
#import "SailsDateFormatter.h"
#import "NSDictionary+Sails.h"

@implementation Message

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    dictionary = [dictionary dictionaryByReplacingNullsWithStrings];
    self = [super init];
    
    if (self) {
        self.id = [[dictionary objectForKey:@"id"] integerValue];
        self.createdAt = [SailsDateFormatter dateFromString:[dictionary objectForKey:@"createdAt"]];
        self.updatedAt = [SailsDateFormatter dateFromString:[dictionary objectForKey:@"updatedAt"]];
        self.content = [dictionary objectForKey:@"content"];
        self.chat = [[Chat alloc] initWithDictionary:[dictionary objectForKey:@"chat"]];
        self.author = [[User alloc] initWithDictionary:[dictionary objectForKey:@"author"]];
    }
    return self;
}

@end
