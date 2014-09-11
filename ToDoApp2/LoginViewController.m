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

    self.signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 310, 150, 40)];
    [self.signUpButton setTitle:@"Create Account" forState:UIControlStateNormal];
    [self.signUpButton setBackgroundColor:[UIColor grayColor]];
    [self.signUpButton addTarget:self action:@selector(createUserAccount) forControlEvents:UIControlEventTouchUpInside];
    
    self.login = [[UIButton alloc] initWithFrame:CGRectMake(120, 260, 100, 40)];
    
    [self.login setTitle:@"Login" forState:UIControlStateNormal];
    [self.login setBackgroundColor:[UIColor grayColor]];
    [self.login addTarget:self action:@selector(loginFired:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.getLogin.frame = CGRectMake(70, 145, 200, 50);
    self.getLogin.placeholder = @"  Login";
    self.getPassword.frame  = CGRectMake(70, 200, 200, 50);
    self.getPassword.placeholder = @"  Password";
    

    
    self.getLogin.layer.cornerRadius=8.0f;
    self.getLogin.layer.masksToBounds=YES;
    self.getLogin.layer.borderColor=[[UIColor grayColor]CGColor];
    self.getLogin.layer.borderWidth= 1.0f;
    
    self.getPassword.layer.cornerRadius=8.0f;
    self.getPassword.layer.masksToBounds=YES;
    self.getPassword.layer.borderColor=[[UIColor grayColor]CGColor];
    self.getPassword.layer.borderWidth= 1.0f;
    self.getPassword.secureTextEntry=YES;

    
    
    [self.view addSubview:self.getLogin];
    [self.view addSubview:self.getPassword];

    [self.view addSubview:self.signUpButton];
    [self.view addSubview:self.login];
    
    }
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
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
}

@end
