//
//  ToDoAppDelegate.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoViewController.h"
#import "FriendsViewController.h"
#import <Parse/Parse.h>
#include "LoginViewController.h"
#import <MessageUI/MessageUI.h>

@interface ToDoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) ToDoViewController *toDo;
@property (strong, nonatomic) ToDoViewController *toDoViewController;


@end
