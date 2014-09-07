//
//  SailsAPIs.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Chat.h"
#import "Message.h"

@interface SailsAPIs : NSObject

#define MESSENGER_URL @"http://sails-messenger.herokuapp.com"

+ (void)userListInSuccess:(void (^)(NSArray *users))success
                  failure:(void (^)(NSError *error))failure;

+ (void)signUpWithUsername:(NSString *)username
                  password:(NSString *)password
                   success:(void (^)(User *user))success
                   failure:(void (^)(NSError *error))failure;

+ (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                   success:(void (^)(User *user))success
                   failure:(void (^)(NSError *error))failure;

+ (void)verifyWithUsername:(NSString *)username
                  password:(NSString *)password
                   success:(void (^)(User *user))success
                   failure:(void (^)(NSError *error))failure;

+ (void)chatListInSuccess:(void (^)(NSArray *chats))success
                  failure:(void (^)(NSError *error))failure;

+ (void)chatStartWith:(NSString *)username
               friend:(NSString *)friendUsername
              success:(void (^)(Chat *chat))success
              failure:(void (^)(NSError *error))failure;

+ (void)chatJoinWith:(NSString *)username
              chatID:(int)chatID
             success:(void (^)(Chat *chat))success
             failure:(void (^)(NSError *error))failure;

+ (void)postMessageWith:(int)userID
                 chatID:(int)chatID
                content:(NSString *)content
                success:(void (^)(Message *message))success
                failure:(void (^)(NSError *error))failure;

@end
