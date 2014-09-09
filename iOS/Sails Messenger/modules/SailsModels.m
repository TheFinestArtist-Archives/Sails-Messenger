//
//  SailsModels.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 9..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "SailsModels.h"

@implementation SailsModels

+ (SailsModels *)sharedInstance {
    static SailsModels *model;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[SailsModels alloc]init];
        model.users = [NSDictionary dictionary];
        model.chats = [NSDictionary dictionary];
        model.messages = [NSDictionary dictionary];
    });
    
    return model;
}

+ (void)updateUsers:(NSArray *)users {
    for (User *user in users)
        [[self sharedInstance].users setValue:user forKey:[NSString stringWithFormat:@"%ld", user.id]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UsersUpdated object:nil];
}

+ (void)updateChats:(NSArray *)chats {
    for (Chat *chat in chats)
        [[self sharedInstance].chats setValue:chat forKey:[NSString stringWithFormat:@"%ld", chat.id]];
    [[NSNotificationCenter defaultCenter] postNotificationName:ChatsUpdated object:nil];
}

+ (void)updateMessages:(NSArray *)messages {
    for (Message *message in messages)
        [[self sharedInstance].messages setValue:message forKey:[NSString stringWithFormat:@"%ld", message.id]];
    [[NSNotificationCenter defaultCenter] postNotificationName:MessagesUpdated object:nil];
}

+ (void)setUser:(User *)user {
    [[self sharedInstance].users setValue:user forKey:[NSString stringWithFormat:@"%ld", user.id]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UsersUpdated object:nil];
}

+ (User *)getUser:(NSInteger)userID {
    return [[self sharedInstance].users objectForKey:[NSString stringWithFormat:@"%ld", userID]];
}

+ (void)setChat:(Chat *)chat {
    [[self sharedInstance].chats setValue:chat forKey:[NSString stringWithFormat:@"%ld", chat.id]];
    [[NSNotificationCenter defaultCenter] postNotificationName:ChatsUpdated object:nil];
}

+ (Chat *)getChat:(NSInteger)chatID {
    return [[self sharedInstance].chats objectForKey:[NSString stringWithFormat:@"%ld", chatID]];
}

+ (void)setMessage:(Message *)message {
    [[self sharedInstance].messages setValue:message forKey:[NSString stringWithFormat:@"%ld", message.id]];
    [[NSNotificationCenter defaultCenter] postNotificationName:MessagesUpdated object:nil];
}

+ (Message *)getMessage:(NSInteger)messageID {
    return [[self sharedInstance].messages objectForKey:[NSString stringWithFormat:@"%ld", messageID]];
}

+ (NSArray *)allUsers {
    return [[[self sharedInstance].users allValues] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSInteger userID1 = ((User *)obj1).id;
        NSInteger userID2 = ((User *)obj2).id;
        if (userID1 > userID2)
            return NSOrderedAscending;
        else
            return NSOrderedDescending;
    }];
}

+ (NSArray *)allChats {
    return [[[self sharedInstance].chats allValues] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [((Chat *)obj1).updatedAt compare:((Chat *)obj2).updatedAt];
    }];
}

+ (NSArray *)messagesOfChat:(NSInteger)chatID {
    return [NSArray array];
}

@end
