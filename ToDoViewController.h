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
@property (strong, nonatomic) NSMutableArray *arrayOfTasks;
@property (strong, nonatomic) UIButton *addTaskButton;
@property (strong, nonatomic) UITextField *addTaskTextField;
@property (strong, nonatomic) UIButton *friendsLists;
@property (strong, nonatomic) UINavigationBar *bar;

-(void)addItem:(NSString*)item;

@end
