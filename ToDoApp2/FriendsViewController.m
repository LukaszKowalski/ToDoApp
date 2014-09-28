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
@property (weak, nonatomic) NSDictionary *userCell;

@end

@implementation FriendsViewController

- (void)viewDidLoad
{
 
    // adding tableView
    
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Friends list";
    self.friendsTableView = [[UITableView alloc] init];
    self.friendsTableView.frame = CGRectMake(10, 75, 300, 410);
    self.friendsTableView.delegate = self;
    self.friendsTableView.dataSource = self;
    [self.view addSubview:self.friendsTableView];
    self.friendsTableView.tableFooterView = [[UIView alloc ] init];
    [self.friendsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.friendsTableView.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadTableView" object:nil];
    
    // adding button
    
    self.addFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addFriendButton.frame = CGRectMake(0, 64, 159, 75);
    self.addFriendButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.addFriendButton addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addFriendButton];
    
    // adding TextField
    
    self.addTaskTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, 320, 75)];
    [self.view addSubview:self.addTaskTextField];
    
    // adding friendsList Button
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(159, 64, 161, 75);
    [self.backButton setTitle:@"Task list" forState:UIControlStateNormal];
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:25];
    self.backButton.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    [self.backButton addTarget:self action:@selector(backButtonFired) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    // conf button
    
    [self.addFriendButton setTitle:@"+" forState:UIControlStateNormal];
        self.addFriendButton.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.addFriendButton.titleLabel.font = [UIFont systemFontOfSize:40];
    
    // conf textfield
    
    self.addTaskTextField.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];;
    self.addTaskTextField.textAlignment= NSTextAlignmentCenter;
    self.addTaskTextField.textColor = [UIColor whiteColor];
    self.addTaskTextField.font = [UIFont systemFontOfSize:28];
    self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type your friend's nick"];
    self.addTaskTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.addTaskTextField.hidden = YES;
    
    // initArray
    
    [self reloadTableView];
    self.delegate = self;
}

- (void)reloadTableView{

    self.delegate = self;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [NSString stringWithFormat:@"%@/friends.plist", documentsDirectory];
    
    
    self.arrayOfFriends = [[NSMutableArray alloc] initWithContentsOfFile:fullPath];
    
    
    if (self.arrayOfFriends == nil) {
      [[ParseStore sharedInstance] loadFriends:self withObjectId:[PFUser currentUser].objectId];
    }
    
    [self.friendsTableView reloadData];

}

-(void)loadArrayOfFriends:(NSMutableArray *)array {
    self.arrayOfFriends = array;
    [self.friendsTableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"licza friendsow %d", [self.arrayOfFriends count]);
    return [self.arrayOfFriends count];

}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendsTableViewCell *cell = (FriendsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newFriend"];
    
    if (cell == nil) {
        cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newFriend"];
    }
    

    self.userCell = [ self.arrayOfFriends objectAtIndex:indexPath.row];
    cell.newestFriend.text = [self.userCell objectForKey:@"username"];
    NSString *colorInString = [self.userCell objectForKey:@"color"];
    cell.newestFriend.backgroundColor = [[ParseStore sharedInstance] giveColorfromStringColor:colorInString];
    return cell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    FriendsToDoViewController *friendsToDoView = [[FriendsToDoViewController alloc] init];
    
    self.userCell = [self.arrayOfFriends objectAtIndex:indexPath.row];
    NSLog(@" self.userCell = %@", self.userCell);
    [[ParseStore sharedInstance] asignWhosViewControllerItIs:self.userCell];
    friendsToDoView.titleName = [NSString stringWithFormat:@"%@", [self.userCell objectForKey:@"username"]];
    [self.navigationController pushViewController:friendsToDoView animated:YES];
    [self.friendsTableView deselectRowAtIndexPath:indexPath animated:NO];

}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

-(void)addItem:(NSString *)item {
    
    
    [self.view addSubview:self.loginIndicator];
    [self.view bringSubviewToFront:self.loginIndicator];
    self.loginIndicator.frame = CGRectMake(100, 200, 44, 44);
    [[ParseStore sharedInstance] addFriend:item];
    [self.friendsTableView reloadData];
    [self reloadTableView];
    
}
    
- (void)addFriend:(UIButton *)sender {
    self.addTaskTextField.hidden = NO;
    self.backButton.hidden = YES;
    [self.addTaskTextField becomeFirstResponder];
    self.addTaskTextField.delegate = self;
}
- (void)backButtonFired{

    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *newFriend = textField.text;
    textField.text = @"";
    [self.delegate addItem:newFriend];
    [self.addTaskTextField resignFirstResponder];
    self.addTaskTextField.hidden = YES;
    self.backButton.hidden = NO;
    
    return YES;
}



@end
