//
//  ChatViewController.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "ChatViewController.h"
#import "UIColor+Sails.h"
#import "SailsModels.h"
#import "SailsDefaults.h"
#import "SailsAPIs.h"
#import "MessageViewController.h"

@interface ChatViewController ()

@property UITableView *tableview;
@property User *me;
@property NSMutableArray *myChats;
@property NSMutableArray *others;

@end

@implementation ChatViewController

@synthesize me, myChats, others;

static NSString *CellIdentifier = @"ChatCell";

- (void)viewDidLoad
{
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    super.tableView.backgroundColor = [UIColor whiteColor];
    super.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    me = [SailsDefaults getUser];
    [self reloadTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont boldSystemFontOfSize:16.0];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.text = @"Room";
    [titlelabel sizeToFit];
    self.tabBarController.navigationItem.titleView = titlelabel;
    
    [SailsAPIs chatListInSuccess:^(NSArray *chats) {
        [self reloadTableView];
    } failure:^(NSError *error) {
    }];
}

- (void)reloadTableView {
    myChats = [NSMutableArray array];
    others = [NSMutableArray array];
    for (SimpleChat *chat in [SailsModels allChats]) {
        BOOL isIncluded = NO;
        for (Chat *myChat in me.chats)
            if (myChat.id == chat.id)
                isIncluded = YES;
        
        if (isIncluded)
            [myChats addObject:chat];
        else
            [others addObject:chat];
    }
    [super.tableView reloadData];
}

// UITableViewDataSource & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (myChats.count == 0 && others.count == 0)
        return 0;
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            if (myChats.count == 0)
                return @"Start a chat!";
            else if (myChats.count == 1)
                return @"My Chat";
            else
                return @"My Chats";
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
            return myChats.count;
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
        
        UIView *underline = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        underline.backgroundColor = [UIColor grey:1];
        [tableViewcCell addSubview:underline];
    }
    
    SimpleChat *chat;
    switch (indexPath.section) {
        case 0:
            chat = [myChats objectAtIndex:indexPath.row];
            break;
        case 1:
            chat = [others objectAtIndex:indexPath.row];
            break;
    }
    
    NSString *chatterList = @"";
    for (int i = 0; i < chat.chatters.count; i++) {
        User *user = [chat.chatters objectAtIndex:i];
        if (![me.username isEqualToString:user.username]) {
            if (i == chat.chatters.count - 1)
                chatterList = [chatterList stringByAppendingString:user.username];
            else
                chatterList = [chatterList stringByAppendingString:[NSString stringWithFormat:@"%@, ", user.username]];
        }
    }
    
    if (chatterList.length == 0)
        chatterList = @"no chatter..";
    tableViewcCell.textLabel.text = chatterList;
    
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
    
    Chat *chat;
    switch (indexPath.section) {
        case 0:
            chat = [myChats objectAtIndex:indexPath.row];
            break;
        case 1:
            chat = [others objectAtIndex:indexPath.row];
            break;
    }
    
    MessageViewController *viewController = [[MessageViewController alloc] init];
    viewController.chat = chat;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
