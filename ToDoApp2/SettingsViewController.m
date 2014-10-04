//
//  SettingsViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 10/1/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) LoginViewController *loginController;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Sms Button
    

    self.sendSms = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendSms.frame = CGRectMake(120, 64, 75, 75);
    self.sendSms.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    [self.sendSms addTarget:self action:@selector(sendSms:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *sms = [UIImage imageNamed:@"IcoLogout.png"];
    [self.sendSms setImage:sms forState:UIControlStateNormal];
    [self.view addSubview:self.sendSms];
    

    // Logout Button

    self.logout = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logout.frame = CGRectMake(120, 200, 75, 75);
    self.logout.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.logout.titleLabel.font = [UIFont systemFontOfSize:25];
    self.logout.titleLabel.adjustsLetterSpacingToFitWidth = YES;
    [self.logout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logout];
    UIImage *logout = [UIImage imageNamed:@"IcoLogout.png"];
    [self.logout setImage:logout forState:UIControlStateNormal];
    
    // Invite Button
    
    self.invite = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, 320, 75)];
    self.invite.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.invite.text = @"Invite Friends";
    self.invite.textColor = [UIColor whiteColor];
    [self.view addSubview:self.invite];
    
    // Logout Label
    
    self.logoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 160, 320, 75)];
    self.logoutLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.logoutLabel.text = @"Log Out";
    self.logoutLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.logoutLabel];
    
    // Line Labels
    
    self.line1 = [[UILabel alloc] initWithFrame:CGRectMake(30, 215, 260, 1)];
    self.line1.backgroundColor = [UIColor colorWithRed:29/255.0f green:34/255.0f blue:62/255.0f alpha:1.0f];
    self.line2 = [[UILabel alloc] initWithFrame:CGRectMake(30, 275, 260, 1)];
    self.line2.backgroundColor = [UIColor colorWithRed:31/255.0f green:33/255.0f blue:86/255.0f alpha:1.0f];
    [self.view addSubview:self.line1];
    [self.view addSubview:self.line2];
    
    // Rainbow Sign
    
    
        CATextLayer *textLayer = [[CATextLayer alloc] init];
        textLayer.contentsScale = [UIScreen mainScreen].scale;
        NSMutableDictionary *textProperties = [NSMutableDictionary dictionary];
        textProperties[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18.0f];
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"My Tasks", nil)
                                                                               attributes:textProperties];
        
        textLayer.string = attributedString;
        
        
        textLayer.frame = self.view.bounds;
        
        UIImage *rainbowImage = [UIImage imageNamed:@"Rainbow"];
        self.imageView = [[UIImageView alloc] initWithImage:rainbowImage];
        self.imageView.layer.mask = textLayer;
        
        [self.imageView sizeToFit];
        self.imageView.center = self.view.center;
        self.imageView.frame = CGRectIntegral(self.imageView.frame);
        [self.view addSubview:self.imageView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendSms:(UIButton *)sender{
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    NSArray *recipents = nil;
    NSString *message = [NSString stringWithFormat:@"Hi, kurwa DO jest zajebiste."];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)logout:(UIButton *)sender{
    [PFUser logOut];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"username"]){
        
        if (!self.loginController) {
            self.loginController = [[LoginViewController alloc] init];
        }
        self.loginController.navigationController.navigationItem.hidesBackButton = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}



@end
