//
//  LoginViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 9/8/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (strong, nonatomic) SignUpViewController *signUpController;
@property (strong, nonatomic) UIView* popupView;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* email;


@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationItem.hidesBackButton = YES;


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
    [self.forgotPassword addTarget:self action:@selector(forgotPasswordProblem) forControlEvents:UIControlEventTouchUpInside];
    [self.forgotPassword setTitleColor:[UIColor colorWithRed:160/255.0f green:170/255.0f blue:213/255.0f alpha:1.0f] forState:UIControlStateNormal];
    self.forgotPassword.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];

    
    
    self.login = [[UIButton alloc] initWithFrame:CGRectMake(30, 300, 260, 50)];
    [self.login setTitle:@"LOG IN" forState:UIControlStateNormal];
    [self.login setBackgroundColor:[UIColor colorWithRed:7/255.0f green:210/255.0f blue:126/255.0f alpha:1.0f]];

    [self.login addTarget:self action:@selector(loginFired) forControlEvents:UIControlEventTouchUpInside];
    [self.login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] initWithFrame:CGRectMake(30, 400, 260, 50)];
    [loginButton addTarget:self action:@selector(_loginWithFacebook) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    
    
    
    
    // UITextFields
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.getLogin.leftView = paddingView;
    self.getLogin.leftViewMode = UITextFieldViewModeAlways;
    self.getLogin.textAlignment = NSTextAlignmentCenter;

    
    self.getLogin.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.getLogin.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UIView *paddingViewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.getPassword.leftView = paddingViewOne;
    self.getPassword.leftViewMode = UITextFieldViewModeAlways;
    self.getPassword.textAlignment = NSTextAlignmentCenter;
    
    
    self.getPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.getPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    
    UIColor *color= [UIColor whiteColor];
    self.getLogin.frame = CGRectMake(0, 175, 320, 50);
    self.getLogin.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"username" attributes: @{NSForegroundColorAttributeName:color ,
                     NSFontAttributeName :[UIFont fontWithName: @"HelveticaNeue-Thin" size:20]
                     }];
    
    self.getLogin.textColor = [UIColor whiteColor];
    self.getPassword.frame  = CGRectMake(0, 235, 320, 50);
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
    

    [self.getLogin setBorderStyle:UITextBorderStyleNone];
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
    
    
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"]) {
            [SVProgressHUD showWithStatus:@"Logging ..." maskType:SVProgressHUDMaskTypeGradient];

            [PFUser logInWithUsernameInBackground:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]
                                         password:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
                                            block:^(PFUser *user, NSError *error) {
                if (user) {
                    
                    self.toDo = [[ToDoViewController alloc] init];
                    [self.navigationController pushViewController:self.toDo animated:YES];

                } else if([PFUser currentUser]){
                    self.toDo = [[ToDoViewController alloc] init];
                    [self.navigationController pushViewController:self.toDo animated:YES];
                }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

// Create Account button

- (void)createUserAccount{
    
    self.signUpController = [[SignUpViewController alloc] init];
    [self.navigationController pushViewController:self.signUpController animated:YES];
}

// Log in to the app

- (void)loginFired{
    NSLog(@"loginFired");
    [SVProgressHUD showWithStatus:@"Logging ..." maskType:SVProgressHUDMaskTypeGradient];

    NSString *loginWithLowerCase = self.getLogin.text;
    NSString *passwordWithLowerCase = self.getPassword.text;
    
    [loginWithLowerCase lowercaseString];
    [passwordWithLowerCase lowercaseString];
    
        [PFUser logInWithUsernameInBackground:loginWithLowerCase password:passwordWithLowerCase block:^(PFUser *user, NSError *error) {
            if (user || [PFUser currentUser]) {
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
                
                dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
                dispatch_async(myQueue, ^{
                    
                    [[ParseStore sharedInstance] loadTasks];
                    [[ParseStore sharedInstance] loadFriends];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                                                
                    });
                });
                
            } else {
                
                //Something bad has ocurred
                NSString *errorString = [[error userInfo] objectForKey:@"error"];
                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [errorAlertView show];
                [SVProgressHUD dismiss];
            }
        }];
    }
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)_loginWithFacebook {
    NSLog(@"fb");
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location", @"email"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            if ([FBSDKAccessToken currentAccessToken]) {
                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,first_name,email,last_name" parameters:nil];
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // result is a dictionary with the user's Facebook data
                        
                        NSString *facebookID = result[@"id"];
                        NSString *firstName = result[@"first_name"];
                        NSString *lastName = result[@"last_name"];
                        NSString *email = result[@"email"];
                        
                        NSLog(@"%@", result);
                        [self createAccountwithFirstName:firstName withlastName:lastName withEmail:email];
                    } else if ([PFUser currentUser]) {
                            NSLog(@"User logged in through Facebook!");
                            [self loginFired];
                    } else {
                        NSLog(@"%@", error);
                    }
                }];
            }}
    }];
}

