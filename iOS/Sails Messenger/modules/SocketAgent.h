//
//  SocketAgent.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <socket.IO/SocketIO.h>

@interface SocketAgent : NSObject <SocketIODelegate>

@property (strong, atomic) SocketIO *socketIO;
@property (assign) NSInteger reconnectTry;

+ (SocketAgent *)sharedInstance;

- (void)socketConnect;
- (void)socketJoin;

@end
