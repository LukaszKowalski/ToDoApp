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
#import "SVProgressHUD.h"

@class FriendsToDoViewController;
@class FriendsViewController;


@interface ParseStore : NSObject

+(instancetype)sharedInstance;
-(void)addTask:(NSString *)taskString forNumber:(NSUInteger)number withId:(NSString *)taskId;
-(void)addFriend:(NSString *)username;
-(void)deleteTask:(NSString *)taskString withId:(NSString *)taskId;
-(void)deleteFriend:(NSString *)username;
-(void)loadFriends;
-(void)loadTasks;
-(void)loadTasksForUser:(FriendsToDoViewController *)delegate forUser:(NSString*)username;
-(UIColor *)randomColor;
-(UIColor *)giveColorfromStringColor:(NSString *)colorAsString;
- (void)registerUserForPushNotification;
-(NSDictionary *)whosViewControllerItIs;
-(void)asignWhosViewControllerItIs:(NSDictionary *)user;
-(PFUser *)userFromObjectId:(NSString *)objectId;
-(void)sendNotificationNewTask:(NSDictionary *)user withString:(NSString *)task;
-(void)asignArrayOfTasks:(NSMutableArray *)array;
-(void)addTaskDoTeam:(NSString *)taskString forNumber:(NSUInteger)number;
-(void)addTask:(NSString *)taskString forUser:(NSString *)username withId:(NSString *)taskId;


@property (strong, nonatomic) NSMutableArray *arrayOfColors;
@property (strong, nonatomic) NSDictionary *usersViewController;
@property (strong, nonatomic) NSMutableArray *asignedArrayOfTasks;


@end
