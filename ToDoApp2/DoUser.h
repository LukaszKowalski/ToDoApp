//
//  DoUser.h
//  ToDo3
//
//  Created by Łukasz Kowalski on 8/19/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DoTask;

@interface DoUser : NSObject

@property (nonatomic, strong) NSString* userIdNumber;
@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSMutableArray* friendsArray;
@property (nonatomic, strong) DoTask *arrayofTasks;

@end
