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

@interface ParseStore : NSObject

+(instancetype)sharedInstance;
-(void)addTask:(NSString *)taskString;
-(void)addFriend:(NSString *)username;
-(void)deleteTask:(NSString *)taskString;
-(void)deleteFriend:(NSString *)username;
-(void)loadTasks:(ToDoViewController *)delegate;

@end
