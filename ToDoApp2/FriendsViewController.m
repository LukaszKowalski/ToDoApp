//
//  FriendsViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/6/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "FriendsViewController.h"
#import "DataStore.h"


@interface FriendsViewController ()

@property (strong, nonatomic) FriendsToDoViewController *controller;
@property (strong, nonatomic) UIActivityIndicatorView *loginIndicator;
@property (strong, nonatomic) NSMutableDictionary *userCell;
@property (strong, nonatomic) SettingsViewController* settingsViewController;


@end

@implementation FriendsViewController

- (void)viewDidLoad
{
 
    // adding tableView
    
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.friendsTableView = [[UITableView alloc] init];
    CGSize viewSize = self.view.frame.size;
    self.friendsTableView.frame = CGRectMake(13, 75, viewSize.width-26, viewSize.height -73);
    self.friendsTableView.delegate = self;
    self.friendsTableView.dataSource = self;
    [self.view addSubview:self.friendsTableView];
    self.friendsTableView.tableFooterView = [[UIView alloc ] init];
    [self.friendsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.friendsTableView.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadTableView" object:nil];
    
    // cap below menu
    
    self.cap = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 320, 75)];
    self.cap.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    [self.view addSubview:self.cap];

    
    // adding button
    
    self.addFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addFriendButton.frame = CGRectMake(120, 64, 75, 75);
    self.addFriendButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    [self.addFriendButton addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addFriendButton];
    
    // adding TextField
    
    
        // adding friendsList Button
    
    [self.view addSubview:self.addTaskTextField];
    
    // Button 'back to ToDoViewController
//    UIImage *taskImage = [UIImage imageNamed:@"taskImage.png"];
//    [self.backButton setImage:taskImage forState:UIControlStateNormal];

    

    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(20, 64, 81, 75);
    self.backButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    
    UIImage *btnImage = [UIImage imageNamed:@"IcoTask.png"];
    [self.backButton setImage:btnImage forState:UIControlStateNormal];
    self.backButton.backgroundColor = [UIColor clearColor];
    [self.backButton addTarget:self action:@selector(backButtonFired) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    // conf button
    
    UIImage *plusImage = [UIImage imageNamed:@"IcoPlus.png"];
    [self.addFriendButton setImage:plusImage forState:UIControlStateNormal];
    self.addFriendButton.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.addFriendButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    self.addFriendButton.tag = 1;
    
    // conf textfield
    
    self.addTaskTextField = [[UITextField alloc] initWithFrame:CGRectMake(13, 134, 294, 70)];
    self.addTaskTextField.backgroundColor = [UIColor whiteColor];
    self.addTaskTextField.textAlignment= NSTextAlignmentCenter;
    self.addTaskTextField.textColor = [[ParseStore sharedInstance] randomColor];
    self.addTaskTextField.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type your friend's nick"];
    self.addTaskTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.addTaskTextField.hidden = YES;
    self.addTaskTextField.autocorrectionType = UITextAutocorrectionTypeNo;

    [self.view addSubview:self.addTaskTextField];

    // Rainbow Sign
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    NSMutableDictionary *textProperties = [NSMutableDictionary dictionary];
    textProperties[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Friends list", nil)
                                                                           attributes:textProperties];
    textLayer.string = attributedString;
    textLayer.frame = self.view.bounds;
    
    UIImage *rainbowImage = [UIImage imageNamed:@"Rainbow"];
    self.imageView = [[UIImageView alloc] initWithImage:rainbowImage];
    self.imageView.layer.mask = textLayer;
    
    self.imageView.frame = CGRectMake(125,26,320,40);
    [self.view addSubview: self.imageView];

    
    // confirmButton
    
    UIImage *confirmImage = [UIImage imageNamed:@"IcoCheck.png"];

    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setImage:confirmImage forState:UIControlStateNormal];
    self.confirmButton.frame = CGRectMake(219, 64, 81, 75);
    self.confirmButton.backgroundColor = [UIColor clearColor];
    [self.confirmButton addTarget:self action:@selector(confirmTask) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];
    self.confirmButton.hidden = YES;

    self.goToFriendsToDo = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(225, 115, 30, 30)];
    [self.goToFriendsToDo setBackgroundColor:[UIColor clearColor]];
    [self.goToFriendsToDo setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:self.goToFriendsToDo];
    [self.goToFriendsToDo bringSubviewToFront:self.friendsTableView];
    
    // settings
    
//    UIImage *settingsImage = [UIImage imageNamed:@"IcoSettings.png"];
//    self.settings = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.settings setImage:settingsImage forState:UIControlStateNormal];
//    self.settings.frame = CGRectMake(219, 64, 81, 75);
//    self.settings.backgroundColor = [UIColor clearColor];
//    [self.settings addTarget:self action:@selector(goToSettings) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.settings];
//    self.settings.hidden = NO;

    
    
    // initArray

    [self reloadTableView];
    self.delegate = self;
}

// loading tasks to tableView

