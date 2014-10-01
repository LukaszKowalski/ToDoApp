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

- (void)viewWillLayoutSubviews{
    if ([NSUserDefaults standardUserDefaults]) {
        [PFUser logInWithUsernameInBackground:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]
                                     password:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
                                        block:^(PFUser *user, NSError *error) {
                                            if (user) {
                                                
                                                self.toDo = [[ToDoViewController alloc] init];
                                                [self.navigationController pushViewController:self.toDo animated:YES];
                                                
                                                
                                            }
                                        }];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    


    self.view.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.getLogin = [[UITextField alloc] init];
    self.getPassword = [[UITextField alloc] init];
    self.doSign = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 200, 200)];

    self.signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 360, 150, 40)];
    [self.signUpButton setTitle:@"REGISTER" forState:UIControlStateNormal];
    [self.signUpButton setBackgroundColor:[UIColor clearColor]];
    [self.signUpButton addTarget:self action:@selector(createUserAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpButton setTitleColor:[UIColor colorWithRed:160/255.0f green:170/255.0f blue:213/255.0f alpha:1.0f] forState:UIControlStateNormal];

    self.signUpButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
    
    self.forgotPassword = [[UIButton alloc] initWithFrame:CGRectMake(90, 400, 150, 40)];
    [self.forgotPassword setTitle:@"FORGOT PASSWORD?" forState:UIControlStateNormal];
    [self.forgotPassword setBackgroundColor:[UIColor clearColor]];
    [self.forgotPassword addTarget:self action:@selector(createUserAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.forgotPassword setTitleColor:[UIColor colorWithRed:160/255.0f green:170/255.0f blue:213/255.0f alpha:1.0f] forState:UIControlStateNormal];
    self.forgotPassword.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];

    
    
    self.login = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, 260, 50)];
    [self.login setTitle:@"LOG IN" forState:UIControlStateNormal];
    [self.login setBackgroundColor:[UIColor colorWithRed:7/255.0f green:210/255.0f blue:126/255.0f alpha:1.0f]];

    [self.login addTarget:self action:@selector(loginFired:) forControlEvents:UIControlEventTouchUpInside];
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    
    // UITextFields
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.getLogin.leftView = paddingView;
    self.getLogin.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.getPassword.leftView = paddingViewOne;
    self.getPassword.leftViewMode = UITextFieldViewModeAlways;
    
    UIColor *color= [UIColor whiteColor];
    self.getLogin.frame = CGRectMake(120, 165, 300, 50);
    self.getLogin.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"username" attributes: @{NSForegroundColorAttributeName:color ,
                     NSFontAttributeName :[UIFont fontWithName: @"HelveticaNeue-Thin" size:20]
                     }];
    
    self.getLogin.textColor = [UIColor whiteColor];
    self.getPassword.frame  = CGRectMake(120, 220, 300, 50);
    self.getPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"password" attributes: @{NSForegroundColorAttributeName:color ,
                                                                                                                NSFontAttributeName :[UIFont fontWithName: @"HelveticaNeue-Thin" size:20]
                                                               
                                                                                                                  }];
    self.getPassword.textColor = [UIColor whiteColor];

    
    self.line1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 215, 260, 1)];
    self.line1.backgroundColor = [UIColor colorWithRed:29/255.0f green:34/255.0f blue:62/255.0f alpha:1.0f];

    self.line2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 275, 260, 1)];
    self.line2.backgroundColor = [UIColor colorWithRed:31/255.0f green:33/255.0f blue:86/255.0f alpha:1.0f];

    
    UIImageView *doImage=[ [UIImageView alloc] initWithImage:[UIImage imageNamed:@"DoLogo.png"]];
    [self.view addSubview:doImage];
    CGRect myFrame = doImage.frame;
    myFrame.origin.x = 110;
    myFrame.origin.y = 80;
    doImage.frame = myFrame;
    
    
    
//    self.doSign.text = @"Do";
//    self.doSign.textColor = [UIColor whiteColor];
//    self.doSign.font = [UIFont systemFontOfSize:90];
//    self.doSign.textAlignment = NSTextAlignmentCenter;
    
//    self.getLogin.layer.cornerRadius=8.0f;
//    self.getLogin.layer.masksToBounds=YES;
//    self.getLogin.layer.borderColor=[[UIColor whiteColor]CGColor];
//    self.getLogin.layer.borderWidth= 2.5f;
    [self.getLogin setBorderStyle:UITextBorderStyleNone];
    
//    self.getPassword.layer.cornerRadius=8.0f;
//    self.getPassword.layer.masksToBounds=YES;
//    self.getPassword.layer.borderColor=[[UIColor whiteColor]CGColor];
//    self.getPassword.layer.borderWidth= 2.5f;
    self.getPassword.secureTextEntry=YES;
    [self.getPassword setBorderStyle:UITextBorderStyleNone];
    
    [self.view addSubview:self.getLogin];
    [self.view addSubview:self.getPassword];
    [self.view addSubview:self.signUpButton];
    [self.view addSubview:self.login];
    [self.view addSubview:self.doSign];
    [self.view addSubview:self.forgotPassword];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    }

    // Auto-login

- (void)viewDidAppear:(BOOL)animated{
//        if ([NSUserDefaults standardUserDefaults]) {
//            [PFUser logInWithUsernameInBackground:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]
//                                         password:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
//                                            block:^(PFUser *user, NSError *error) {
//                if (user) {
//                    
//                    self.toDo = [[ToDoViewController alloc] init];
//                    [self.navigationController pushViewController:self.toDo animated:YES];
//
//
//                    }
//        }];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

// Przycisk konto

- (void)createUserAccount{
    
    self.signUp = [[SignUpViewController alloc] init];
    [self.navigationController pushViewController:self.signUp animated:YES];
}
- (void)loginFired:(id)sender{
    
    NSString *loginWithLowerCase = self.getLogin.text;
    NSString *passwordWithLowerCase = self.getPassword.text;
    
    [loginWithLowerCase lowercaseString];
    [passwordWithLowerCase lowercaseString];
    
        [PFUser logInWithUsernameInBackground:loginWithLowerCase password:passwordWithLowerCase block:^(PFUser *user, NSError *error) {
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
                [[ParseStore sharedInstance] registerUserForPushNotification];
                [[ParseStore sharedInstance] loadTasksForStart:self.toDoViewController];
                
            } else {
                //Something bad has ocurred
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorAlertView show];
            }
        }];
    }
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}



@end
