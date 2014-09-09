//
//  UserViewController.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "UserViewController.h"
#import "UIColor+Sails.h"
#import "User.h"
#import "SailsDefaults.h"
#import "SailsAPIs.h"
#import "MessageViewController.h"

@interface UserViewController ()

@property UITableView *tableview;
@property User *me;
@property NSMutableArray *friends;
@property NSMutableArray *others;

@end

@implementation UserViewController

@synthesize tableview, me, friends, others;

static NSString *CellIdentifier = @"UserCell";

- (void)viewDidLoad
{
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;

    self.view.backgroundColor = [UIColor whiteColor];
    
    tableview = [[UITableView alloc] initWithFrame:self.view.bounds
                                             style:UITableViewStyleGrouped];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
    me = [SailsDefaults getUser];
}

- (void)viewWillAppear:(BOOL)animated {
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont boldSystemFontOfSize:16.0];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.text = @"Chatter";
    [titlelabel sizeToFit];
    self.tabBarController.navigationItem.titleView = titlelabel;
    
    [SailsAPIs verifyWithUsername:me.username
                         password:me.password
                          success:^(User *user) {
                              me = user;
                              [tableview reloadData];
                          } failure:^(NSError *error) {
                          }];
    
    [SailsAPIs userListInSuccess:^(NSArray *users) {
        friends = [NSMutableArray array];
        others = [NSMutableArray array];
        for (SimpleUser *user in users) {
            BOOL isFriend = NO;
            for (NSObject *userID in me.friends)
                if ((NSInteger)userID == user.id)
                    isFriend = YES;
            
            if (isFriend)
                [friends addObject:user];
            else
                [others addObject:user];
        }
        [tableview reloadData];
    } failure:^(NSError *error) {
    }];
}

// UITableViewDataSource & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (friends == nil || others == nil)
        return 0;
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            if (friends.count == 0)
                return @"No Friend Yet :(";
            else if (friends.count == 1)
                return @"Friend";
            else
                return @"Friends";
        case 1:
        default:
            return @"Others";
    }
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor black:1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return friends.count;
        case 1:
            return others.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *tableViewcCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (tableViewcCell == nil) {
        tableViewcCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        tableViewcCell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableViewcCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
        
        tableViewcCell.textLabel.textColor = [UIColor turquoise:1];
        tableViewcCell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        
        UIView *underline = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 320, 1)];
        underline.backgroundColor = [UIColor grey:1];
        [tableViewcCell addSubview:underline];
    }
    
    SimpleUser *user;
    switch (indexPath.section) {
        case 0:
            user = [friends objectAtIndex:indexPath.row];
            break;
        case 1:
            user = [others objectAtIndex:indexPath.row];
            break;
    }
    tableViewcCell.textLabel.text = user.username;
    
    return tableViewcCell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor grey:1] ForCell:cell];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self setCellColor:[UIColor whiteColor] ForCell:cell];
}

- (void)setCellColor:(UIColor *)color ForCell:(UITableViewCell *)cell {
    cell.contentView.backgroundColor = color;
    cell.backgroundColor = color;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SimpleUser *user;
    switch (indexPath.section) {
        case 0:
            user = [friends objectAtIndex:indexPath.row];
            break;
        case 1:
            user = [others objectAtIndex:indexPath.row];
            break;
    }
    
    MessageViewController *viewController = [[MessageViewController alloc] init];
    viewController.simpleUser = user;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
