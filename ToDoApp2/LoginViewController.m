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
@property (strong, nonatomic) NSString* fbId;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationItem.hidesBackButton = YES;


    self.view.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.getLogin = [[UITextField alloc] init];
    self.getPassword = [[UITextField alloc] init];
    self.doSign = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, 200, 200)];

    self.signUpButton = [[UIButton alloc] initWithFrame:CGRectMake(90, 430, 150, 40)];
    [self.signUpButton setTitle:@"REGISTER" forState:UIControlStateNormal];
    [self.signUpButton setBackgroundColor:[UIColor clearColor]];
    [self.signUpButton addTarget:self action:@selector(createUserAccount) forControlEvents:UIControlEventTouchUpInside];
    [self.signUpButton setTitleColor:[UIColor colorWithRed:160/255.0f green:170/255.0f blue:213/255.0f alpha:1.0f] forState:UIControlStateNormal];

    self.signUpButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:12];
    
    self.forgotPassword = [[UIButton alloc] initWithFrame:CGRectMake(90, 470, 150, 40)];
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
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(30, 360, 260, 50)];
    [loginButton addTarget:self action:@selector(_loginWithFacebook) forControlEvents:UIControlEventTouchUpInside];
    [loginButton setImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
    [loginButton setImage:[UIImage imageNamed:@"facebook_off.png"] forState:UIControlStateSelected];
    [self.view addSubview:loginButton];
    

    
    
    
    // UITextFields

    self.getLogin.textAlignment = NSTextAlignmentCenter;
    self.getLogin.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.getLogin.autocorrectionType = UITextAutocorrectionTypeNo;
    self.getLogin.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;


    self.getPassword.textAlignment = NSTextAlignmentCenter;
    self.getPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
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

- (void)viewWillAppear:(BOOL)animated{
    
    
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"]) {
            [SVProgressHUD showWithStatus:@"Logging ..." maskType:SVProgressHUDMaskTypeGradient];

            [PFUser logInWithUsernameInBackground:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]
                                         password:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]
                                            block:^(PFUser *user, NSError *error) {
                if (user) {
                    
                    self.toDo = [[ToDoViewController alloc] init];
                    [self.navigationController pushViewController:self.toDo animated:YES];

                } else if ([PFUser currentUser]){
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
    
        [PFUser logInWithUsernameInBackground:loginWithLowerCase
                                     password:passwordWithLowerCase
                                        block:^(PFUser *user, NSError *error) {
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

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error{
    NSLog(@"sukces %@",[result token]);
    NSLog(@"sukces %@",[result grantedPermissions]);
    NSLog(@"error %@",error);
    
    if ([FBSDKAccessToken currentAccessToken]) {
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,first_name,email,last_name"
                                                                       parameters:nil];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                // result is a dictionary with the user's Facebook data
                NSString *firstName = result[@"first_name"];
                NSString *lastName = result[@"last_name"];
                NSString *email = result[@"email"];
                NSString *fbId = result[@"id"];
                self.fbId = fbId;
                
                
                [self createAccountwithFirstName:firstName withlastName:lastName withEmail:email];
            }
        }];
    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"logout");

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
    NSArray *permissionsArray = @[ @"user_about_me", @"user_friends", @"email"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
            NSLog(@"Facebook error: %@", error);
        } else if (user.isNew) {
            NSLog(@"User signed up and logged in through Facebook!");
            if ([FBSDKAccessToken currentAccessToken]) {
                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,first_name,email,last_name" parameters:nil];
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        // result is a dictionary with the user's Facebook data
                        NSString *firstName = result[@"first_name"];
                        NSString *lastName = result[@"last_name"];
                        NSString *email = result[@"email"];
                        NSString *fbId = result[@"id"];
                        self.fbId = fbId;

                        
                        [self createAccountwithFirstName:firstName withlastName:lastName withEmail:email];
                                }
                }];
            }

            
            
        } else {
            NSLog(@"User logged in through Facebook!");
            [self loginFired];
        }
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

    //Popup
    
    UIView *usernameAndEmailView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/32, self.view.frame.size.height/6, self.view.frame.size.width*30/32, self.view.frame.size.height*0.6)];
    usernameAndEmailView.backgroundColor = [UIColor whiteColor];
    [self.popupView addSubview:usernameAndEmailView];
    
    // Username
    
    UILabel *yourUsername = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, usernameAndEmailView.frame.size.width, usernameAndEmailView.frame.size.height*0.1)];
    yourUsername.text = @"Your username";
    yourUsername.textAlignment = NSTextAlignmentCenter;
    [usernameAndEmailView addSubview:yourUsername];
    
    UITextField *username = [[UITextField alloc] initWithFrame:CGRectMake(15, 100, usernameAndEmailView.frame.size.width*27/30, usernameAndEmailView.frame.size.height*0.1)];
    username.layer.borderColor = UIColor.blackColor.CGColor;
    username.layer.borderWidth = 1;
    username.layer.masksToBounds = true;
    [username setAdjustsFontSizeToFitWidth:YES];
    [usernameAndEmailView addSubview:username];
    username.tag = 1;
    username.text = [[NSString stringWithFormat:@"%@_%@", firstName, lastName] lowercaseString];
    self.username = username.text;
    
    // userEmail
    
    UILabel *yourEmail = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, usernameAndEmailView.frame.size.width, usernameAndEmailView.frame.size.height*0.1)];
    yourEmail.text = @"Your Email";
    yourEmail.textAlignment = NSTextAlignmentCenter;
    [usernameAndEmailView addSubview:yourEmail];
    
    UITextField *userEmail = [[UITextField alloc] initWithFrame:CGRectMake(15, 190, usernameAndEmailView.frame.size.width*27/30, usernameAndEmailView.frame.size.height*0.1)];
    userEmail.layer.borderColor = UIColor.blackColor.CGColor;
    userEmail.layer.borderWidth = 1;
    userEmail.tag = 2;
    userEmail.layer.masksToBounds = true;
    [usernameAndEmailView addSubview:userEmail];
    [userEmail setAdjustsFontSizeToFitWidth:YES];
    userEmail.text = email;
    self.email = userEmail.text;
    
    // CreateYourAccount
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    NSMutableDictionary *textProperties = [NSMutableDictionary dictionary];
    textProperties[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue-Thin" size:25];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:NSLocalizedString( @"Create Your  Account", nil)
                                                                           attributes:textProperties];
    textLayer.string = attributedString;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.frame = usernameAndEmailView.bounds;
    
    UIImage *rainbowImage = [UIImage imageNamed:@"Rainbow"];
    self.imageView = [[UIImageView alloc] initWithImage:rainbowImage];
    self.imageView.layer.mask = textLayer;
    self.imageView.frame = CGRectMake(0, 20, usernameAndEmailView.frame.size.width, 50);
    [usernameAndEmailView addSubview: self.imageView];
    
    //Done
    
    UIButton *done = [[UIButton alloc] initWithFrame:CGRectMake(usernameAndEmailView.frame.size.width/30, usernameAndEmailView.frame.size.height*0.8, usernameAndEmailView.frame.size.width*28/30, usernameAndEmailView.frame.size.height*0.15)];
    [usernameAndEmailView addSubview:done];
    [done addTarget:self action:@selector(saveUserWithUsername:andWithEmail:) forControlEvents:UIControlEventTouchUpInside];
    [done setTitle:@"DONE" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    done.backgroundColor = [UIColor colorWithRed:7/255.0f green:210/255.0f blue:126/255.0f alpha:1.0f];
    
    
    [self.view addSubview:self.popupView];

}

