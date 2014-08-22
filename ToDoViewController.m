//
//  ToDoViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "ToDoViewController.h"
#import "DataStore.h"
#import "DoTask.h"

@interface ToDoViewController ()

@property (strong, nonatomic) FriendsViewController *friendsController;
@property (strong, nonatomic) NSString *dataFilePath;


@end

@implementation ToDoViewController



- (void)viewDidLoad
{
    // adding tableView
    
    [super viewDidLoad];
    self.view.backgroundColor = [self randomColor];
    self.title = @"Add New Task";
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 75, 320, 410);
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
    self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type your task"];
    self.addTaskTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.addTaskTextField.hidden = YES;
    
    // initArray
    
    NSArray *array = [[DataStore sharedInstance] loadData:@"tasksArray"];
    if(array != nil) {
    
        self.arrayOfTasks = [array mutableCopy];
    }else{
        self.arrayOfTasks = [NSMutableArray new];
    }
    self.delegate = self;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%d", self.arrayOfTasks.count);
    return self.arrayOfTasks.count;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewTaskTableViewCell *cell = (NewTaskTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newItem"];
    
    if (cell == nil) {
        cell = [[NewTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newItem"];
    }
    DoTask *task = [self.arrayOfTasks objectAtIndex:indexPath.row];
    cell.newestTask.backgroundColor = task.taskColor;
    [cell.newestTask setTitle:[NSString stringWithFormat:@"%@", task.taskString]forState:UIControlStateNormal];

    return cell;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
}

-(void)addItem:(NSString *)item {
    NSLog(@"%@", item);
    DoTask *task = [DoTask new];
    task.idNumber = [self getRandomId];
    task.taskString = item;
    [task debugDump];
    task.taskColor = [self randomColor];
    [self.arrayOfTasks addObject:task];
    [[DataStore sharedInstance] saveData:self.arrayOfTasks withKey:@"tasksArray"];
    
    [self.tableView reloadData];
}
- (void)addTask:(UIButton *)sender {
    self.addTaskTextField.hidden = NO;
    self.friendsLists.hidden = YES;
    [self.addTaskTextField becomeFirstResponder];
    self.addTaskTextField.delegate = self;
}
- (void)friendsButtonFired{
    
    if (!self.friendsController){
    self.friendsController = [[FriendsViewController alloc] init];
    }
    [self.navigationController pushViewController:self.friendsController animated:YES];
    
    //[self.navigationController popViewControllerAnimated:NO];
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
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}




@end