- (void)reloadTableView{

    NSMutableArray *friends = [[NSMutableArray alloc] init];
    self.friendsTableView.userInteractionEnabled = YES;

    friends = [[DataStore sharedInstance] loadFriends:@"friendsArrayLocally"];
    self.arrayOfFriends = [[friends reverseObjectEnumerator] allObjects];
    
    if (self.arrayOfFriends == nil) {
        
        self.arrayOfFriends = @[
                                   @{@"color": @"0.603922,0.831373,0.419608,1.000000", @"principal": @"DoTeam",
                                     @"username": @"Simply add your friend username", @"taskUsernameId": @"asdfasdfas"},
                                   @{@"color": @"1.000000,0.792157,0.368627,1.000000", @"principal": @"DoTeam",
                                     @"username": @"or add \"DoTeam\" ", @"taskUsernameId": @"asdfasdfas"}                                   ];
        
    self.delegate = self;
    
        self.friendsTableView.userInteractionEnabled = NO;

    }
    [self.friendsTableView reloadData];
    [SVProgressHUD dismiss];
}

// getting tasks from PARSE

-(void)loadArrayOfFriends:(NSMutableArray *)array {
//
//    NSMutableArray* reversed = [[array reverseObjectEnumerator] allObjects];
//    
//    self.arrayOfFriends = reversed;
//    [self.friendsTableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayOfFriends count];

}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendsTableViewCell *cell = (FriendsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newFriend"];
    
    if (cell == nil) {
        cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newFriend"];
    }
    
    self.userCell = [self.arrayOfFriends objectAtIndex:indexPath.row];
    cell.newestFriend.text = [self.userCell objectForKey:@"username"];
    NSString *colorInString = [self.userCell objectForKey:@"color"];
    cell.newestFriend.backgroundColor = [[ParseStore sharedInstance] giveColorfromStringColor:colorInString];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{

    [SVProgressHUD showWithStatus:@"Loading Tasks" maskType:SVProgressHUDMaskTypeGradient];
    dispatch_async(dispatch_get_main_queue(),^{
        
        FriendsToDoViewController *friendsToDoView = [[FriendsToDoViewController alloc] init];
        
        self.userCell = [self.arrayOfFriends objectAtIndex:indexPath.row];
        [[ParseStore sharedInstance] asignWhosViewControllerItIs:self.userCell];
        friendsToDoView.titleName = [NSString stringWithFormat:@"%@", [self.userCell objectForKey:@"username"]];
        
        [self.navigationController pushViewController:friendsToDoView animated:NO];
        [self.friendsTableView deselectRowAtIndexPath:indexPath animated:NO];
    });

}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

-(void)addItem:(NSString *)item {
    
     dispatch_async(dispatch_get_main_queue(),^{

    [SVProgressHUD showWithStatus:@"Adding Friend" maskType:SVProgressHUDMaskTypeGradient];

    [[ParseStore sharedInstance] addFriend:item];
    
    [self.friendsTableView reloadData];
     });
    
}
    
- (void)addFriend:(UIButton *)sender {
    
    [self.friendsTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    if (self.addFriendButton.tag == 1) {
        
        self.addTaskTextField.alpha = 1;
        self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type your friend's nick"];

        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGSize viewSize = self.view.frame.size;
            
            [self.friendsTableView setFrame:CGRectMake(13, 140, viewSize.width -26, viewSize.height -73)];
            [self.addFriendButton setTransform:CGAffineTransformRotate(self.addFriendButton.transform, M_PI/4)];
        } completion:^(BOOL finished) {
            self.confirmButton.hidden = NO;
            self.addTaskTextField.hidden = NO;
            self.addTaskTextField.backgroundColor = [UIColor whiteColor];
        }];
        [self.addTaskTextField becomeFirstResponder];
        self.addTaskTextField.delegate = self;
        self.addFriendButton.tag = 2;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            CGSize viewSize = self.view.frame.size;
            self.addTaskTextField.hidden = YES;
            
            [self.friendsTableView setFrame:CGRectMake(13, 75, viewSize.width -26, viewSize.height -73)];
            [self.addFriendButton setTransform:CGAffineTransformRotate(self.addFriendButton.transform, M_PI/4)];
        }];
        self.confirmButton.hidden = YES;
        [self.addTaskTextField resignFirstResponder];
        self.addFriendButton.tag = 1;
    }

//    self.addTaskTextField.delegate = self;
}
- (void)backButtonFired{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void) goToSettings{
    
    if (!self.settingsViewController){
        self.settingsViewController = [[SettingsViewController alloc] init];
    }
    [self.friendsTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self.navigationController pushViewController:self.settingsViewController animated:NO];
    
    
}


// potwierdzanie taska

- (void) confirmTask{
    
    [self textFieldShouldReturn:self.addTaskTextField];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [SVProgressHUD show];
    NSString *newFriend = textField.text;
    textField.text = @"";
    
    
    [self.delegate addItem:newFriend];
    [self.addTaskTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.addTaskTextField.hidden = YES;
        CGSize viewSize = self.view.frame.size;
        [self.addFriendButton setTransform:CGAffineTransformRotate(self.addFriendButton.transform, M_PI/4)];

    [self.friendsTableView setFrame:CGRectMake(13, 75, viewSize.width -26, viewSize.height -73)];
    }];
    [self.addTaskTextField resignFirstResponder];
    self.addFriendButton.tag = 1;
    self.confirmButton.hidden = YES;
    self.addTaskTextField.hidden = YES;
    self.backButton.hidden = NO;
    
    return YES;
}



@end
