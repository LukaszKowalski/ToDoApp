//
//  DataSource.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/13/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
#import <Parse/Parse.h>

@interface DataStore : NSObject

+(instancetype)sharedInstance;

-(NSMutableArray *)loadData:(NSString *)keyString;
-(void)saveData:(NSMutableArray *)myDictionary withKey:(NSString *)keyString;
-(NSMutableArray *)loadFriends:(NSString *)keyString;
-(void)addFriend:(PFUser *)friend;
-(void)addTask:(PFObject*)task;
-(NSDictionary *)changeData:(PFObject*)object;
-(PFObject *)createTaskLocally:(NSString *)taskString withId:(NSString *)taskId;
-(void)saveUser:(NSDictionary *)myDictionary withKey:(NSString *)keyString;
-(void)changeUserData:(PFObject*)object;
-(NSMutableDictionary *)changeTaskData:(PFObject *)object;
- (NSMutableArray *)changeArrayOfParseObjects:(NSMutableArray *)array;
-(UIColor *)randomColor:(NSUInteger )item;

@property (strong, nonatomic) NSMutableArray *arrayOfFriendsLocally;
@property (strong, nonatomic) NSMutableArray *arrayOfTasksLocally;
@property (strong, nonatomic) NSMutableArray *arrayOfColorsToPick;

@end
