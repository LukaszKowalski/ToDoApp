//
//  DoTask.h
//  ToDo3
//
//  Created by Łukasz Kowalski on 8/19/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DoUser;

@interface DoTask : NSObject

@property (nonatomic, strong) NSString* idNumber;
@property (nonatomic, strong) NSString* taskString;
@property (nonatomic, strong) DoUser* user;

@end
