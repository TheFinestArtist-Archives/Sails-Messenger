//
//  SignViewController.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "SignViewController.h"
#import "UIColor+Sails.h"
#import "SailsAPIs.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UserViewController.h"
#import "ChatViewController.h"
#import "AppDelegate.h"

@interface SignViewController ()

@property NSString *title;
@property UIScreen *mainScreen;
@property UITextField *usernameField;
@property UITextField *passwordField;

@end

@implementation SignViewController

@synthesize signType, title, usernameField, passwordField;

- (void)viewDidLoad
{
    self.navigationController.navigationBar.translucent = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    switch (signType) {
        case SIGN_UP:
            title = @"Sign Up";
            break;
        case LOG_IN:
            title = @"Log In";
            break;
    }
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont boldSystemFontOfSize:16.0];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.text = title;
    [titlelabel sizeToFit];
    self.navigationItem.titleView = titlelabel;
    
    UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close:)];
    self.navigationItem.leftBarButtonItem = close;
    
    UIBarButtonItem *sign = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(sign:)];
    self.navigationItem.rightBarButtonItem = sign;
    
    super.tableView.backgroundColor = [UIColor whiteColor];
    super.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    super.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidAppear:(BOOL)animated {
    [usernameField becomeFirstResponder];
}

// UITableViewDataSource & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewcCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    tableViewcCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    tableViewcCell.textLabel.textColor = [UIColor turquoise:1];
    tableViewcCell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    
    UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(98, 2, 222, 40)];
    textfield.tintColor = [UIColor black:1];
    textfield.font = [UIFont systemFontOfSize:16];
    textfield.keyboardType = UIKeyboardTypeEmailAddress;
    textfield.returnKeyType = UIReturnKeyNext;
    textfield.autocorrectionType = UITextAutocorrectionTypeNo;
    textfield.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textfield.delegate = self;
    [tableViewcCell addSubview:textfield];
    
    UIView *underline = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
    underline.backgroundColor = [UIColor grey:1];
    [tableViewcCell addSubview:underline];
    
    switch (indexPath.row) {
        case 0:
            tableViewcCell.textLabel.text = @"Username";
            usernameField = textfield;
            break;
        case 1:
            tableViewcCell.textLabel.text = @"Password";
            passwordField = textfield;
            passwordField.returnKeyType = UIReturnKeyDone;
            passwordField.secureTextEntry = YES;
            break;
    }
    return tableViewcCell;
}

// UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:usernameField]) {
        [passwordField becomeFirstResponder];
    }
    
    if ([textField isEqual:passwordField]) {
        [passwordField resignFirstResponder];
        [self sign:nil];
    }
    
    return NO;
    
}

// UIBarButtonItem
- (void)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sign:(id)sender {
    
    NSString *username = usernameField.text;
    NSString *password = passwordField.text;
    
    if (username == nil || username.length == 0
        || password == nil || password.length == 0)
        return;
    
    UIBarButtonItem *sign = (UIBarButtonItem *)sender;
    sign.enabled = NO;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.color = [UIColor emerald:0.7];
    hud.labelText = title;
    hud.detailsLabelText = @"Loading...";
    hud.yOffset = -40.0f;
    
    switch (signType) {
        case SIGN_UP: {
            [SailsAPIs signUpWithUsername:username
                                 password:password
                                  success:^(User *user) {
                                      [hud hide:YES];
                                      sign.enabled = YES;
                                      [self showTabView];
                                  } failure:^(NSError *error) {
                                      [hud hide:YES];
                                      sign.enabled = YES;
                                  }];
            break;
        }
        case LOG_IN: {
            [SailsAPIs signInWithUsername:username
                                 password:password
                                  success:^(User *user) {
                                      [hud hide:YES];
                                      sign.enabled = YES;
                                      [self showTabView];
                                  } failure:^(NSError *error) {
                                      [hud hide:YES];
                                      sign.enabled = YES;
                                  }];
            break;
        }
    }
}

- (void)showTabView {
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    UserViewController* vc1 = [[UserViewController alloc] initWithStyle:UITableViewStyleGrouped];
    ChatViewController* vc2 = [[ChatViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    NSArray* controllers = [NSArray arrayWithObjects:vc1, vc2, nil];
    tabBarController.viewControllers = controllers;
    
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Chatter" image:nil selectedImage:nil];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Room" image:nil selectedImage:nil];
    
    UINavigationController *navcontroller = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:navcontroller.view];
    appDelegate.window.rootViewController = navcontroller;
}

@end
