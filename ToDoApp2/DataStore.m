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

-(void)loadData:(NSString *)keyString
{
    NSLog(@"loading data for keyString: %@",keyString);
    NSData *encodedAllData =  [[NSUserDefaults standardUserDefaults] objectForKey:keyString];
    self.arrayOfTasks = [NSKeyedUnarchiver unarchiveObjectWithData:encodedAllData];
    if (self.arrayOfTasks == nil) {
        self.arrayOfTasks = [NSMutableArray new];
    }
    
}
-(void)loadFriends:(NSString *)keyString
{
    NSLog(@"loading data for keyString: %@",keyString);
    NSData *encodedAllData =  [[NSUserDefaults standardUserDefaults] objectForKey:keyString];
    self.arrayOfFriends = [NSKeyedUnarchiver unarchiveObjectWithData:encodedAllData];
    if (self.arrayOfFriends == nil) {
        self.arrayOfFriends = [NSMutableArray new];
    }
    

}
-(void)addUser:(NSString *)item
{
    DoUser *user = [DoUser new];
    user.userIdNumber = [self getRandomId];
    user.username = item;
    [self.arrayOfUsers addObject:user];
    [[DataStore sharedInstance] saveData:self.arrayOfUsers withKey:[NSString stringWithFormat:@"Data_%@", user.userIdNumber]];
}

-(void)loadUserTasks:(NSString *)keyString
{
    NSLog(@"loading data for keyString: %@",keyString);
//    NSData *encodedAllData =  [[NSUserDefaults standardUserDefaults] objectForKey:keyString];
//    self.user.arrayOfUserTasks = [NSKeyedUnarchiver unarchiveObjectWithData:encodedAllData];
//    if (self.arrayOfUserTasks == nil) {
//        self.arrayOfFriends = [NSMutableArray new];
//    }
}

-(void)addFriend:(NSString *)item{
    
    NSLog(@"%@ item", item);
    DoUser *user = [DoUser new];
    user.userIdNumber = [self getRandomId];
    user.username = item;
    user.userColor = [self randomColor];
    [self.arrayOfFriends addObject:user];
    [[DataStore sharedInstance] saveData:self.arrayOfFriends withKey:@"friendsArray"];

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
-(void)deleteUser:(DoUser *)user{
    
    NSMutableArray *discardedItems = [NSMutableArray array];
    
    DoUser *item;
    
    for (item in self.arrayOfFriends) {
        if ([item.username isEqualToString:user.username]){
            NSLog(@"%@ - %@", item.username, user.username);
            [discardedItems addObject:item];
        }
    }
    [self.arrayOfFriends removeObjectsInArray:discardedItems];
    [self saveData:self.arrayOfFriends withKey:@"friendsArray"];
    
    
}
-(void)addTaskForUser:(DoUser *)user item:(NSString *)item
{
    if ( user.arrayOfUserTasks == nil){
        user.arrayOfUserTasks = [NSMutableArray new];
    }
    
    [user.arrayOfUserTasks addObject:item];
    NSLog(@"%@ id John'a", user.userIdNumber);
    NSLog(@"%lu taski dla usera", (unsigned long)user.arrayOfUserTasks.count);
    [[DataStore sharedInstance] saveData:user.arrayOfUserTasks withKey:[NSString stringWithFormat:@"Data_%@", user.userIdNumber]];
    
}

-(void)addTask:(NSString *)taskString
{
    NSLog(@"%@ taskString", taskString);
    
    DoTask *task = [DoTask new];
    task.idNumber = [self getRandomId];
    task.taskString = taskString;
    task.taskColor = [self randomColor];
    [self.arrayOfTasks addObject:task];
    
    [[DataStore sharedInstance] saveData:self.arrayOfTasks withKey:@"tasksArray"];
    
    NSLog(@"%lu array of task count", (unsigned long)self.arrayOfTasks.count);
    
    [task debugDump];
    
}
-(DoTask *)findTaskByID:(NSString *)idNumber
{
    for (DoTask *task in self.arrayOfTasks){
        if ([task.idNumber isEqualToString:idNumber]){
            return task;
        }
    }return nil;
}

-(DoUser *)findFriendByID:(NSString *)idNumber
{
    for (DoUser *user in self.arrayOfFriends){
        if ([user.userIdNumber isEqualToString:idNumber]){
            return user;
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
