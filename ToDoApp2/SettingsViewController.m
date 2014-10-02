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
   
    self.sendSms = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendSms.frame = CGRectMake(120, 64, 75, 75);
    self.sendSms.backgroundColor = [UIColor whiteColor];
    self.sendSms.titleLabel.font = [UIFont systemFontOfSize:25];
    self.sendSms.titleLabel.adjustsLetterSpacingToFitWidth = YES;
    [self.sendSms addTarget:self action:@selector(sendSms:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendSms];
    
    self.logout = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logout.frame = CGRectMake(120, 200, 75, 75);
    self.logout.backgroundColor = [UIColor whiteColor];
    self.logout.titleLabel.font = [UIFont systemFontOfSize:25];
    self.logout.titleLabel.adjustsLetterSpacingToFitWidth = YES;
    [self.logout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logout];
    
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
