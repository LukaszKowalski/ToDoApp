//
//  SignUpViewController.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 9/9/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "LoginViewController.h"

@interface SignUpViewController : UIViewController

@property (strong, nonatomic) UITextField *getLogin;
@property (strong, nonatomic) UITextField *getPassword;
@property (strong, nonatomic) UIButton *createAccount;



@end
