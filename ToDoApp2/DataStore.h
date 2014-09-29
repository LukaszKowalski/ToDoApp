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

-(void)loadData:(NSString *)keyString;
-(void)saveData:(NSData *)myDictionary withKey:(NSString *)keyString;

-(NSMutableArray *)loadFriends:(NSString *)keyString;
-(void)addFriend:(PFUser *)friend;

@property (strong, nonatomic) NSMutableArray *arrayOfUsers;
@property (strong, nonatomic) NSMutableArray *arrayOfFriends;
@property (strong, nonatomic) NSMutableArray *arrayOfTasks;


@end
