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
   
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Sms Button
    

    self.sendSms = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendSms.frame = CGRectMake(120, 110, 75, 75);
    self.sendSms.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    [self.sendSms addTarget:self action:@selector(sendSms:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *sms = [UIImage imageNamed:@"Invite.png"];
    [self.sendSms setImage:sms forState:UIControlStateNormal];
    [self.view addSubview:self.sendSms];
    

    // Logout Button

    self.logout = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logout.frame = CGRectMake(120, 220, 75, 75);
    self.logout.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.logout.titleLabel.font = [UIFont systemFontOfSize:25];
    self.logout.titleLabel.adjustsLetterSpacingToFitWidth = YES;
    [self.logout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logout];
    UIImage *logout = [UIImage imageNamed:@"IcoLogout.png"];
    [self.logout setImage:logout forState:UIControlStateNormal];
    
    // Invite Button

    self.invite = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 75)];
    self.invite.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.invite.textAlignment = NSTextAlignmentCenter;
    self.invite.text = @"Invite Friends";
    self.invite.textColor = [UIColor whiteColor];
    [self.view addSubview:self.invite];
    
    // Logout Label
    
    self.logoutLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 180, self.view.frame.size.width, 75)];
    self.logoutLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    self.logoutLabel.textAlignment = NSTextAlignmentCenter;
    self.logoutLabel.text = @"Log Out";
    self.logoutLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:self.logoutLabel];
    
    // Rainbow Sign
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    NSMutableDictionary *textProperties = [NSMutableDictionary dictionary];
    textProperties[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0f];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Settings", nil)
                                                                           attributes:textProperties];
    textLayer.string = attributedString;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.frame = self.view.bounds;
    
    UIImage *rainbowImage = [UIImage imageNamed:@"Rainbow"];
    self.imageView = [[UIImageView alloc] initWithImage:rainbowImage];
    self.imageView.layer.mask = textLayer;
    self.imageView.frame = CGRectMake(0, 30, self.view.frame.size.width, 40);

    [self.view addSubview: self.imageView];
    
    PFUser *user = [PFUser currentUser];
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        
        self.connectFacebookButton = [[UILabel alloc] initWithFrame:CGRectMake(0, 280, self.view.frame.size.width, 75)];
        self.connectFacebookButton.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        self.connectFacebookButton.textAlignment = NSTextAlignmentCenter;
        self.connectFacebookButton.text = @"Connect your account";
        self.connectFacebookButton.textColor = [UIColor whiteColor];
        [self.view addSubview:self.connectFacebookButton];
        
        UILabel *whyConnect = [[UILabel alloc] initWithFrame:CGRectMake(40, 390, self.view.frame.size.width-80, 75)];
        whyConnect.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        whyConnect.textAlignment = NSTextAlignmentCenter;
        whyConnect.text = @"Connect your account with Facebook, and find your friends who also use DoApp";
        whyConnect.textColor = [UIColor whiteColor];
        whyConnect.lineBreakMode = NSLineBreakByWordWrapping;
        whyConnect.numberOfLines = 0;
        [self.view addSubview:whyConnect];

        
        UIButton *facebooklogin = [[UIButton alloc] initWithFrame:CGRectMake(30, 340, 260, 50)];
        [facebooklogin addTarget:self action:@selector(connectFacebook) forControlEvents:UIControlEventTouchUpInside];
        [facebooklogin setImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
        [self.view addSubview:facebooklogin];
    }
    
}

-(void)connectFacebook{
    PFUser *user = [PFUser currentUser];
    NSArray *permissionsArray = @[ @"user_about_me", @"user_friends", @"email"];
    
    if (![PFFacebookUtils isLinkedWithUser:user]) {
        [PFFacebookUtils linkUserInBackground:user withReadPermissions:permissionsArray block:^(BOOL succeeded, NSError *error){
            if ([PFFacebookUtils isLinkedWithUser:user]) {
                FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,first_name,email,last_name" parameters:nil];
                [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    if (!error) {
                        NSString *fbId = result[@"id"];
                        [[PFUser currentUser] setObject:fbId forKey:@"fbId"];
                        [[PFUser currentUser] saveInBackground];
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

                    }
                }];
            }
        }];
    }
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
    NSString *message = [NSString stringWithFormat:@"Hi, find \"Do\" on the appstore! My username is: %@. https://itunes.apple.com/us/app/doapp/id928866777", [[PFUser currentUser] username]];
    
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

        [self resetDefaults];
    
            if (!self.loginController) {
                self.loginController = [[LoginViewController alloc] init];

        self.loginController.navigationController.navigationItem.hidesBackButton = YES;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}
- (void)resetDefaults {
    
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }

    [[DataStore sharedInstance] clearAll];
    
    [defs synchronize];
}



@end
