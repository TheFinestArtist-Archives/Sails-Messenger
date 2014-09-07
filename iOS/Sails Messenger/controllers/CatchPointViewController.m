//
//  CatchPointViewController.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "CatchPointViewController.h"
#import "UIColor+Sails.h"
#import "UIImage+Sails.h"
#import "SignViewController.h"

@interface CatchPointViewController ()

@property UILabel *label;
@property UIButton *signup;
@property UIButton *login;

@end

@implementation CatchPointViewController

@synthesize label, signup, login;

- (void)viewDidLoad
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 7) {
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barTintColor = [UIColor turquoise:1];
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 30)];
    label.text = @"Messenger";
    label.font = [UIFont boldSystemFontOfSize:24];
    label.textColor = [UIColor turquoise:1];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    signup = [[UIButton alloc] initWithFrame:CGRectMake(20, [UIScreen mainScreen].bounds.size.height - 55, 90, 40)];
    signup.layer.cornerRadius = 4;
    signup.clipsToBounds = YES;
    [signup setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signup setBackgroundImage:[UIImage imageWithColor:[UIColor turquoise:0.7]] forState:UIControlStateNormal];
    [signup setBackgroundImage:[UIImage imageWithColor:[UIColor turquoise:0.8]] forState:UIControlStateHighlighted];
    [self.view addSubview:signup];
    
    login = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 110, [UIScreen mainScreen].bounds.size.height - 55, 90, 40)];
    login.layer.cornerRadius = 4;
    login.clipsToBounds = YES;
    [login setTitle:@"Log In" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor black:0.7] forState:UIControlStateNormal];
    [login setBackgroundImage:[UIImage imageWithColor:[UIColor black:0.2]] forState:UIControlStateNormal];
    [login setBackgroundImage:[UIImage imageWithColor:[UIColor black:0.25]] forState:UIControlStateHighlighted];
    [self.view addSubview:login];
    
    [signup addTarget:self action:@selector(signup:) forControlEvents:UIControlEventTouchUpInside];
    [login addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)signup:(id)sender {
    SignViewController *viewController = [[SignViewController alloc] init];
    viewController.signType = SIGN_UP;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

- (void)login:(id)sender {
    SignViewController *viewController = [[SignViewController alloc] init];
    viewController.signType = LOG_IN;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.navigationController presentViewController:navController animated:YES completion:nil];
}

@end
