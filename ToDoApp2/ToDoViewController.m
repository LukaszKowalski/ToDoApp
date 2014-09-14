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
#import "ParseStore.h"

@interface ToDoViewController ()

@property (strong, nonatomic) FriendsViewController *friendsController;
@property (strong, nonatomic) NSString *dataFilePath;



@end

@implementation ToDoViewController



- (void)viewDidLoad
{
    // adding tableView
    
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadTableView" object:nil];
    
    //self.navigationItem.hidesBackButton = YES;
    self.title = @"My \"Do\" list";
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 75, 320, 410);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc ] init];
    
//    // nav bar
//    
//    self.bar = [[UINavigationBar alloc] init];
//    [self.bar setFrame:CGRectMake(0, 20, 320, 44)];
//    self.bar.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:self.bar];
    
    // adding button
    
    self.addTaskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addTaskButton.frame = CGRectMake(0, 64, 159, 75);
    self.addTaskButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [self.addTaskButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addTaskButton];
    
    // adding TextField
    
    self.addTaskTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 64, 320, 75)];
    [self.view addSubview:self.addTaskTextField];
    
    // adding friendsList Button
    
    self.friendsLists = [UIButton buttonWithType:UIButtonTypeCustom];
    self.friendsLists.frame = CGRectMake(159, 64, 161, 75);
    [self.friendsLists setTitle:@"Friends list" forState:UIControlStateNormal];
    self.friendsLists.titleLabel.font = [UIFont systemFontOfSize:25];
    self.friendsLists.backgroundColor = [UIColor colorWithRed:255/255.0f green:90/255.0f blue:0/255.0f alpha:1];
    [self.friendsLists addTarget:self action:@selector(friendsButtonFired) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.friendsLists];
    
    // conf button
    
    [self.addTaskButton setTitle:@"+" forState:UIControlStateNormal];
    self.addTaskButton.backgroundColor = [UIColor colorWithRed:255/255.0f green:114/255.0f blue:0/255.0f alpha:1];
    self.addTaskButton.titleLabel.font = [UIFont systemFontOfSize:45];
    
    // conf textfield
    
    self.addTaskTextField.backgroundColor = [UIColor colorWithRed:255/255.0f green:114/255.0f blue:0/255.0f alpha:1];
    self.addTaskTextField.textAlignment= NSTextAlignmentCenter;
    self.addTaskTextField.textColor = [UIColor whiteColor];
    self.addTaskTextField.font = [UIFont systemFontOfSize:28];
    self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type your task"];
    self.addTaskTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.addTaskTextField.hidden = YES;
    
    // initArray
    
    [self reloadTableView];
    
}

- (void)reloadTableView{
    
//    [[DataStore sharedInstance] loadData:@"tasksArray"];
    
    [[ParseStore sharedInstance] loadTasks:self];
    self.delegate = self;
    [self.tableView reloadData];
}

-(void)loadArrayOfTasks:(NSMutableArray *)array {
    self.arrayOfParseTasks = array;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

//    return [[[DataStore sharedInstance] arrayOfTasks] count];
    return [self.arrayOfParseTasks count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NewTaskTableViewCell *cell = (NewTaskTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newItem"];
    
    if (cell == nil) {
        cell = [[NewTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newItem"];
    }
    
    PFObject *task = [self.arrayOfParseTasks objectAtIndex:indexPath.row];
//    DoTask *task = [[[DataStore sharedInstance] arrayOfTasks] objectAtIndex:indexPath.row];
    cell.viewController = self;
    cell.newestTask.backgroundColor = [self randomColor];

    cell.newestTask.text =  [task objectForKey:@"taskString"];
    NSLog(@"%@", cell.newestTask.text);

    cell.newestTask.textAlignment = NSTextAlignmentCenter;
//    cell.task = task;
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
    
    NSLog(@"%ld", (long)indexPath.row);
    UITableViewCell *customcell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@", customcell.subviews);
    
    UIButton *done = (UIButton *)[customcell viewWithTag:10000];
    [done setHidden:NO];
    UIButton *no = (UIButton *)[customcell viewWithTag:10001];
    [no setHidden:NO];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

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
   
//    [[DataStore sharedInstance] addTask:newTask];
    textField.text = @"";
    [self.addTaskTextField resignFirstResponder];
    self.addTaskTextField.hidden = YES;
    self.friendsLists.hidden = NO;
    [[ParseStore sharedInstance] addTask:newTask];
    [self reloadTableView];
    return YES;
}
-(UIColor *)randomColor{
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
