//
//  MessageViewController.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "MessageViewController.h"
#import "SailsDefaults.h"
#import "UIColor+Sails.h"
#import "SailsAPIs.h"
#import "SailsModels.h"

@interface MessageViewController ()

@property User *me;
@property NSArray *messages;

@end

@implementation MessageViewController

@synthesize me, messages;

static NSString *MyCellIdentifier = @"MyMessageCell";
static NSString *OtherCellIdentifier = @"OtherMessageCell";

- (void)viewDidLoad
{
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont boldSystemFontOfSize:16.0];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.text = @"Chat";
    [titlelabel sizeToFit];
    self.navigationItem.titleView = titlelabel;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = back;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    super.tableView.backgroundColor = [UIColor whiteColor];
    super.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    super.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    me = [SailsDefaults getUser];
    [self reloadTableView];
}

// UIBarButtonItem
- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self getMessages];
}

- (void)getMessages {
    if (self.chat == nil)
        return;
    
    NSInteger chatID = self.chat.id;
    [SailsAPIs messageOfChat:chatID
                     success:^(NSArray *chats) {
                         [self reloadTableView];
                     } failure:^(NSError *error) {
                     }];
}

- (void)reloadTableView {
    if (self.chat != nil)
        messages = [SailsModels messagesOfChat:self.chat.id];
    else
        messages = [NSArray array];

    [super.tableView reloadData];
}

// UITableViewDataSource & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Message *message = [messages objectAtIndex:indexPath.row];
    
    UITableViewCell *tableViewcCell;
    if (message.author != nil && message.author.id == me.id) {
        tableViewcCell = [tableView dequeueReusableCellWithIdentifier:MyCellIdentifier];
        
        if (tableViewcCell == nil) {
            tableViewcCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:MyCellIdentifier];
            tableViewcCell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableViewcCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
        }
        
        tableViewcCell.textLabel.text = message.content;
    } else {
        tableViewcCell = [tableView dequeueReusableCellWithIdentifier:OtherCellIdentifier];
        
        if (tableViewcCell == nil) {
            tableViewcCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:OtherCellIdentifier];
            tableViewcCell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableViewcCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
        }
        
        if (message.author != nil && message.author.username != nil)
            tableViewcCell.textLabel.text = message.author.username;
        else
            tableViewcCell.textLabel.text = @"deleted user";
        
        tableViewcCell.detailTextLabel.text = message.content;
    }
    
    return tableViewcCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *message = [messages objectAtIndex:indexPath.row];
    if (message.author != nil && message.author.id == me.id) {
        cell.textLabel.textColor = [UIColor black:1];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.backgroundColor = [UIColor emerald:0.7];
        cell.textLabel.layer.cornerRadius = 4;
        cell.textLabel.clipsToBounds = YES;
        [cell.textLabel sizeToFit];
    } else {
        cell.textLabel.textColor = [UIColor turquoise:1];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        
        cell.detailTextLabel.textColor = [UIColor black:1];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.backgroundColor = [UIColor grey:1];
        cell.detailTextLabel.layer.cornerRadius = 4;
        cell.detailTextLabel.clipsToBounds = YES;
        [cell.detailTextLabel sizeToFit];
    }
}

@end
