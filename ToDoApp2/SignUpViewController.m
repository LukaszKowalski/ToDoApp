//
//  SignUpViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 9/9/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "SignUpViewController.h"


@interface SignUpViewController ()

@property (strong, nonatomic) LoginViewController *login;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.signUpLabel = [[UILabel alloc] init];
    self.getLogin = [[UITextField alloc] init];
    self.getPassword = [[UITextField alloc] init];
    self.getEmail = [[UITextField alloc] init];
    
    self.createAccount = [[UIButton alloc] initWithFrame:CGRectMake(90, 330, 150, 40)];
    [self.createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
    [self.createAccount setBackgroundColor:[UIColor grayColor]];
    [self.createAccount addTarget:self action:@selector(createAccount:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.getLogin.frame = CGRectMake(70, 150, 200, 50);
    self.getPassword.frame  = CGRectMake(70, 205, 200, 50);
    self.getEmail.frame = CGRectMake(70, 260, 200, 50);
    
    // Login TextField
    
    self.getLogin.layer.cornerRadius=8.0f;
    self.getLogin.layer.masksToBounds=YES;
    self.getLogin.layer.borderColor=[[UIColor grayColor]CGColor];
    self.getLogin.layer.borderWidth= 1.0f;
    self.getLogin.placeholder = @"  Enter your Username";
    
    // Password TextField
    
    self.getPassword.layer.cornerRadius=8.0f;
    self.getPassword.layer.masksToBounds=YES;
    self.getPassword.layer.borderColor=[[UIColor grayColor]CGColor];
    self.getPassword.layer.borderWidth= 1.0f;
    self.getPassword.secureTextEntry = YES;
    self.getPassword.placeholder = @"  Enter your Password";
    self.getEmail.placeholder = @"  Enter your E-mail";
    
    // Email TextField
    
    self.getEmail.layer.cornerRadius=8.0f;
    self.getEmail.layer.masksToBounds=YES;
    self.getEmail.layer.borderColor=[[UIColor grayColor]CGColor];
    self.getEmail.layer.borderWidth= 1.0f;
    
    // Label
    
    self.signUpLabel.text = @"Create Your Account";
    self.signUpLabel.frame = CGRectMake(70, 100, 200, 50);
    
    [self.view addSubview:self.getLogin];
    [self.view addSubview:self.getPassword];
    [self.view addSubview:self.createAccount];
    [self.view addSubview:self.getEmail];
    [self.view addSubview:self.signUpLabel];



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createAccount:(id)sender{
    
    //1
    PFUser *user = [PFUser user];
    //2
    user.username = self.getLogin.text;
    user.password = self.getPassword.text;
    user.email = self.getEmail.text;
    //3
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was successful, go to the wall
            
            self.login = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:self.login animated:YES];
            
        } else {
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
}

@end
