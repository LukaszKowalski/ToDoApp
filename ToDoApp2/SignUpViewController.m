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

    
    self.view.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.signUpLabel = [[UILabel alloc] init];
    self.getLogin = [[UITextField alloc] init];
    self.getPassword = [[UITextField alloc] init];
    self.getEmail = [[UITextField alloc] init];
    
    self.createAccount = [[UIButton alloc] initWithFrame:CGRectMake(90, 330, 150, 40)];
    [self.createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
    [self.createAccount setBackgroundColor:[UIColor whiteColor]];
    [self.createAccount addTarget:self action:@selector(createAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.createAccount setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.createAccount setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
    
    
    self.getLogin.frame = CGRectMake(70, 150, 200, 50);
    self.getPassword.frame  = CGRectMake(70, 205, 200, 50);
    self.getEmail.frame = CGRectMake(70, 260, 200, 50);
    
    // textfields
    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.getLogin.leftView = paddingView;
    self.getLogin.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewOne = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.getPassword.leftView = paddingViewOne;
    self.getPassword.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *paddingViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    self.getEmail.leftView = paddingViewTwo;
    self.getEmail.leftViewMode = UITextFieldViewModeAlways;
    
    UIColor *color= [UIColor whiteColor];
    
    
    // Login TextField
    
    self.getLogin.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"Choose your Username" attributes: @{NSForegroundColorAttributeName:color ,
                                                                                                                            NSFontAttributeName :[UIFont fontWithName: @"HelveticaNeue-Thin" size:15]}];
    self.getLogin.textColor = [UIColor whiteColor];

    
    // Password TextField
    

    self.getPassword.secureTextEntry = YES;
    self.getPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"Choose your password" attributes: @{NSForegroundColorAttributeName:color ,
                                                                                                                               NSFontAttributeName :[UIFont fontWithName: @"HelveticaNeue-Thin" size:15]}];
    self.getPassword.textColor = [UIColor whiteColor];

        // Email TextField
    

    self.getEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"Enter your E-mail" attributes: @{NSForegroundColorAttributeName:color ,
                                                                                                                            NSFontAttributeName :[UIFont fontWithName: @"HelveticaNeue-Thin" size:15]}];    self.getEmail.textColor = [UIColor whiteColor];
    [self.getEmail setKeyboardType:UIKeyboardTypeEmailAddress];

    
    // Label
    
    self.signUpLabel.text = @"Create Your  Account";
    self.signUpLabel.frame = CGRectMake(15, 100, 300, 50);
    
    self.signUpLabel.textColor = [UIColor whiteColor];
    self.signUpLabel.font = [UIFont systemFontOfSize:25];
    self.signUpLabel.textAlignment = NSTextAlignmentCenter;
    
    // LINES
    
    self.line1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 215, 260, 1)];
    self.line1.backgroundColor = [UIColor colorWithRed:29/255.0f green:34/255.0f blue:62/255.0f alpha:1.0f];
    
    self.line2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 275, 260, 1)];
    self.line2.backgroundColor = [UIColor colorWithRed:29/255.0f green:34/255.0f blue:62/255.0f alpha:1.0f];
    
    self.line3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 305, 260, 1)];
    self.line3.backgroundColor = [UIColor colorWithRed:29/255.0f green:34/255.0f blue:62/255.0f alpha:1.0f];
    
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    [self.view addSubview:self.line3];
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
     dispatch_async(dispatch_get_main_queue(),^{
    [SVProgressHUD showWithStatus:@"Adding Account"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];

    
    PFUser *user = [PFUser user];
    //2
    NSString *usernameLowerCase = self.getLogin.text;
    usernameLowerCase = [usernameLowerCase lowercaseString];
    user.username = usernameLowerCase;
    
    NSString *passwordLowerCase = self.getPassword.text;
    passwordLowerCase = [passwordLowerCase lowercaseString];
    user.password = passwordLowerCase;
    
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
     });
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}
-(UIColor *)randomColor{
    
    NSArray *rainbowColors = [[NSArray alloc] initWithObjects:
                              [UIColor colorWithRed:255/255.0 green:232/255.0 blue:0/255.0 alpha:1],
                              [UIColor colorWithRed:20/255.0 green:162/255.0 blue:212/255.0 alpha:1],
                              [UIColor colorWithRed:175/255.0 green:94/255.0 blue:156/255.0 alpha:1],
                              [UIColor colorWithRed:0/255.0 green:177/255.0 blue:106/255.0 alpha:1],
                              [UIColor colorWithRed:247/255.0 green:148/255.0 blue:30/255.0 alpha:1],
                              [UIColor colorWithRed:0/255.0 green:82/255.0 blue:156/255.0 alpha:1],
                              nil];
    
    UIColor *color = [rainbowColors objectAtIndex:arc4random()%[rainbowColors count]];
    return color;
}

@end
