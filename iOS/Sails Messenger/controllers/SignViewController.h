//
//  SignViewController.h
//  Sails Messenger
//
//  Created by TheFinestArtist on 2014. 9. 7..
//  Copyright (c) 2014년 TheFinestArtist. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SignType) {
    SIGN_UP,
    LOG_IN,
};

@interface SignViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
    @property(nonatomic) SignType signType;
@end
