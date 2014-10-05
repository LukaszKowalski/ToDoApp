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
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadSomeoneTableView" object:nil];
    
    
    [super viewDidLoad];
    self.title =[NSString stringWithFormat:@"%@'s list", self.titleName];
    self.navigationItem.hidesBackButton = YES;
    self.tableView = [[UITableView alloc] init];
    CGSize viewSize = self.view.frame.size;
    self.tableView.frame = CGRectMake(13, 75, viewSize.width -26, viewSize.height -73);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc ] init];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    // nav bar
    
    self.cap = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, 320, 75)];
    self.cap.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    [self.view addSubview:self.cap];

    
    // adding button
    
    self.addTaskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addTaskButton.frame = CGRectMake(120, 64, 75, 75);
    UIImage *plusImage = [UIImage imageNamed:@"IcoPlus.png"];
    [self.addTaskButton setImage:plusImage forState:UIControlStateNormal];
    [self.addTaskButton addTarget:self action:@selector(addTask:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addTaskButton];
    
    // adding TextField
    
    self.addTaskTextField = [[UITextField alloc] initWithFrame:CGRectMake(13, 134, 294, 70)];
    [self.view addSubview:self.addTaskTextField];
    
    // adding friendsList Button
    
    self.friendsLists = [UIButton buttonWithType:UIButtonTypeCustom];

    UIImage *btnImage = [UIImage imageNamed:@"IcoFriends.png"];
    
    [self.friendsLists setImage:btnImage forState:UIControlStateNormal];
    self.friendsLists.frame = CGRectMake(219, 64, 81, 75);
    self.friendsLists.backgroundColor = [UIColor clearColor];
    [self.friendsLists addTarget:self action:@selector(friendsButtonFired) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.friendsLists];
    
    // conf button
    
    self.addTaskButton.backgroundColor = [UIColor clearColor];
    self.addTaskButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    // conf textfield
    
    self.addTaskTextField.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.addTaskTextField.textAlignment= NSTextAlignmentCenter;
    self.addTaskTextField.textColor = [[ParseStore sharedInstance] randomColor];
    self.addTaskTextField.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type task for %@", self.titleName];
    self.addTaskTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.addTaskTextField.hidden = YES;
    
    // confirmButton
    
    UIImage *confirmImage = [UIImage imageNamed:@"IcoCheck.png"];
    
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setImage:confirmImage forState:UIControlStateNormal];
    self.confirmButton.frame = CGRectMake(20, 64, 81, 75);
    self.confirmButton.backgroundColor = [UIColor clearColor];
    [self.confirmButton addTarget:self action:@selector(confirmTask) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];
    self.confirmButton.hidden = YES;
    
    self.addTaskButton.tag = 1;
    
    // initArray
    
    
    
    [self reloadTableView];
    self.delegate = self;
    
}
- (void)reloadTableView{
    
    self.delegate = self;
    [[ParseStore sharedInstance] loadTasksForUser:self forUser:[NSString stringWithFormat:@"%@", self.titleName]];
    
    [self.tableView reloadData];
    [SVProgressHUD dismiss];

    
}
-(void)loadArrayOfTaskss:(NSMutableArray *)array {
    
   // NSMutableArray* reversed = [[array reverseObjectEnumerator] allObjects];
    self.arrayOfUserTasks = array;
    NSLog(@"Jak wyglada array %@", array);
    [self.tableView reloadData];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrayOfUserTasks.count;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FriendsToDoTableViewCell *cell = (FriendsToDoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"newTaskForFriend"];
    
    if (cell == nil) {
        cell = [[FriendsToDoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"newTaskForFriend"];
    }
    // init Label
    
    PFObject *task  = [self.arrayOfUserTasks objectAtIndex:indexPath.row];
    NSString *colorInString = [task objectForKey:@"color"];
    cell.taskForFriend.backgroundColor = [[ParseStore sharedInstance] giveColorfromStringColor:colorInString];
    cell.taskForFriend.text = [task objectForKey:@"taskString"];
    
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
    
    self.objectId = [[ParseStore sharedInstance] whosViewControllerItIs];
    NSString *username = [self.objectId objectForKey:@"username"];
    
    PFQuery *userQuery=[PFUser query];
    [userQuery whereKey:@"username" equalTo:username];

    // send push notification to the user
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"Owner" matchesQuery:userQuery];

    PFPush *push = [PFPush new];
    [push setQuery: pushQuery];
    PFObject *task  = [self.arrayOfUserTasks objectAtIndex:indexPath.row];
    NSString *message= [NSString stringWithFormat:@"%@ przypomina Ci o %@",[PFUser currentUser].username ,[task objectForKey:@"taskString"]];
    [push setData: @{ @"alert":message}];
    [push sendPushInBackground];

    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(void)addItem:(NSString *)item {
    
     dispatch_async(dispatch_get_main_queue(),^{
         [SVProgressHUD showWithStatus:@"Adding Task"];
    self.objectId = [[ParseStore sharedInstance] whosViewControllerItIs];
    [[ParseStore sharedInstance] addTask:item forUser:[NSString stringWithFormat:@"%@", self.titleName]];
    [[ParseStore sharedInstance] sendNotificationNewTask:self.objectId withString:item];
     });
}
- (void)addTask:(UIButton *)sender {
    
    if (self.addTaskButton.tag == 1) {
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:0.3 animations:^{
            [self.tableView setFrame:CGRectMake(13, 140, 294, 410)];
            [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];
        } completion:^(BOOL finished) {
            self.confirmButton.hidden = NO;
            self.addTaskTextField.hidden = NO;
            self.addTaskTextField.backgroundColor = [UIColor whiteColor];
        }];
        [self.addTaskTextField becomeFirstResponder];
        self.addTaskTextField.delegate = self;
        self.addTaskButton.tag = 2;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.tableView setFrame:CGRectMake(13, 75, 294, 410)];
            [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];
        }];
        self.addTaskTextField.hidden = YES;
        [self.addTaskTextField resignFirstResponder];
        self.addTaskButton.tag = 1;
        self.confirmButton.hidden = YES;
    }
    
    self.addTaskTextField.delegate = self;
}
- (void)friendsButtonFired{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

// potwierdzanie taska

- (void) confirmTask{
    
    [SVProgressHUD showWithStatus:@"Adding Task..."];
    [self textFieldShouldReturn:self.addTaskTextField];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *newTask = textField.text;
    
    textField.text = @"";
    [self.delegate addItem:newTask];
    
    [self.addTaskTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.addTaskTextField.hidden = YES;
        [self.tableView setFrame:CGRectMake(13, 75, 294, 410)];
        [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];
    }];
    [self.addTaskTextField resignFirstResponder];
    self.addTaskButton.tag = 1;
    self.confirmButton.hidden = YES;
    
    
    
    [self.addTaskTextField resignFirstResponder];
    self.addTaskTextField.hidden = YES;
    self.friendsLists.hidden = NO;
        
    
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}




@end
