//
//  SocketAgent.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "SocketAgent.h"
#import "SocketIOPacket.h"
#import "SailsDefaults.h"
#import "User.h"
#import "Chat.h"
#import "Message.h"

#define UserReceived @"user_received"
#define ChatReceived @"chat_received"
#define MessageReceived @"message_received"

@implementation SocketAgent

@synthesize socketIO, reconnectTry;

+ (SocketAgent *)sharedInstance {
    static SocketAgent *agent;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        agent = [[SocketAgent alloc]init];
    });
    
    return agent;
}

- (id)init {
    self = [super init];
    socketIO = [[SocketIO alloc] initWithDelegate:self];
    reconnectTry = 0;
    return self;
}

#pragma Socket.id
- (void)socketConnect {
    if (!socketIO.isConnecting && !socketIO.isConnected)
        [socketIO connectToHost:@"sails-messenger.herokuapp.com" onPort:0];
}

- (void)socketJoin {
    if (socketIO.isConnected) {
        NSString *url = [NSString stringWithFormat:@"/sockets/join?username=%@",
                         [SailsDefaults getUser].username];
        NSDictionary *params = @{@"url" : url};
        [socketIO sendEvent:@"put" withData:params];
    } else
        [self socketConnect];
}

#pragma Socket.io Delegate
- (void)socketIODidConnect:(SocketIO *)socket {
    [self socketJoin];
}

- (void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, reconnectTry * 5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self socketConnect];
    });
    
    reconnectTry ++;
}

- (void)socketIO:(SocketIO *)socket onError:(NSError *)error {
    
}

- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet {
    id data = [packet dataAsJSON];
    
    if ([[[packet dataAsJSON] objectForKey:@"name"] isEqual:@"user"]) {
        User *user = [[User alloc] initWithDictionary:[data objectForKey:@"args"][0]];
        [[NSNotificationCenter defaultCenter] postNotificationName:UserReceived object:user];
    }
    
    if ([[[packet dataAsJSON] objectForKey:@"name"] isEqual:@"chat"]) {
        Chat *chat = [[Chat alloc] initWithDictionary:[data objectForKey:@"args"][0]];
        [[NSNotificationCenter defaultCenter] postNotificationName:ChatReceived object:chat];
    }
    
    if ([[[packet dataAsJSON] objectForKey:@"name"] isEqual:@"message"]) {
        Message *message = [[Message alloc] initWithDictionary:[data objectForKey:@"args"][0]];
        [[NSNotificationCenter defaultCenter] postNotificationName:MessageReceived object:message];
    }
}

@end
