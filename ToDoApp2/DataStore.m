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
    self.arrayOfTasks = [NSKeyedUnarchiver unarchiveObjectWithData:encodedAllData];
    return self.arrayOfTasks;
}

-(void)saveData:(NSArray *)array withKey:(NSString *)keyString
{
    NSLog(@"saving data");
    NSData *encodedArray = [NSKeyedArchiver archivedDataWithRootObject:array];
    [[NSUserDefaults standardUserDefaults] setObject:encodedArray forKey:keyString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)deleteTask:(DoTask *)task{
    
        NSMutableArray *discardedItems = [NSMutableArray array];
    
    DoTask *item;
    
    for (item in self.arrayOfTasks) {
        if ([item.idNumber isEqualToString:task.idNumber]){
            [discardedItems addObject:item];
        }
    }
    [self.arrayOfTasks removeObjectsInArray:discardedItems];
    [self saveData:self.arrayOfTasks withKey:@"tasksArray"];
}
-(void)addTask:(NSString *)item {
    
   
    NSLog(@"%@", item);
    DoTask *task = [DoTask new];
    task.idNumber = [self getRandomId];
    task.taskString = item;
    task.taskColor = [self randomColor];
    [self.arrayOfTasks addObject:task];
    [[DataStore sharedInstance] saveData:self.arrayOfTasks withKey:@"tasksArray"];
    [task debugDump];
    
}
-(DoTask *)findTaskByID:(NSString *)idNumber{
   
    for (DoTask *task in self.arrayOfTasks){
        if ([task.idNumber isEqualToString:idNumber]){
            return task;
        }
    }return nil;
}

-(NSString *)getRandomId
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    return uuidString;
}
-(UIColor *)randomColor{
    CGFloat red = arc4random() % 255 / 255.0;
    CGFloat blue = arc4random() % 255 / 255.0;
    CGFloat green = arc4random() % 255 / 255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}


@end
