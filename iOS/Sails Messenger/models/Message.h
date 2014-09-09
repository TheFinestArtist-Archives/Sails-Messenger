//
//  Message.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SimpleUser;
@class SimpleChat;

@interface SimpleMessage : NSObject

@property(assign) NSInteger id;
@property(strong, nonatomic) NSDate  *createdAt;
@property(strong, nonatomic) NSDate  *updatedAt;
@property(strong, nonatomic) NSString  *content;
@property(assign) NSInteger  chat;
@property(assign) NSInteger  author;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface Message : NSObject

@property(assign) NSInteger id;
@property(strong, nonatomic) NSDate  *createdAt;
@property(strong, nonatomic) NSDate  *updatedAt;
@property(strong, nonatomic) NSString  *content;
@property(assign) NSInteger  chat;
@property(strong, nonatomic) SimpleUser  *author;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
