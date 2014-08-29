//
//  SailsDefaults.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

#define SailsUserKey @"sails_user_key"

@interface SailsDefaults : NSObject

+ (User *)getUser;

+ (void)setUser:(id)responseObject;

+ (void)clear;

@end
