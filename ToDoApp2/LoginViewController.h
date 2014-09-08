//
//  LoginViewController.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 9/8/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) UITextField *getLogin;
@property (strong, nonatomic) UITextField *getPassword;
@property (strong, nonatomic) UIButton *login;
@property (strong, nonatomic) UIButton *createAccount;
@property (strong, nonatomic) UILabel *loginText;
@property (strong, nonatomic) UILabel *passwordText; 



@end