-(void)saveUserWithUsername:(NSString*)username andWithEmail:(NSString*)email{
    [[PFUser currentUser] setUsername:[NSString stringWithFormat:@"%@", self.username]];
    [[PFUser currentUser] setEmail:[NSString stringWithFormat:@"%@", self.email]];
    [[PFUser currentUser] setPassword:[NSString stringWithFormat:@"%@", [self randomStringWithLength:6]]];
    [[PFUser currentUser] setObject:self.fbId forKey:@"fbId"];
    
    NSLog(@"username %@", self.username);
    
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
                    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                                    initWithGraphPath:@"/me/friends"
                                                    parameters:nil
                                                    HTTPMethod:@"GET"];
                    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                            id result,
                                                            NSError *error) {
                        NSLog(@"rezultaty = %@", result);
                        NSDictionary *data = [(NSDictionary *)result objectForKey:@"data"];
                        if (result != NULL){
                            for (NSDictionary* fbFriend in data) {
                                NSString *facebookID = [fbFriend objectForKey:@"id"];
                                // do stuff
                                NSLog(@"trying to add friend %@", facebookID);
                                [[ParseStore sharedInstance] addFriendFromFB:facebookID];
                            }
            
                        }
                           NSLog(@"error = %@", error);
                    }];
                    [[ParseStore sharedInstance] loadFriends];
            
        } else {
            // There was a problem, check error.description
        }
    }];
    
       
    [[ParseStore sharedInstance] addTaskDoTeam:@"Swipe right to delete task" forNumber:1];
    [[ParseStore sharedInstance] addTaskDoTeam:@"Swipe left, find who gave you \"do\"" forNumber:2];
    [[ParseStore sharedInstance] addTaskDoTeam:@"Hi, welcome in \"Do\" ;)" forNumber:0];
    
    [self.popupView removeFromSuperview];
    [self loginFired];
}

- (void)_logOut  {
    NSLog(@"logout");
    [PFUser logOut]; // Log out
}

-(NSString *) randomStringWithLength: (int) len {
    
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"textfield %ld", (long)textField.tag);
    if (textField.tag == 1 ) {
        self.username = textField.text;
    }
    
    if (textField.tag == 2 ) {
        self.email = textField.text;
    }

    return YES;
}


@end
