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

    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    self.view.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.signUpLabel = [[UILabel alloc] init];
    self.getLogin = [[UITextField alloc] init];
    self.getPassword = [[UITextField alloc] init];
    self.getEmail = [[UITextField alloc] init];
    
    self.createAccount = [[UIButton alloc] initWithFrame:CGRectMake(30, 330, 260, 50)];
    [self.createAccount setTitle:@"Create Account" forState:UIControlStateNormal];
    [self.createAccount setBackgroundColor:[UIColor colorWithRed:7/255.0f green:210/255.0f blue:126/255.0f alpha:1.0f]];
    [self.createAccount addTarget:self action:@selector(createAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self.createAccount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    
    self.getLogin.frame = CGRectMake(0, 140, self.view.frame.size.width, 50);
    self.getPassword.frame  = CGRectMake(0, 190, self.view.frame.size.width, 50);
    self.getEmail.frame = CGRectMake(0, 240, self.view.frame.size.width, 50);
    self.getLogin.textAlignment = NSTextAlignmentCenter;
    self.getEmail.textAlignment = NSTextAlignmentCenter;
    self.getPassword.textAlignment = NSTextAlignmentCenter;
    
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
    self.getLogin.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.getLogin.autocorrectionType = UITextAutocorrectionTypeNo;
    self.getLogin.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    // Password TextField
    

    self.getPassword.secureTextEntry = YES;
    self.getPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"Choose your password" attributes: @{NSForegroundColorAttributeName:color ,
                                                                                                                               NSFontAttributeName :[UIFont fontWithName: @"HelveticaNeue-Thin" size:15]}];
    self.getPassword.textColor = [UIColor whiteColor];
    
    self.getPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.getPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    self.getPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        // Email TextField
    

    self.getEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString: @"Enter your E-mail (Optional)" attributes: @{NSForegroundColorAttributeName:color ,
                                                                                                                            NSFontAttributeName :[UIFont fontWithName: @"HelveticaNeue-Thin" size:15]}];    self.getEmail.textColor = [UIColor whiteColor];
    [self.getEmail setKeyboardType:UIKeyboardTypeEmailAddress];
    
    self.getEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.getEmail.autocorrectionType = UITextAutocorrectionTypeNo;
    self.getEmail.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    
    // Label
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    NSMutableDictionary *textProperties = [NSMutableDictionary dictionary];
    textProperties[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue-Thin" size:25];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:NSLocalizedString( @"Create Your  Account", nil)
                                                                           attributes:textProperties];
    textLayer.string = attributedString;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.frame = self.view.bounds;
    
    UIImage *rainbowImage = [UIImage imageNamed:@"Rainbow"];
    self.imageView = [[UIImageView alloc] initWithImage:rainbowImage];
    self.imageView.layer.mask = textLayer;
    
    self.imageView.frame = CGRectMake(0, 88, self.view.frame.size.width, 50);

    [self.view addSubview: self.imageView];
    
    
    // LINES
    
    self.line1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 186, 260, 1)];
    self.line1.backgroundColor = [UIColor colorWithRed:29/255.0f green:34/255.0f blue:62/255.0f alpha:1.0f];
    
    self.line2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 236, 260, 1)];
    self.line2.backgroundColor = [UIColor colorWithRed:29/255.0f green:34/255.0f blue:62/255.0f alpha:1.0f];
    
    self.line3 = [[UILabel alloc] initWithFrame:CGRectMake(30, 286, 260, 1)];
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

// Creating Account

-(void)createAccount:(id)sender{
    
    //1
     dispatch_async(dispatch_get_main_queue(),^{
    [SVProgressHUD showWithStatus:@"Adding Account"];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeGradient];

    
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
            [[ParseStore sharedInstance] addTaskDoTeam:@"Swipe right to delete task" forNumber:1];
            [[ParseStore sharedInstance] addTaskDoTeam:@"Swipe left, find who gave you \"do\"" forNumber:2];
            [[ParseStore sharedInstance] addTaskDoTeam:@"Hi, welcome in \"Do\" ;)" forNumber:0];

            [SVProgressHUD dismiss];
            
        } else {
            
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
            [SVProgressHUD dismiss];
        }
    }];
     });
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}


@end
