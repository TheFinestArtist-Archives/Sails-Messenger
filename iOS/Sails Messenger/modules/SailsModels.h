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

@interface SailsModels : NSObject

@property (strong, atomic) NSDictionary *users;
@property (strong, atomic) NSDictionary *chats;
@property (strong, atomic) NSDictionary *messages;

+ (SailsModels *)sharedInstance;

+ updateUsers:(NSArray *)users;
+ updateChats:(NSArray *)chats;
+ updateMessages:(NSArray *)messages;

+ setUser:(User *)user;
+ (User *)getUser:(NSInteger)userID;

+ setChat:(Chat *)chat;
+ (Chat *)getChat:(NSInteger)chatID;

+ setMessage:(Message *)message;
+ (Message *)getMessage:(NSInteger)messageID;

+ (NSDictionary *)messagesOfChat:(NSInteger)chatID;

@end
