//
//  MessageViewController.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "Chat.h"

@interface MessageViewController : UITableViewController
@property(strong, nonatomic) User *user;
@property(strong, nonatomic) Chat *chat;
@end
