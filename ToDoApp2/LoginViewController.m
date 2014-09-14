//
//  LoginViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 9/8/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (nonatomic, strong) ToDoViewController *toDo;
@property (nonatomic, strong) SignUpViewController *signUp;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.getLogin = [[UITextField alloc] init];
    self.getPassword = [[UITextField alloc] init];
    self.doSign = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 200, 200)];

    self.signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 380, 150, 40)];
    [self.signUpButton setTitle:@"Create Account" forState:UIControlStateNormal];
    [self.signUpButton setBackgroundColor:[UIColor whiteColor]];
    [self.signUpButton addTarget:self action:@selector(createUserAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.signUpButton setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    
    
    self.login = [[UIButton alloc] initWithFrame:CGRectMake(90, 330, 150, 40)];
    [self.login setTitle:@"Login" forState:UIControlStateNormal];
    [self.login setBackgroundColor:[UIColor whiteColor]];
    [self.login addTarget:self action:@selector(loginFired:) forControlEvents:UIControlEventTouchUpInside];
    [self.login setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.login setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    
    
    // UITextFields
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.getLogin.leftView = paddingView;
    self.getLogin.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.getPassword.leftView = paddingViewOne;
    self.getPassword.leftViewMode = UITextFieldViewModeAlways;
    
    UIColor *color= [UIColor whiteColor];
    self.getLogin.frame = CGRectMake(70, 195, 200, 50);
    self.getLogin.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Login" attributes:@{NSForegroundColorAttributeName: color}];
    self.getLogin.textColor = [UIColor whiteColor];
    self.getPassword.frame  = CGRectMake(70, 250, 200, 50);
    self.getPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: color}];
    self.getPassword.textColor = [UIColor whiteColor];
    
    self.doSign.text = @"Do";
    self.doSign.textColor = [UIColor whiteColor];
    self.doSign.font = [UIFont systemFontOfSize:90];
    self.doSign.textAlignment = NSTextAlignmentCenter;
    
    self.getLogin.layer.cornerRadius=8.0f;
    self.getLogin.layer.masksToBounds=YES;
    self.getLogin.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.getLogin.layer.borderWidth= 2.5f;
    
    self.getPassword.layer.cornerRadius=8.0f;
    self.getPassword.layer.masksToBounds=YES;
    self.getPassword.layer.borderColor=[[UIColor whiteColor]CGColor];
    self.getPassword.layer.borderWidth= 2.5f;
    self.getPassword.secureTextEntry=YES;

    
    [self.view addSubview:self.getLogin];
    [self.view addSubview:self.getPassword];
    [self.view addSubview:self.signUpButton];
    [self.view addSubview:self.login];
    [self.view addSubview:self.doSign];
    
    }

    // Auto-login

- (void)viewDidAppear:(BOOL)animated{
        if ([NSUserDefaults standardUserDefaults]) {
            [PFUser logInWithUsernameInBackground:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]
                                         password:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
                                            block:^(PFUser *user, NSError *error) {
                if (user) {
                    
                    self.toDo = [[ToDoViewController alloc] init];
                    [self.navigationController pushViewController:self.toDo animated:YES];
                }}];
        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)createUserAccount{
    
    self.signUp = [[SignUpViewController alloc] init];
    [self.navigationController pushViewController:self.signUp animated:YES];
}
- (void)loginFired:(id)sender{
    [PFUser logInWithUsernameInBackground:self.getLogin.text password:self.getPassword.text block:^(PFUser *user, NSError *error) {
        if (user) {
            //Open the wall
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", self.getLogin.text] forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", self.getPassword.text] forKey:@"password"];
             self.toDo = [[ToDoViewController alloc] init];
             [self.navigationController pushViewController:self.toDo animated:YES];
            self.getLogin.text = nil;
            self.getPassword.text = nil;
            [self.getLogin resignFirstResponder];
            [self.getPassword resignFirstResponder];
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

@end
