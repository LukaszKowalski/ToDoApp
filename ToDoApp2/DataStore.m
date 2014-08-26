////
////  DataSource.m
////  ToDoApp2
////
////  Created by Łukasz Kowalski on 8/13/14.
////  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
////
//

#import "DataStore.h"

@implementation DataStore

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init {
    
    if ( (self = [super init])) {
    }
    return self;
}

-(NSArray *)loadData:(NSString *)keyString
{
    NSLog(@"loading data for keyString: %@",keyString);
    NSData *encodedAllData =  [[NSUserDefaults standardUserDefaults] objectForKey:keyString];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:encodedAllData];
    return array;
}

-(void)saveData:(NSArray *)array withKey:(NSString *)keyString
{
    NSLog(@"saving data");
    NSData *encodedArray = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults] setObject:encodedArray forKey:keyString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
