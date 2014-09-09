//
//  MessageViewController.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "MessageViewController.h"
#import "Message.h"
#import "SailsDefaults.h"
#import "UIColor+Sails.h"
#import "SailsAPIs.h"
#import "SailsModels.h"

@interface MessageViewController ()

@property UITableView *tableview;
@property User *me;
@property NSMutableArray *messages;

@end

@implementation MessageViewController

@synthesize tableview, me, messages;

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
    
    tableview = [[UITableView alloc] initWithFrame:self.view.bounds
                                             style:UITableViewStyleGrouped];
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableview];
    
    me = [SailsDefaults getUser];
    messages = [NSMutableArray array];
}

// UIBarButtonItem
- (void)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self getMessages];
}

- (void)getMessages {
    if (self.simpleChat == nil)
        return;
    
    NSInteger chatID = self.simpleChat.id;
    [SailsAPIs messageOfChat:chatID
                     success:^(NSArray *chats) {
                         [tableview reloadData];
                     } failure:^(NSError *error) {
                     }];
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
            tableViewcCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:MyCellIdentifier];
            tableViewcCell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableViewcCell.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
            
            tableViewcCell.textLabel.textColor = [UIColor black:1];
            tableViewcCell.textLabel.font = [UIFont boldSystemFontOfSize:12];
        }
        
        tableViewcCell.textLabel.text = message.content;
    } else {
        tableViewcCell = [tableView dequeueReusableCellWithIdentifier:OtherCellIdentifier];
    }
    
    return tableViewcCell;
}

@end
