//
//  DoTask.h
//  ToDo3
//
//  Created by Łukasz Kowalski on 8/19/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoTask : NSObject <NSCoding>

-(void)debugDump;

@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *userIdNumber;
@property (nonatomic, strong) NSString *taskString;
//@property (nonatomic, strong) UIColor *taskColor;

@end
