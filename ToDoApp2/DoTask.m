//
//  DoTask.m
//  ToDo3
//
//  Created by Łukasz Kowalski on 8/19/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "DoTask.h"

@implementation DoTask

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.userIdNumber = [decoder decodeObjectForKey:@"userIdName"];
        self.idNumber = [decoder decodeObjectForKey:@"IdNumber"];
        self.taskString = [decoder decodeObjectForKey:@"taskString"];
        self.taskColor = [decoder decodeObjectForKey:@"taskColor"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.userIdNumber forKey:@"userIdName"];
    [encoder encodeObject:self.idNumber forKey:@"IdNumber"];
    [encoder encodeObject:self.taskString forKey:@"taskString"];
    [encoder encodeObject:self.taskColor forKey:@"taskColor"];
}

-(void)debugDump
{
    NSLog(@"Task IdNumber: %@",self.idNumber);
    NSLog(@"Task userIdNumber: %@",self.userIdNumber);
    NSLog(@"Task taskString: %@",self.taskString);
    NSLog(@"Task color: %@", self.taskColor);
}

@end
