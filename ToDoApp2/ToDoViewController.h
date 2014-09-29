//
//  ToDoViewController.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTaskTableViewCell.h"
#import "FriendsViewController.h"

@interface ToDoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property  (strong, nonatomic) ToDoViewController *delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayOfParseTasks;
@property (strong, nonatomic) UIButton *addTaskButton;
@property (strong, nonatomic) UITextField *addTaskTextField;
@property (strong, nonatomic) UIButton *friendsLists;
@property (strong, nonatomic) UINavigationBar *bar;
@property (strong, nonatomic) UILabel *doSign;
@property (strong, nonatomic) UILabel *cap;

@property (nonatomic, assign) NSInteger swipeSwitch;

-(void)reloadTableView;
-(void)loadArrayOfTasks:(NSMutableArray *)array;
-(void)removeTaskforRowAtIndexPath:(NSIndexPath *)integer;

@end
