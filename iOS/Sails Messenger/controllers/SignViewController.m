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

@interface SignViewController ()

@property NSString *title;
@property UITableView *tableView;
@property UIScreen *mainScreen;
@property UITextField *usernameField;
@property UITextField *passwordField;

@end

@implementation SignViewController

@synthesize signType, title, tableView, mainScreen, usernameField, passwordField;

- (void)viewDidLoad
{
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
    self.navigationItem.titleView = titlelabel;
    titlelabel.text = title;
    [titlelabel sizeToFit];
    
    UIBarButtonItem *close = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleDone target:self action:@selector(close:)];
    self.navigationItem.leftBarButtonItem = close;
    
    UIBarButtonItem *sign = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleDone target:self action:@selector(sign:)];
    self.navigationItem.rightBarButtonItem = sign;
    
    mainScreen = [UIScreen mainScreen];
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, mainScreen.bounds.size.width, mainScreen.bounds.size.height)];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [usernameField becomeFirstResponder];
}

// UITableViewDataSource & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *tableViewcCell = [[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, mainScreen.bounds.size.width, 44)];
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
            break;
    }
    return tableViewcCell;
}


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
                                  } failure:^(NSError *error) {
                                      [hud hide:YES];
                                      sign.enabled = YES;
                                  }];
            break;
        }
    }
}

@end
