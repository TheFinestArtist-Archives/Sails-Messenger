//
//  ChatViewController.m
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import "ChatViewController.h"
#import "UIColor+Sails.h"

@interface ChatViewController ()

@property UITableView *tableView;
@property UIScreen *mainScreen;

@end

@implementation ChatViewController

@synthesize tableView, mainScreen;

- (void)viewDidLoad
{
    
    self.tabBarItem.title = @"Chat";
    self.tabBarController.tabBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    UILabel *titlelabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titlelabel.backgroundColor = [UIColor clearColor];
    titlelabel.font = [UIFont boldSystemFontOfSize:16.0];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.textColor = [UIColor whiteColor];
    titlelabel.text = @"Chat";
    [titlelabel sizeToFit];
    self.tabBarController.navigationItem.titleView = titlelabel;
}

// UITableViewDataSource & UITableViewDataSource

@end
