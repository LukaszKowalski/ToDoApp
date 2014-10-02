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

@end
