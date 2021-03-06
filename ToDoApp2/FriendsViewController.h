//
//  FriendsViewController.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/6/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoAppDelegate.h"
#import "FriendsTableViewCell.h"
#import "FriendsToDoViewController.h"
#import "ParseStore.h"
#import "SettingsViewController.h"

@interface FriendsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *friendsTableView;
@property (strong, nonatomic) UIButton *addFriendButton;
@property (strong, nonatomic) UITextField *addTaskTextField;
@property (strong, nonatomic) NSMutableArray *arrayOfFriends;
@property (strong, nonatomic) FriendsViewController *delegate;
@property (strong, nonatomic) UIButton *backButton;
@property (strong, nonatomic) UILabel *cap;
@property (strong, nonatomic) UIButton *confirmButton;
@property (strong, nonatomic) UIActivityIndicatorView *goToFriendsToDo;
@property (strong, nonatomic) UIButton *settings;
@property (strong, nonatomic) UIImageView *imageView;
-(void)reloadTableView;
-(void)loadArrayOfFriends:(NSMutableArray *)array;

@end
