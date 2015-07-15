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
@property (strong, nonatomic) UITextField *getEmail;
@property (strong, nonatomic) UIButton *createAccount;
@property (strong, nonatomic) UILabel *signUpLabel;
@property (strong, nonatomic) UILabel *line1;
@property (strong, nonatomic) UILabel *line2;
@property (strong, nonatomic) UILabel *line3;
@property (strong, nonatomic) UIImageView *imageView;
-(void)createAccount:(id)sender;

@end