// ForgotPassword Button

- (void)forgotPasswordProblem{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Forgot Password?"
                                                    message:@"We will send you a new one"
                                                   delegate:self
                                          cancelButtonTitle:@"Done"
                                          otherButtonTitles:nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alert textFieldAtIndex:0];
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.placeholder = @"Enter your email";
    
    [alert show];
    

    [PFUser requestPasswordResetForEmailInBackground:[NSString stringWithFormat:@"%@", textField.text]
];
}

-(void)createAccountwithFirstName:(NSString*)firstName withlastName:(NSString*)lastName withEmail:(NSString *)email{
    
    NSLog(@"%@, %@, %@", firstName, lastName, email);
    
    self.popupView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    
    UIView *alpha = [[UIView alloc] initWithFrame:self.popupView.frame];
    alpha.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.4];
    [self.popupView addSubview:alpha];

    UIView *usernameAndEmailView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/10, self.view.frame.size.height/6, self.view.frame.size.width*0.8, self.view.frame.size.height*0.6)];
    usernameAndEmailView.backgroundColor = [UIColor whiteColor];
    [self.popupView addSubview:usernameAndEmailView];
    
    UITextField *username = [[UITextField alloc] initWithFrame:CGRectMake(usernameAndEmailView.frame.size.width/10, usernameAndEmailView.frame.size.height/8, usernameAndEmailView.frame.size.width*0.9, usernameAndEmailView.frame.size.height*0.1)];
    [username setAdjustsFontSizeToFitWidth:YES];
    [usernameAndEmailView addSubview:username];
    username.text = [NSString stringWithFormat:@"%@_%@", firstName, lastName];
    self.username = username.text;
    
    UITextField *userEmail = [[UITextField alloc] initWithFrame:CGRectMake(usernameAndEmailView.frame.size.width/10, usernameAndEmailView.frame.size.height/4, usernameAndEmailView.frame.size.width*0.9, usernameAndEmailView.frame.size.height*0.1)];
    [usernameAndEmailView addSubview:userEmail];
    [userEmail setAdjustsFontSizeToFitWidth:YES];
    userEmail.text = email;
    self.email = userEmail.text;
    
    UIButton *done = [[UIButton alloc] initWithFrame:CGRectMake(usernameAndEmailView.frame.size.width/10, usernameAndEmailView.frame.size.height/2, usernameAndEmailView.frame.size.width*0.8, usernameAndEmailView.frame.size.height*0.1)];
    [usernameAndEmailView addSubview:done];
    [done addTarget:self action:@selector(saveUserWithUsername:andWithEmail:) forControlEvents:UIControlEventTouchUpInside];
    [done setTitle:@"DONE" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    done.backgroundColor = [UIColor colorWithRed:7/255.0f green:210/255.0f blue:126/255.0f alpha:1.0f];
    
    
    [self.view addSubview:self.popupView];
//    //1
//    dispatch_async(dispatch_get_main_queue(),^{
//        [SVProgressHUD showWithStatus:@"Adding Account"];
//        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];
//        
//        
//        PFUser *user = [PFUser user];
//        //2
//        user.username = self.getLogin.text;
//        
//        user.password = self.getPassword.text;
//        
////        user.email = self.getEmail.text;
//        //3
//        
//        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//            if (!error) {
//                //The registration was successful, go to the wall
//                
//                self.login = [[LoginViewController alloc] init];
//                [self.navigationController pushViewController:self.login animated:YES];
//                [[ParseStore sharedInstance] addTaskDoTeam:@"Swipe right to delete task" forNumber:1];
//                [[ParseStore sharedInstance] addTaskDoTeam:@"Swipe left, find who gave you \"do\"" forNumber:2];
//                [[ParseStore sharedInstance] addTaskDoTeam:@"Hi, welcome in \"Do\" ;)" forNumber:0];
//                
//                [SVProgressHUD dismiss];
//                
//            } else {
//                
//                //Something bad has occurred
//                NSString *errorString = [[error userInfo] objectForKey:@"error"];
//                UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                [errorAlertView show];
//                [SVProgressHUD dismiss];
//            }
//        }];
//    });
//
}
-(void)saveUserWithUsername:(NSString*)username andWithEmail:(NSString*)email{
    [[PFUser currentUser] setUsername:[NSString stringWithFormat:@"%@", self.username]];
    [[PFUser currentUser] setEmail:[NSString stringWithFormat:@"%@", self.email]];
    
    [[PFUser currentUser] saveEventually];
    [self.popupView removeFromSuperview];
    [self loginFired];
}
- (void)_logOut  {
    [PFUser logOut]; // Log out
}

@end
