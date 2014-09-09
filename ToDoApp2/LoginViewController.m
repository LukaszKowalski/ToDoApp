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
    
    
    self.getLogin = [[UITextField alloc] init];
    self.getPassword = [[UITextField alloc] init];
    self.loginText = [[UILabel alloc] init];
    self.passwordText = [[UILabel alloc] init];
    self.signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 330, 150, 40)];
    [self.signUpButton setTitle:@"Create Account" forState:UIControlStateNormal];
    [self.signUpButton setBackgroundColor:[UIColor grayColor]];
    [self.signUpButton addTarget:self action:@selector(createUserAccount) forControlEvents:UIControlEventTouchUpInside];
    
    self.login = [[UIButton alloc] initWithFrame:CGRectMake(120, 280, 100, 40)];
    
    [self.login setTitle:@"Login" forState:UIControlStateNormal];
    [self.login setBackgroundColor:[UIColor grayColor]];
    [self.login addTarget:self action:@selector(loginFired:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.getLogin.frame = CGRectMake(100, 150, 200, 50);
    self.getPassword.frame  = CGRectMake(100, 200, 200, 50);
    self.loginText.frame = CGRectMake(0, 150, 100, 50);
    self.passwordText.frame = CGRectMake(0, 200, 100, 50);

    self.loginText.text = @"Login";
    self.passwordText.text = @"Password";
    
    self.getLogin.layer.cornerRadius=8.0f;
    self.getLogin.layer.masksToBounds=YES;
    self.getLogin.layer.borderColor=[[UIColor redColor]CGColor];
    self.getLogin.layer.borderWidth= 1.0f;
    
    self.getPassword.layer.cornerRadius=8.0f;
    self.getPassword.layer.masksToBounds=YES;
    self.getPassword.layer.borderColor=[[UIColor redColor]CGColor];
    self.getPassword.layer.borderWidth= 1.0f;
    self.getPassword.secureTextEntry=YES;

    
    
    [self.view addSubview:self.getLogin];
    [self.view addSubview:self.getPassword];
    [self.view addSubview:self.loginText];
    [self.view addSubview:self.passwordText];
    [self.view addSubview:self.signUpButton];
    [self.view addSubview:self.login];
    
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
             self.toDo = [[ToDoViewController alloc] init];
             [self.navigationController pushViewController:self.toDo animated:YES];
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

@end
