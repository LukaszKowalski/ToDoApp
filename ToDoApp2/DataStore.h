//
//  DataSource.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/13/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DoTask.h"
#import "DoUser.h"

@interface DataStore : NSObject

+(instancetype)sharedInstance;

-(void)loadData:(NSString *)keyString;
-(void)saveData:(NSArray *)array withKey:(NSString *)keyString;

-(void)addTask:(NSString *)taskString;
-(void)deleteTask:(DoTask *)task;

-(void)loadFriends:(NSString *)keyString;
-(void)addFriend:(NSString *)item;

-(DoUser *)findFriendByID:(NSString *)idNumber;

-(void)addUser:(NSString *)username;
-(void)deleteUser:(DoUser *)user;
-(void)loadUserTasks:(NSString *)keyString;
-(void)addTaskForUser:(DoUser *)user item:(NSString *)item;

@property (strong, nonatomic) NSMutableArray *arrayOfTasks;
@property (strong, nonatomic) NSMutableArray *arrayOfFriends;
@property (strong, nonatomic) NSMutableArray *arrayOfUsers;



@end
