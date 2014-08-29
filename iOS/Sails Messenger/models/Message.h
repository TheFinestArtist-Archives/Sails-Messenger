//
//  Message.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class Chat;

@interface Message : NSObject

@property(assign) NSInteger id;
@property(strong, nonatomic) NSDate  *createdAt;
@property(strong, nonatomic) NSDate  *updatedAt;
@property(strong, nonatomic) NSString  *content;
@property(strong, nonatomic) Chat  *chat;
@property(strong, nonatomic) User  *author;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
