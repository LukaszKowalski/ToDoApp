//
//  FriendsViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/6/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "FriendsViewController.h"


@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (void)viewDidLoad
{
    // adding tableView
    
    [super viewDidLoad];
    self.title = @"Friend's lists";
    self.friendsTableView = [[UITableView alloc] init];
    self.friendsTableView.frame = CGRectMake(0, 75, 320, 400);
    self.friendsTableView.delegate = self;
    self.friendsTableView.dataSource = self;
    [self.view addSubview:self.friendsTableView];
    self.friendsTableView.tableFooterView = [[UIView alloc ] init];
    
    // adding button
    
    self.addFriendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addFriendButton.frame = CGRectMake(0, 64, 159, 75);
    [self.addFriendButton addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addFriendButton];
    
    // adding TextField
    
    self.addTaskTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, 320, 75)];
    [self.view addSubview:self.addTaskTextField];
    
    // adding friendsList Button
    
    self.taskList = [UIButton buttonWithType:UIButtonTypeCustom];
    self.taskList.frame = CGRectMake(159, 64, 161, 75);
    [self.taskList setTitle:@"Task list" forState:UIControlStateNormal];
    self.taskList.backgroundColor = [UIColor colorWithRed:255/255.0f green:90/255.0f blue:0/255.0f alpha:1];
    [self.taskList addTarget:self action:@selector(taskListButtonFired) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.taskList];
    
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
    
    self.arrayOfFriends = [[NSMutableArray alloc] initWithObjects:(NSString *)@"Kamil", (NSString *)@"Dawid", nil];
    self.delegate = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%d", self.arrayOfFriends.count);
    return self.arrayOfFriends.count;

}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendsTableViewCell *cell = (FriendsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newFriend"];
    
    if (cell == nil) {
        cell = [[FriendsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newFriend"];
    }
    [cell.newestFriend setTitle:[NSString stringWithFormat:@"%@", [self.arrayOfFriends objectAtIndex:indexPath.row]]forState:UIControlStateNormal];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)friendsListsButtonHeight{
//    if (self.arrayOfTasks.count > 4) {
//        NSLog(@"shit;/");
//
//        [self.friendsLists setFrame:CGRectMake(self.friendsLists.frame.origin.x, self.friendsLists.frame.origin.y, self.friendsLists.frame.size.width, self.tableView.frame.size.height)];
//        NSLog(@"%f", CGRectGetHeight(self.friendsLists.frame));
//    }
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
}

-(void)addItem:(NSString *)item {
    NSLog(@"%@", item);
    [self.arrayOfFriends addObject:item];
    //    [self adjustHeightOfTableview];
    //    [self friendsListsButtonHeight];
    [self.friendsTableView reloadData];
}
- (void)addFriend:(UIButton *)sender {
    self.addTaskTextField.hidden = NO;
    self.taskList.hidden = YES;
    [self.addTaskTextField becomeFirstResponder];
    self.addTaskTextField.delegate = self;
}
- (void)taskListButtonFired{
    FriendsViewController *controller = [[self.navigationController viewControllers] objectAtIndex:1];
    [self.navigationController popToViewController:controller animated:NO];
    
    //[self.navigationController popViewControllerAnimated:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *newFriend = textField.text;
    NSLog(@"%@", newFriend);
    textField.text = @"";
    [self.delegate addItem:newFriend];
    NSLog(@"%d", self.arrayOfFriends.count);
    [self.addTaskTextField resignFirstResponder];
    self.addTaskTextField.hidden = YES;
    self.taskList.hidden = NO;
    NSLog(@"end of textfield sr");
    
    return YES;
}
//- (void)adjustHeightOfTableview
//{
//    CGFloat height = self.tableView.contentSize.height;
//
//    [UIView animateWithDuration:0.25 animations:^{
//        CGRect frame = self.tableView.frame;
//        frame.size.height = height;
//        self.tableView.frame = frame;
//
//    }];
//}




@end
