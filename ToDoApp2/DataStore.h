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

 +(instancetype) sharedInstance;

-(void)loadData:(NSString *)keyString;
-(void)saveData:(NSArray *)array withKey:(NSString *)keyString;
-(void)deleteTask:(DoTask *)task;
-(void)addTask:(NSString *)item;
-(void)deleteUser:(DoUser *)user;
-(void)loadFriends:(NSString *)keyString;
-(void)addFriend:(NSString *)item;
-(DoUser *)findFriendByID:(NSString *)idNumber;
-(void)addTaskForUser:(DoUser *)user item:(NSString *)item;
//-(void)loadUserTasks:(NSString *)keyString;
-(void)addUser:(NSString *)item;

@property (strong, nonatomic) NSMutableArray *arrayOfUsers;
@property (strong, nonatomic) NSMutableArray *arrayOfFriends;
@property (strong, nonatomic) NSMutableArray *arrayOfTasks;



@end
