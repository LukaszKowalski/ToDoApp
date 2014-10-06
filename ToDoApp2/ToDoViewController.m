//
//  ToDoViewController.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "ToDoViewController.h"
#import "DataStore.h"
#import "RSMaskedLabel.h"
#import "ParseStore.h"


@interface ToDoViewController ()

@property (strong, nonatomic) FriendsViewController *friendsController;
@property (strong, nonatomic) NSString *dataFilePath;
@property (strong, nonatomic) UIActivityIndicatorView *loginIndicator;
@property (strong, nonatomic) SettingsViewController* settingsViewController;



@end

@implementation ToDoViewController

- (void)viewDidLoad
{
    // adding tableView
    
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView) name:@"reloadTaskTableView" object:nil];
    
    self.navigationItem.hidesBackButton = YES;
    self.tableView = [[UITableView alloc] init];
    CGSize viewSize = self.view.frame.size;
    self.tableView.frame = CGRectMake(0, 75,320, viewSize.height -73);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.alwaysBounceHorizontal = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc ] init];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    // Rainbow Sign
    
    CATextLayer *textLayer = [[CATextLayer alloc] init];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    NSMutableDictionary *textProperties = [NSMutableDictionary dictionary];
    textProperties[NSFontAttributeName] = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"My Tasks", nil)
                                                                           attributes:textProperties];
    textLayer.string = attributedString;
    textLayer.frame = self.view.bounds;
    
    UIImage *rainbowImage = [UIImage imageNamed:@"Rainbow"];
    self.imageView = [[UIImageView alloc] initWithImage:rainbowImage];
    self.imageView.layer.mask = textLayer;
    
    self.imageView.frame = CGRectMake(125,26,320,40);
    [self.view addSubview: self.imageView];

    
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
    
    self.addTaskTextField = [[UITextField alloc] initWithFrame:CGRectMake(13, 139, 294, 66)];
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
    
    UIImage *plusImage = [UIImage imageNamed:@"IcoPlus.png"];
    [self.addTaskButton setImage:plusImage forState:UIControlStateNormal];
    self.addTaskButton.backgroundColor = [UIColor clearColor];
    self.addTaskButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:40];
    self.addTaskButton.tag = 1;
    
    // conf textfield
    
    self.addTaskTextField.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
    self.addTaskTextField.textAlignment= NSTextAlignmentCenter;
    self.addTaskTextField.textColor = [[ParseStore   sharedInstance] randomColor];
    self.addTaskTextField.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type your task"];
    self.addTaskTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.addTaskTextField.hidden = YES;
    self.addTaskTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    if ([[PFUser currentUser] objectForKey:@"color" ] == nil) {
        UIColor *color = [[ParseStore sharedInstance] randomColor];
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
        [PFUser currentUser][@"color"] = colorAsString;
        [[PFUser currentUser] saveInBackground];
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    // confirmButton
    
    UIImage *confirmImage = [UIImage imageNamed:@"IcoCheck.png"];
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setImage:confirmImage forState:UIControlStateNormal];
    self.confirmButton.frame = CGRectMake(20, 64, 81, 75);
    self.confirmButton.backgroundColor = [UIColor clearColor];
    [self.confirmButton addTarget:self action:@selector(confirmTask) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];
    self.confirmButton.hidden = YES;

    [UIView transitionWithView:self.addTaskTextField
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    // settingsButton
    
    UIImage *settingsImage = [UIImage imageNamed:@"IcoSettings.png"];
    self.settings = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settings setImage:settingsImage forState:UIControlStateNormal];
    self.settings.frame = CGRectMake(20, 64, 81, 75);
    self.settings.backgroundColor = [UIColor clearColor];
    [self.settings addTarget:self action:@selector(goToSettings) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settings];
    self.settings.hidden = NO;
    
//    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(60,10,320,40)];
//    navView.backgroundColor = [UIColor clearColor];
//    
//    RSMaskedLabel *label = [[RSMaskedLabel alloc] initWithFrame:navView.frame];
//    label.text =@"My Tasks";
//    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
//
//    [navView addSubview:label];
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:navView.frame];
//    [imgView setImage:[UIImage imageNamed:@"rainbow"]];
//    
//    [navView addSubview:imgView];
//    [navView addSubview:label];
//    [self.view addSubview:navView];
    

    // initArray
    
    [self reloadTableView];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)reloadTableView{
    
    self.arrayOfParseTasks = [[DataStore sharedInstance] loadData:@"tasksArrayLocally"];
    NSLog(@" %d", [self.arrayOfParseTasks count]);
    
    if ([self.arrayOfParseTasks count] == 0) {
        
        self.arrayOfParseTasks = @[
                         @{@"color": @"0.603922,0.831373,0.419608,1.000000", @"principal": @"DoTeam",
                         @"taskString": @"Hi, welcome in \"Do\" ;)", @"taskUsernameId": @"asdfasdfas"},
    @{@"color": @"1.000000,0.792157,0.368627,1.000000", @"principal": @"DoTeam",
      @"taskString": @"Swipe right to delete task", @"taskUsernameId": @"asdfasdfas"},
    @{@"color": @"0.396078,0.752941,0.772549,1.000000", @"principal": @"DoTeam",
      @"taskString": @"Swipe left, find who gave you \"do\"", @"taskUsernameId": @"asdfasdfas"}];
    
    };
    
    self.delegate = self;
//    [[[self.arrayOfParseTasks reverseObjectEnumerator] allObjects] mutableCopy];
    [self.tableView reloadData];

}

