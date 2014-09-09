//
//  SailsModels.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 9..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Chat.h"
#import "Message.h"

#define UsersUpdated @"users_updated"
#define ChatsUpdated @"chats_updated"
#define MessagesUpdated @"messages_updated"

@interface SailsModels : NSObject

@property (strong, atomic) NSMutableDictionary *users;
@property (strong, atomic) NSMutableDictionary *chats;
@property (strong, atomic) NSMutableDictionary *messages;

+ (SailsModels *)sharedInstance;

+ (void)updateUsers:(NSArray *)users;
+ (void)updateChats:(NSArray *)chats;
+ (void)updateMessages:(NSArray *)messages;

+ (void)setUser:(User *)user;
+ (User *)getUser:(NSInteger)userID;

+ (void)setChat:(Chat *)chat;
+ (Chat *)getChat:(NSInteger)chatID;

+ (void)setMessage:(Message *)message;
+ (Message *)getMessage:(NSInteger)messageID;

+ (NSArray *)allUsers;
+ (NSArray *)allChats;
+ (NSArray *)messagesOfChat:(NSInteger)chatID;

@end
