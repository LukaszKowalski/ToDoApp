//
//  DataSource.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/13/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Parse/Parse.h>

@interface DataStore : NSObject

+(instancetype)sharedInstance;

-(NSMutableArray *)loadData:(NSString *)keyString;
-(void)saveData:(NSMutableArray *)myDictionary withKey:(NSString *)keyString;
-(NSMutableArray *)loadFriends:(NSString *)keyString;
-(void)addFriend:(PFUser *)friend;
-(void)addTask:(PFObject*)task;
-(NSDictionary *)changeData:(PFObject*)object;
-(PFObject *)createTaskLocally:(NSString *)taskString;
-(void)saveUser:(NSDictionary *)myDictionary withKey:(NSString *)keyString;
-(void)changeUserData:(PFObject*)object;


@property (strong, nonatomic) NSMutableArray *arrayOfFriendsLocally;
@property (strong, nonatomic) NSMutableArray *arrayOfTasksLocally;
@property (strong, nonatomic) NSMutableArray *arrayOfColorsToPick;

@end