-(void)loadArrayOfTasks:(NSMutableArray *)array {
//   
////    self.arrayOfParseTasks = [[DataStore sharedInstance] changeArray:array];
//    self.arrayOfParseTasks = array;
//    [[self.arrayOfParseTasks reverseObjectEnumerator] allObjects];
//
////    [[DataStore sharedInstance] saveData:self.arrayOfParseTasks withKey:@"friendsArrayLocally"];
//    [self.tableView reloadData];
}

-(void)removeTaskforRowAtIndexPath:(NSIndexPath *)integer{
    
    [self.arrayOfParseTasks removeObjectAtIndex:[integer row]];
    
    //    PFObject* taskTodelete = [self.arrayOfParseTasks objectAtIndex:[integer row]];
    //    NSString*taskStringToDelete = [taskTodelete objectForKey:@"taskString"];
    //    [[ParseStore sharedInstance] deleteTask:taskStringToDelete];

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
    return 66;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    
}


- (void)addTask:(UIButton *)sender {
    
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    
    if (self.addTaskButton.tag == 1) {
        
        self.addTaskTextField.alpha = 1;
        self.addTaskTextField.placeholder = [NSString stringWithFormat:@"Type your task"];

    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGSize viewSize = self.view.frame.size;

        [self.tableView setFrame:CGRectMake(0, 140, 320, viewSize.height -73)];
        [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];
        
    } completion:^(BOOL finished) {
        
        self.settings.hidden = YES;
        self.confirmButton.hidden = NO;
        self.addTaskTextField.hidden = NO;
        self.addTaskTextField.backgroundColor = [UIColor whiteColor];
    }];
    [self.addTaskTextField becomeFirstResponder];
    self.addTaskTextField.delegate = self;
    self.addTaskButton.tag = 2;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            CGSize viewSize = self.view.frame.size;

            self.addTaskTextField.hidden = YES;
            [self.tableView setFrame:CGRectMake(0, 75, 320, viewSize.height -73)];
            [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];
            }];
        
        self.confirmButton.hidden = YES;
        self.settings.hidden = NO;
        [self.addTaskTextField resignFirstResponder];
        self.addTaskButton.tag = 1;
    }
    
}
- (void)friendsButtonFired{
    
    if (!self.friendsController){
    self.friendsController = [[FriendsViewController alloc] init];
    }
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self.navigationController pushViewController:self.friendsController animated:NO];

}
- (void) goToSettings{
    
    if (!self.settingsViewController){
        self.settingsViewController = [[SettingsViewController alloc] init];
    }
    [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    [self.navigationController pushViewController:self.settingsViewController animated:NO];

    
}

// potwierdzanie taska

- (void) confirmTask{

    [self textFieldShouldReturn:self.addTaskTextField];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *newTask = textField.text;
    textField.text = @"";
    [self.addTaskTextField resignFirstResponder];
    self.friendsLists.hidden = NO;
    
    [[ParseStore sharedInstance] addTask:newTask];
    
    PFObject *task = [[DataStore sharedInstance] createTaskLocally:newTask];
    [[DataStore sharedInstance] addTask:task];
    [UIView animateWithDuration:0.6 animations:^{
        self.addTaskTextField.alpha = 0;
        self.addTaskTextField.placeholder = [NSString stringWithFormat:@"%@", newTask];
        [self.addTaskButton setTransform:CGAffineTransformRotate(self.addTaskButton.transform, M_PI/4)];

    } completion: ^(BOOL finished) {
        
        self.addTaskTextField.hidden = finished;
    }];
    self.confirmButton.hidden = YES;
    self.settings.hidden = NO;
    CGSize viewSize = self.view.frame.size;
    [self.tableView setFrame:CGRectMake(0, 75, 320, viewSize.height -73)];
    [self.addTaskTextField resignFirstResponder];
    self.addTaskButton.tag = 1;
    self.confirmButton.hidden = YES;
    self.settings.hidden = NO;
    [self reloadTableView];
    
    return YES;
}



@end
