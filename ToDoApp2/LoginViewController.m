//
//  LoginViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 9/8/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    
    self.getLogin = [[UITextField alloc] init];
    self.getPassword = [[UITextField alloc] init];
    self.loginText = [[UILabel alloc] init];
    self.passwordText = [[UILabel alloc] init];
    self.createAccount = [[UIButton alloc] initWithFrame:CGRectMake(90, 330, 150, 40)];
    [self.createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
    [self.createAccount setBackgroundColor:[UIColor grayColor]];
    
    self.login = [[UIButton alloc] initWithFrame:CGRectMake(120, 280, 100, 40)];
    
    [self.login setTitle:@"Login" forState:UIControlStateNormal];
    [self.login setBackgroundColor:[UIColor grayColor]];
    
    
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

    
    
    [self.view addSubview:self.getLogin];
    [self.view addSubview:self.getPassword];
    [self.view addSubview:self.loginText];
    [self.view addSubview:self.passwordText];
    [self.view addSubview:self.createAccount];
    [self.view addSubview:self.login];
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
