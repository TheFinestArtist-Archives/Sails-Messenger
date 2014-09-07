//
//  SailsAPIs.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "SailsAPIs.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "AFNetworkActivityLogger.h"
#import "SailsDefaults.h"

static NSString * const AFResponseSerializerKey = @"AFResponseSerializerKey";

@interface AFResponseSerializer : AFJSONResponseSerializer

@end

@implementation AFResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
	id JSONObject = [super responseObjectForResponse:response data:data error:error];
	if (*error != nil) {
		NSMutableDictionary *userInfo = [(*error).userInfo mutableCopy];
		if (data != nil) {
            NSError* error;
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:kNilOptions
                                                                   error:&error];
            if (error == nil)
                userInfo[AFResponseSerializerKey] = json;
        }
		NSError *newError = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
		(*error) = newError;
	}
    
	return (JSONObject);
}

@end


@implementation SailsAPIs

+ (AFHTTPRequestOperationManager *)sharedAFManager
{
	static AFHTTPRequestOperationManager *manager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		manager = [AFHTTPRequestOperationManager manager];
		manager.responseSerializer = [AFResponseSerializer serializer];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        [[AFNetworkActivityLogger sharedLogger] startLogging];
        [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
	});
	return manager;
}

+ (void)userListInSuccess:(void (^)(NSArray *users))success
                  failure:(void (^)(NSError *error))failure {
    
    [[self sharedAFManager] GET:[MESSENGER_URL stringByAppendingString:@"/user"]
                     parameters:nil
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                NSMutableArray *users = [NSMutableArray array];
                                for (NSDictionary *dic in responseObject) {
                                    User *user = [[User alloc] initWithDictionary:dic];
                                    [users addObject:user];
                                }
                                dispatch_async( dispatch_get_main_queue(), ^{
                                    success(users);
                                });
                            });
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            failure(error);
                        }];
}

+ (void)signUpWithUsername:(NSString *)username
                  password:(NSString *)password
                   success:(void (^)(User *user))success
                   failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = @{@"username" : username,
                             @"password" : password};
    
    [[self sharedAFManager] POST:[MESSENGER_URL stringByAppendingString:@"/user"]
                     parameters:params
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                 [SailsDefaults setUser:responseObject];
                                 User *user = [[User alloc] initWithDictionary:responseObject];
                                 dispatch_async( dispatch_get_main_queue(), ^{
                                     success(user);
                                 });
                             });
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            failure(error);
                        }];
}

+ (void)verifyWithUsername:(NSString *)username
                  password:(NSString *)password
                   success:(void (^)(User *user))success
                   failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = @{@"username" : username,
                             @"password" : password};
    
    [[self sharedAFManager] GET:[MESSENGER_URL stringByAppendingString:@"/auth/verify"]
                      parameters:params
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                [SailsDefaults setUser:responseObject];
                                User *user = [[User alloc] initWithDictionary:responseObject];
                                dispatch_async( dispatch_get_main_queue(), ^{
                                    success(user);
                                });
                            });
                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             failure(error);
                         }];
}

+ (void)chatListInSuccess:(void (^)(NSArray *chats))success
                  failure:(void (^)(NSError *error))failure {
    
    [[self sharedAFManager] GET:[MESSENGER_URL stringByAppendingString:@"/chat"]
                     parameters:nil
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                NSMutableArray *chats = [NSMutableArray array];
                                for (NSDictionary *dic in responseObject) {
                                    Chat *chat = [[Chat alloc] initWithDictionary:dic];
                                    [chats addObject:chat];
                                }
                                dispatch_async( dispatch_get_main_queue(), ^{
                                    success(chats);
                                });
                            });
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            failure(error);
                        }];
}


+ (void)chatStartWith:(NSString *)username
               friend:(NSString *)friendUsername
              success:(void (^)(Chat *chat))success
              failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = @{@"username" : username,
                             @"friend" : friendUsername};
    
    [[self sharedAFManager] POST:[MESSENGER_URL stringByAppendingString:@"/chat/start"]
                     parameters:params
                        success:^(AFHTTPRequestOperation *operation, id responseObject) {
                            dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                Chat *chat = [[Chat alloc] initWithDictionary:responseObject];
                                dispatch_async( dispatch_get_main_queue(), ^{
                                    success(chat);
                                });
                            });
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            failure(error);
                        }];
}

+ (void)chatJoinWith:(NSString *)username
              chatID:(int)chatID
             success:(void (^)(Chat *chat))success
             failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = @{@"username" : username,
                             @"chat_id" : [NSString stringWithFormat:@"%ld", (long)chatID]};
    
    [[self sharedAFManager] PUT:[MESSENGER_URL stringByAppendingString:@"/chat/join"]
                      parameters:params
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                 Chat *chat = [[Chat alloc] initWithDictionary:responseObject];
                                 dispatch_async( dispatch_get_main_queue(), ^{
                                     success(chat);
                                 });
                             });
                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             failure(error);
                         }];
}

+ (void)postMessageWith:(int)userID
                 chatID:(int)chatID
                content:(NSString *)content
                success:(void (^)(Message *message))success
                failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = @{@"content" : content,
                             @"author" : [NSString stringWithFormat:@"%ld", (long)userID],
                             @"chat" : [NSString stringWithFormat:@"%ld", (long)chatID]};
    
    [[self sharedAFManager] POST:[MESSENGER_URL stringByAppendingString:@"/message"]
                      parameters:params
                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                             dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                 Message *message = [[Message alloc] initWithDictionary:responseObject];
                                 dispatch_async( dispatch_get_main_queue(), ^{
                                     success(message);
                                 });
                             });
                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             failure(error);
                         }];
}

@end
