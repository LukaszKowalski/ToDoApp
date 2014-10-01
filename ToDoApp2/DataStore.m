////
////  DataSource.m
////  ToDoApp2
////
////  Created by Łukasz Kowalski on 8/13/14.
////  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
////
//

#import "DataStore.h"

@class ParseStore;

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
    
    NSData *encodedAllData =  [[NSUserDefaults standardUserDefaults] objectForKey:keyString];
    self.arrayOfTasksLocally = [NSKeyedUnarchiver unarchiveObjectWithData:encodedAllData];
    if (self.arrayOfTasksLocally == nil) {
        self.arrayOfTasksLocally = [NSMutableArray new];
    }
    
    
}
-(NSMutableArray *)loadFriends:(NSString *)keyString
{

    NSMutableDictionary *dictionary = [[NSUserDefaults standardUserDefaults] objectForKey:keyString];
    [self.arrayOfFriendsLocally addObject:dictionary];
//    if (self.arrayOfFriends == nil) {
//        self.arrayOfFriends = [NSMutableArray new];
//    }
    
    return self.arrayOfFriendsLocally;

}

-(void)addFriend:(NSDictionary *)friend{
    
    NSDictionary *user = [NSDictionary new];
    user = friend;
    [self.arrayOfFriendsLocally addObject:user];
//    [[DataStore sharedInstance] saveData:self.arrayOfFriends withKey:@"friendsArray"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];

}
-(void)addTask:(NSDictionary *)task{
    
    NSDictionary *taskLocally = [NSDictionary new];
    taskLocally = task;
    [self.arrayOfFriendsLocally addObject:task];
    //    [[DataStore sharedInstance] saveData:self.arrayOfFriends withKey:@"friendsArray"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
    
}


-(void)saveData:(NSMutableDictionary *)myDictionary withKey:(NSString *)keyString

{
    [[NSUserDefaults standardUserDefaults] setObject:myDictionary forKey:keyString];

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
