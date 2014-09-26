//
//  ParseStore.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 9/10/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "ToDoViewController.h"

@class FriendsToDoViewController;
@class FriendsViewController;


@interface ParseStore : NSObject

+(instancetype)sharedInstance;
-(void)addTask:(NSString *)taskString;
-(void)addFriend:(NSString *)username;
-(void)deleteTask:(NSString *)taskString;
-(void)deleteFriend:(NSString *)username;
-(void)loadFriends:(FriendsViewController *)delegate withObjectId:(NSString *)objectID;
-(void)loadTasks:(ToDoViewController *)delegate;
-(void)loadTasksForUser:(FriendsToDoViewController *)delegate forUser:(NSString*)username;
-(void)addTask:(NSString *)taskString forUser:(NSString *)username;
-(UIColor *)randomColor;
-(UIColor *)giveColorfromStringColor:(NSString *)colorAsString;
- (void)registerUserForPushNotification;
-(PFUser *)whosViewControllerItIs;
-(void)asignWhosViewControllerItIs:(PFUser *)user;
-(PFUser *)userFromObjectId:(NSString *)objectId;

@property (strong, nonatomic) PFUser *usersViewController;

@end
