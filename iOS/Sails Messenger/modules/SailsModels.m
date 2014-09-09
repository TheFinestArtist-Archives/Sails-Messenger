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
        model.simpleUsers = [NSDictionary dictionary];
        model.simpleChats = [NSDictionary dictionary];
        model.users = [NSDictionary dictionary];
        model.chats = [NSDictionary dictionary];
        model.messages = [NSDictionary dictionary];
    });
    
    return model;
}

@end
