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
    
    [self reloadTableView];
    self.delegate = self;
    
}
- (void)reloadTableView{
    
    self.delegate = self;
    [[ParseStore sharedInstance] loadTasksForUser:self forUser:[NSString stringWithFormat:@"%@", self.titleName]];
    [self.tableView reloadData];
    
}
-(void)loadArrayOfTaskss:(NSMutableArray *)array {
    
    self.arrayOfUserTasks = array;
    [self.tableView reloadData];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayOfUserTasks.count;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newItem"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newItem"];
    }
    // init Label
    
    PFObject *task  = [self.arrayOfUserTasks objectAtIndex:indexPath.row];
    NSString *colorInString = [task objectForKey:@"color"];
    
    self.taskForFriend = [[UILabel alloc] init];
    self.taskForFriend.frame = CGRectMake(0, 0, 320, 78);
    self.taskForFriend.backgroundColor = [[ParseStore sharedInstance] giveColorfromStringColor:colorInString];
    self.taskForFriend.textColor = [UIColor whiteColor];
    self.taskForFriend.font = [UIFont systemFontOfSize:26];
    self.taskForFriend.textAlignment = NSTextAlignmentCenter;
    self.taskForFriend.text = [task objectForKey:@"taskString"];
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)addItem:(NSString *)item {
    
    [[ParseStore sharedInstance] addTask:item forUser:[NSString stringWithFormat:@"%@", self.titleName]];
    [self.tableView reloadData];
    [self reloadTableView];
    
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






@end
