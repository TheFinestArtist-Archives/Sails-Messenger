//
//  User.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleUser : NSObject

@property(assign) NSInteger id;
@property(strong, nonatomic) NSDate  *createdAt;
@property(strong, nonatomic) NSDate  *updatedAt;
@property(strong, nonatomic) NSString  *username;
@property(strong, nonatomic) NSString  *password;
@property(strong, nonatomic) NSArray  *friends;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface User : NSObject

@property(assign) NSInteger id;
@property(strong, nonatomic) NSDate  *createdAt;
@property(strong, nonatomic) NSDate  *updatedAt;
@property(strong, nonatomic) NSString  *username;
@property(strong, nonatomic) NSString  *password;
@property(strong, nonatomic) NSArray  *chats;
@property(strong, nonatomic) NSArray  *friends;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
