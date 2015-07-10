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
#import "ToDoViewController.h"
#import "ParseStore.h"
#import "SignUpViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) UITextField *getLogin;
@property (strong, nonatomic) UITextField *getPassword;
@property (strong, nonatomic) UIButton *login;
@property (strong, nonatomic) UIButton *signUpButton;
@property (strong, nonatomic) UILabel *doSign;
@property (strong, nonatomic) UIButton *forgotPassword;
@property (strong, nonatomic) UILabel *line1;
@property (strong, nonatomic) UILabel *line2;
@property (strong, nonatomic) UIActivityIndicatorView *loginIndicator;
@property (strong, nonatomic) ToDoViewController *toDoViewController;
@property (nonatomic, strong) ToDoViewController *toDo;
-(void)createAccountwithFirstName:(NSString*)firstName withlastName:(NSString*)lastName withEmail:(NSString *)email;


@end
