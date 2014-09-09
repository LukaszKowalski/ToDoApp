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
#import "SignUpViewController.h"
#import "ToDoViewController.h"

@interface LoginViewController : UIViewController

@property (strong, nonatomic) UITextField *getLogin;
@property (strong, nonatomic) UITextField *getPassword;
@property (strong, nonatomic) UIButton *login;
@property (strong, nonatomic) UIButton *signUpButton;




@end
