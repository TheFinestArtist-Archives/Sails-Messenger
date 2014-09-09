//
//  Chat.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleChat : NSObject

@property(assign) NSInteger id;
@property(strong, nonatomic) NSDate  *createdAt;
@property(strong, nonatomic) NSDate  *updatedAt;
@property(strong, nonatomic) NSArray  *chatters;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

@interface Chat : NSObject

@property(assign) NSInteger id;
@property(strong, nonatomic) NSDate  *createdAt;
@property(strong, nonatomic) NSDate  *updatedAt;
@property(strong, nonatomic) NSArray  *chatters;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
