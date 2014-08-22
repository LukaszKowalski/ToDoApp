//
//  DoUser.m
//  ToDo3
//
//  Created by Łukasz Kowalski on 8/19/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "DoUser.h"

@implementation DoUser

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.userIdNumber = [decoder decodeObjectForKey:@"userIdNumber"];
        self.username = [decoder decodeObjectForKey:@"username"];
        self.userColor = [decoder decodeObjectForKey:@"userColor"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.userIdNumber forKey:@"userIdNumber"];
    [encoder encodeObject:self.username forKey:@"username"];
    [encoder encodeObject:self.userColor forKey:@"userColor"];
}

-(void)debugDump
{
    NSLog(@"User userIdNumber: %@",self.userIdNumber);
    NSLog(@"User username: %@",self.username);
}

@end
