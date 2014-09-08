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
#import "DoUser.h"

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
@property (weak, nonatomic) DoUser *user;

-(void)addItem:(NSString*)item;

@end
