//
//  FriendsViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/6/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "FriendsViewController.h"
#import "DataStore.h"
#import "DoUser.h"
#import "ParseStore.h"


@interface FriendsViewController ()

@property (strong, nonatomic) FriendsToDoViewController *controller;

@end

@implementation FriendsViewController

- (void)viewDidLoad
{
    // adding tableView
    
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Friends list";
    self.friendsTableView = [[UITableView alloc] init];
    self.friendsTableView.frame = CGRectMake(0, 75, 320, 400);
    self.friendsTableView.delegate = self;
    self.friendsTableView.dataSource = self;
    [self.view addSubview:self.friendsTableView];
    self.friendsTableView.tableFooterView = [[UIView alloc ] init];
    
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
    self.backButton.backgroundColor = [UIColor colorWithRed:255/255.0f green:90/255.0f blue:0/255.0f alpha:1];
    [self.backButton addTarget:self action:@selector(backButtonFired) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    // conf button
    
    [self.addFriendButton setTitle:@"+" forState:UIControlStateNormal];
    NSLog(@"%@", NSStringFromCGRect(self.addFriendButton.frame));
    self.addFriendButton.backgroundColor = [UIColor colorWithRed:255/255.0f green:114/255.0f blue:0/255.0f alpha:1];
    self.addFriendButton.titleLabel.font = [UIFont systemFontOfSize:40];
    
    // conf textfield
    
    self.addTaskTextField.backgroundColor = [UIColor colorWithRed:255/255.0f green:114/255.0f blue:0/255.0f alpha:1];
    self.addTaskTextField.textAlignment= NSTextAlignmentCenter;
    self.addTaskTextField.textColor = [UIColor whiteColor];
    self.addTaskTextField.font = [UIFont systemFontOfSize:28];
    self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type your friend's nick"];
    self.addTaskTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.addTaskTextField.hidden = YES;
    
    // initArray
    
    [[DataStore sharedInstance] loadFriends:@"friendsArray"];
    
    [self reloadTableView];
    self.delegate = self;
    

    
}

- (void)reloadTableView{
    
    [[DataStore sharedInstance] loadData:@"friendsArray"];
    self.delegate = self;
    [self.friendsTableView reloadData];
    [[ParseStore sharedInstance] loadFriends:self];
}

-(void)loadArrayOfFriends:(NSMutableArray *)array {
    self.arrayOfFriends = array;
    [self.friendsTableView reloadData];
    NSLog(@"ArrayOfFriends has %lu friends", (unsigned long)self.arrayOfFriends.count);
    NSLog(@"%@", [self.arrayOfFriends objectAtIndex:0]);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arrayOfFriends count];

}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendsTableViewCell *cell = (FriendsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newFriend"];
    
    if (cell == nil) {
        cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newFriend"];
    }
    
//  DoUser *user = [[[DataStore sharedInstance] arrayOfFriends] objectAtIndex:indexPath.row];
    NSString *user = [self.arrayOfFriends objectAtIndex:indexPath.row];
    NSLog(@"co to jest %@", user);
    cell.newestFriend.text = user;
//    cell.user = user;
    
//    UILongPressGestureRecognizer* gestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
//    [cell addGestureRecognizer:gestureRecognizer];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    FriendsToDoViewController *friendsToDoView = [[FriendsToDoViewController alloc] init];
    
    DoUser *user = [[[DataStore sharedInstance] arrayOfFriends] objectAtIndex:indexPath.row];
    
    friendsToDoView.titleName = [NSString stringWithFormat:@"%@", [user username]];
    friendsToDoView.user = user;
    [self.navigationController pushViewController:friendsToDoView animated:YES];
    [self.friendsTableView deselectRowAtIndexPath:indexPath animated:NO];

}

-(void)addItem:(NSString *)item {
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
-(NSString *)getRandomId
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    return uuidString;
}
-( UIColor *)randomColor{
    
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    NSLog(@"%f, %f, %f", red, blue, green );
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}
//-(void)longPressed:(UILongPressGestureRecognizer *)sender{
//    NSLog(@"longPressed");
//    FriendsTableViewCell *cell = (FriendsTableViewCell *)sender.view;
//    DoUser *user = cell.user;
//    [[DataStore sharedInstance] deleteUser:user];
//    [self.friendsTableView reloadData];
//}



@end
