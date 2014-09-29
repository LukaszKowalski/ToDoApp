//
//  FriendsToDoViewController.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/9/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsTableViewCell.h"
#import "DataStore.h"
#import "ParseStore.h"

@interface FriendsToDoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property  (strong, nonatomic) FriendsToDoViewController *delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayOfFriendsTask;
@property (strong, nonatomic) UIButton *addTaskButton;
@property (strong, nonatomic) UITextField *addTaskTextField;
@property (strong, nonatomic) UIButton *friendsLists;
@property (strong, nonatomic) UINavigationBar *bar;
@property (strong, nonatomic) NSString *titleName;
@property (strong, nonatomic) UILabel *taskForFriend;

@property (strong, nonatomic) NSMutableArray *arrayOfUserTasks;
@property (strong, nonatomic) PFUser *friendsToDoList;
@property (strong, nonatomic) NSDictionary *objectId;

-(void)addItem:(NSString*)item;
-(void)loadArrayOfTaskss:(NSMutableArray *)array;

@end
