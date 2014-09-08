//
//  FriendsToDoViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/9/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "FriendsToDoViewController.h"

@interface FriendsToDoViewController ()

@property (strong, nonatomic) FriendsToDoViewController *friendsToDoController;

@end

@implementation FriendsToDoViewController



- (void)viewDidLoad
{
    // adding tableView
    
    [super viewDidLoad];
    self.title =[NSString stringWithFormat:@"%@'s list", self.titleName];
    self.navigationItem.hidesBackButton = YES;
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 75, 320, 400);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc ] init];
    
    // nav bar
    
    self.bar = [[UINavigationBar alloc] init];
    [self.bar setFrame:CGRectMake(0, 20, 320, 44)];
    self.bar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.bar];
    
    // adding button
    
    self.addTaskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addTaskButton.frame = CGRectMake(0, 64, 159, 75);
    [self.addTaskButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addTaskButton];
    
    // adding TextField
    
    self.addTaskTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, 320, 75)];
    [self.view addSubview:self.addTaskTextField];
    
    // adding friendsList Button
    
    self.friendsLists = [UIButton buttonWithType:UIButtonTypeCustom];
    self.friendsLists.frame = CGRectMake(159, 64, 161, 75);
    [self.friendsLists setTitle:@"Friend's lists" forState:UIControlStateNormal];
    self.friendsLists.backgroundColor = [UIColor colorWithRed:255/255.0f green:90/255.0f blue:0/255.0f alpha:1];
    [self.friendsLists addTarget:self action:@selector(friendsButtonFired) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.friendsLists];
    
    // conf button
    
    [self.addTaskButton setTitle:@"+" forState:UIControlStateNormal];
    self.addTaskButton.backgroundColor = [UIColor colorWithRed:255/255.0f green:114/255.0f blue:0/255.0f alpha:1];
    self.addTaskButton.titleLabel.font = [UIFont systemFontOfSize:40];
    
    // conf textfield
    
    self.addTaskTextField.backgroundColor = [UIColor colorWithRed:255/255.0f green:114/255.0f blue:0/255.0f alpha:1];
    self.addTaskTextField.textAlignment= NSTextAlignmentCenter;
    self.addTaskTextField.textColor = [UIColor whiteColor];
    self.addTaskTextField.font = [UIFont systemFontOfSize:28];
    self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type task for %@", self.titleName];
    self.addTaskTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.addTaskTextField.hidden = YES;
    
    // initArray
    
//    [[DataStore sharedInstance] loadUserTasks:[NSString stringWithFormat:@"Data_%@", self.user.userIdNumber]];
    self.delegate = self;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%lu", (unsigned long)self.arrayOfFriendsTask.count);
    return self.arrayOfFriendsTask.count;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newItem"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newItem"];
    }
    // init Label
    
    self.taskForFriend = [[UILabel alloc] init];
    self.taskForFriend.frame = CGRectMake(0, 0, 320, 78);
    self.taskForFriend.backgroundColor = [self randomColor];
    self.taskForFriend.textAlignment = NSTextAlignmentCenter;
    self.taskForFriend.text = [NSString stringWithFormat:@"%@", [self.arrayOfFriendsTask objectAtIndex:indexPath.row]];
    [cell.contentView addSubview:self.taskForFriend];
    
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
    
}

-(void)addItem:(NSString *)item {
    
    [[DataStore sharedInstance] addTaskForUser:self.user item:item];
    [self.tableView reloadData];
    
}
- (void)addTask:(UIButton *)sender {
    
    self.addTaskTextField.hidden = NO;
    self.friendsLists.hidden = YES;
    [self.addTaskTextField becomeFirstResponder];
    self.addTaskTextField.delegate = self;
    
}
- (void)friendsButtonFired{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *newTask = textField.text;
    
    textField.text = @"";
    [self.delegate addItem:newTask];
    
    [self.addTaskTextField resignFirstResponder];
    self.addTaskTextField.hidden = YES;
    self.friendsLists.hidden = NO;
    
    
    return YES;
}

-( UIColor *)randomColor{
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
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
