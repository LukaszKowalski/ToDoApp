//
//  ToDoViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "ToDoViewController.h"
#import "DataStore.h"

#import "ParseStore.h"


@interface ToDoViewController ()

@property (strong, nonatomic) FriendsViewController *friendsController;
@property (strong, nonatomic) NSString *dataFilePath;
@property (strong, nonatomic) UIActivityIndicatorView *loginIndicator;



@end

@implementation ToDoViewController



- (void)viewDidLoad
{
    // adding tableView
    
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadTableView" object:nil];
    
    self.navigationItem.hidesBackButton = YES;
    self.title = @"My Tasks";
    self.tableView = [[UITableView alloc] init];
    self.tableView.frame = CGRectMake(0, 75, 320, 410);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.alwaysBounceHorizontal = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc ] init];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
//    // nav bar
//    
//    self.bar = [[UINavigationBar alloc] init];
//    [self.bar setFrame:CGRectMake(0, 20, 320, 44)];
//    self.bar.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:self.bar];
    
    self.cap = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 320, 75)];
    self.cap.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    [self.view addSubview:self.cap];
    // adding button
    
    self.addTaskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addTaskButton.frame = CGRectMake(120, 64, 75, 75);
    self.addTaskButton.titleLabel.font = [UIFont systemFontOfSize:25];
    self.addTaskButton.titleLabel.adjustsLetterSpacingToFitWidth = YES;
    [self.addTaskButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addTaskButton];
    
    // adding TextField
    
    self.addTaskTextField = [[UITextField alloc] initWithFrame:CGRectMake(13, 134, 294, 70)];
    [self.view addSubview:self.addTaskTextField];
    
    // adding friendsList Button
    
    UIImage *btnImage = [UIImage imageNamed:@"IcoFriends.png"];

    
    [self.friendsLists setImage:btnImage forState:UIControlStateNormal];
    self.friendsLists = [UIButton buttonWithType:UIButtonTypeCustom];
    self.friendsLists.frame = CGRectMake(219, 64, 81, 75);
    [self.friendsLists setImage:btnImage forState:UIControlStateNormal];
    self.friendsLists.titleLabel.font = [UIFont systemFontOfSize:25];
    self.friendsLists.backgroundColor = [UIColor clearColor];
    [self.friendsLists addTarget:self action:@selector(friendsButtonFired) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.friendsLists];
    
    // conf button
    
    [self.addTaskButton setTitle:@"+" forState:UIControlStateNormal];
    self.addTaskButton.backgroundColor = [UIColor clearColor];
    self.addTaskButton.titleLabel.font = [UIFont systemFontOfSize:45];
    self.addTaskButton.tag = 1;
    
    // conf textfield
    
    self.addTaskTextField.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.addTaskTextField.textAlignment= NSTextAlignmentCenter;
    self.addTaskTextField.textColor = [UIColor whiteColor];
    self.addTaskTextField.font = [UIFont systemFontOfSize:28];
    self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type your task"];
    self.addTaskTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.addTaskTextField.hidden = YES;
    
    if ([[PFUser currentUser] objectForKey:@"color" ] == nil) {
        UIColor *color = [[ParseStore sharedInstance] randomColor];
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
        [PFUser currentUser][@"color"] = colorAsString;
        [[PFUser currentUser] saveInBackground];
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    // initArray
    
    [self reloadTableView];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)reloadTableView{

    [[ParseStore sharedInstance] loadTasks:self];
    self.delegate = self;

}

-(void)loadArrayOfTasks:(NSMutableArray *)array {
    self.arrayOfParseTasks = array;
    [self.tableView reloadData];
}
-(void)removeTaskforRowAtIndexPath:(NSIndexPath *)integer{
        
    [self.arrayOfParseTasks removeObjectAtIndex:[integer row]];
    [self.tableView reloadData];
    }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.arrayOfParseTasks count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NewTaskTableViewCell *cell = (NewTaskTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newItem"];
    
    if (cell == nil) {
        cell = [[NewTaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newItem"];
    }
    
    PFObject *task = [self.arrayOfParseTasks objectAtIndex:indexPath.row];
    cell.viewController = self;
    cell.delegate = self; 
    NSString *colorInString = [task objectForKey:@"color"];
    cell.newestTask.backgroundColor = [[ParseStore sharedInstance] giveColorfromStringColor:colorInString];
    cell.newestTask.text =   [task objectForKey:@"taskString"];
    cell.newestTask.textAlignment = NSTextAlignmentCenter;
    cell.whoAddedTask.text = [task objectForKey:@"principal"];
    cell.whoAddedTask.textAlignment = NSTextAlignmentCenter;
    cell.whoAddedTask.textColor = cell.newestTask.backgroundColor;
    return cell;
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
//    UITableViewCell *customcell = [self.tableView cellForRowAtIndexPath:indexPath];
//    
//    UIButton *done = (UIButton *)[customcell viewWithTag:10000];
//    [done setHidden:NO];
//    UIButton *no = (UIButton *)[customcell viewWithTag:10001];
//    [no setHidden:NO];
//    
//    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (void)addTask:(UIButton *)sender {
    
    if (self.addTaskButton.tag == 1) {
        
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView setFrame:CGRectMake(0, 140, 320, 410)];
        [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];
        
    } completion:^(BOOL finished) {
   
        self.addTaskTextField.hidden = NO;
        self.addTaskTextField.backgroundColor = [[ParseStore sharedInstance] randomColor];
    }];
    [self.addTaskTextField becomeFirstResponder];
    self.addTaskTextField.delegate = self;
    self.addTaskButton.tag = 2;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.addTaskTextField.hidden = YES;
            [self.tableView setFrame:CGRectMake(0, 75, 320, 410)];
            [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];
            }];
        [self.addTaskTextField resignFirstResponder];
        self.addTaskButton.tag = 1;
    }
    
}
- (void)friendsButtonFired{
    
    if (!self.friendsController){
    self.friendsController = [[FriendsViewController alloc] init];
    }
    [self.navigationController pushViewController:self.friendsController animated:YES];

}
- (void)addTaskFiredAgain{
    
    
    [UIView animateWithDuration:0.3 animations:^{
         self.addTaskTextField.hidden = YES;
        [self.tableView setFrame:CGRectMake(0, 75, 320, 410)];
        [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];
        [self.addTaskButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self.addTaskTextField resignFirstResponder];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *newTask = textField.text;
    textField.text = @"";
    [self.addTaskTextField resignFirstResponder];
    
    self.friendsLists.hidden = NO;
    [[ParseStore sharedInstance] addTask:newTask];
    [UIView animateWithDuration:0.3 animations:^{
        self.addTaskTextField.hidden = YES;
        [self.tableView setFrame:CGRectMake(0, 75, 320, 410)];
        [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];
    }];
    [self.addTaskTextField resignFirstResponder];
    self.addTaskButton.tag = 1;

    [self reloadTableView];
    
    
    return YES;
}


@end
