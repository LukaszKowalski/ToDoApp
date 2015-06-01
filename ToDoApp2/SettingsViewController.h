//
//  SettingsViewController.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 10/1/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"
#import "ParseStore.h"
#import <MessageUI/MessageUI.h>


@interface SettingsViewController : UIViewController <MFMessageComposeViewControllerDelegate>

@property (nonatomic, strong) UIButton *sendSms;
@property (nonatomic, strong) UIButton *logout;
@property (strong, nonatomic) UILabel *line1;
@property (strong, nonatomic) UILabel *line2;
@property (strong, nonatomic) UILabel *invite;
@property (strong, nonatomic) UILabel *changePassword;
@property (strong, nonatomic) UILabel *logoutLabel;
@property (nonatomic, strong) UIImageView *imageView;


@end
