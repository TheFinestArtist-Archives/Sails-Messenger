//
//  AppDelegate.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 8. 29..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "AppDelegate.h"
#import "UIColor+Sails.h"
#import "SailsDefaults.h"
#import "User.h"
#import "UserViewController.h"
#import "ChatViewController.h"
#import "CatchPointViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [[UINavigationBar appearance] setTintColor:[UIColor turquoise:1]];
    } else {
        [[UINavigationBar appearance] setBarTintColor:[UIColor turquoise:1]];
    }
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    User *user = [SailsDefaults getUser];
    if(user == nil || user.username == nil || user.password == nil) {
        [SailsDefaults clear];
        CatchPointViewController *catchview = [[CatchPointViewController alloc] init];
        UINavigationController *navcontroller = [[UINavigationController alloc] initWithRootViewController:catchview];
        [self.window addSubview:navcontroller.view];
        self.window.rootViewController = navcontroller;
    } else {
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        
        UserViewController* vc1 = [[UserViewController alloc] init];
        ChatViewController* vc2 = [[ChatViewController alloc] init];
        
        NSArray* controllers = [NSArray arrayWithObjects:vc1, vc2, nil];
        tabBarController.viewControllers = controllers;
        
        // Add the tab bar controller's current view as a subview of the window
        [self.window addSubview:tabBarController.view];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
