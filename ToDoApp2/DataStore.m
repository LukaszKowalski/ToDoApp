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




-(NSMutableArray *)loadData:(NSString *)keyString
{
    
//    [SVProgressHUD showWithStatus:@"Loading tasks..." maskType:SVProgressHUDMaskTypeGradient];

    NSMutableArray *encodedAllData =  [[[NSUserDefaults standardUserDefaults] objectForKey:keyString] mutableCopy];
    self.arrayOfTasksLocally = encodedAllData;
    NSLog(@"DataStore LoadData method is fired with results: %@", self.arrayOfTasksLocally);
    return self.arrayOfTasksLocally;
}



-(void)saveData:(NSMutableArray *)myArray withKey:(NSString *)keyString
{
    NSLog(@"saveData: %@\n\nmyArray == %@",keyString,myArray);
    
    [[myArray reverseObjectEnumerator] allObjects];
    
    [[NSUserDefaults standardUserDefaults] setObject:myArray forKey:keyString];
    [[NSUserDefaults standardUserDefaults] synchronize];

}



-(void)saveUser:(NSDictionary *)myDictionary withKey:(NSString *)keyString{
    
    
    [[NSUserDefaults standardUserDefaults] setObject:myDictionary forKey:keyString];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTaskTableView" object:nil];
    
}




-(NSMutableArray *)loadFriends:(NSString *)keyString
{    
    NSMutableArray *encodedAllData =  [[[NSUserDefaults standardUserDefaults] objectForKey:keyString] mutableCopy];
    
    self.arrayOfFriendsLocally = [NSMutableArray new];
    
    NSLog(@"DataStore LoadFriends method is fired with results: %@", encodedAllData);
    self.arrayOfFriendsLocally = [[[NSUserDefaults standardUserDefaults] objectForKey:keyString] mutableCopy];
    return self.arrayOfFriendsLocally;
}




-(void)addFriend:(NSDictionary *)friend{
    
    NSDictionary *user = [NSDictionary new];
    user = friend;
    [self.arrayOfFriendsLocally addObject:user];
//    [[DataStore sharedInstance] saveData:self.arrayOfFriends withKey:@"friendsArray"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];

}




-(void)addTask:(PFObject*)task{
    
    NSDictionary *taskLocally = [self changeData:task];
    
    if (!self.arrayOfTasksLocally) {
        self.arrayOfTasksLocally = [[NSMutableArray alloc] init];
    }
    
    [self.arrayOfTasksLocally insertObject:taskLocally atIndex:0];
    [[DataStore sharedInstance] saveData:self.arrayOfTasksLocally withKey:@"tasksArrayLocally"];
    
    NSLog(@"DataStore Adding task. Current count of tasks is: %lu", (unsigned long)[self.arrayOfTasksLocally count]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
    
}




-(NSDictionary *)changeData:(PFObject *)object{
    NSArray *allKeys = [object allKeys];
    NSMutableDictionary *changedData = [[NSMutableDictionary alloc] init];
    for (NSString * key in allKeys) {
        [changedData setValue:[object objectForKey:key] forKey:key];
    }
    return changedData;
}


-(void)changeUserData:(PFObject *)object
{
    NSArray *allKeys = [object allKeys];
    NSMutableDictionary *changedData = [[NSMutableDictionary alloc] init];
    for (NSString * key in allKeys) {
        [changedData setValue:[object objectForKey:key] forKey:key];
    }
    if (!self.arrayOfFriendsLocally) {
        self.arrayOfFriendsLocally = [NSMutableArray new];
    }
    
    [self.arrayOfFriendsLocally addObject:changedData];
    
    [[DataStore sharedInstance] saveData:self.arrayOfFriendsLocally withKey:@"friendsArrayLocally"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
}

-(NSMutableDictionary *)changeTaskData:(PFObject *)object{
    NSArray *allKeys = [object allKeys];
    NSMutableDictionary *changedData = [[NSMutableDictionary alloc] init];
    for (NSString * key in allKeys) {
        [changedData setValue:[object objectForKey:key] forKey:key];
        [changedData setValue:[object objectId] forKey:@"objectId"];
    }
    return changedData;
}


- (NSMutableArray *)changeArrayOfParseObjects:(NSMutableArray *)array{

    NSMutableArray *kutasy = [[NSMutableArray alloc]init];
    
    for (PFObject *object in array) {
        NSMutableDictionary *kutas = [[DataStore sharedInstance] changeTaskData:object];
        [kutasy addObject:kutas];
        
    }
    
    return kutasy;
}


-(PFObject *)createTaskLocally:(NSString *)taskString withId:(NSString *)taskId{
    PFUser *user = [PFUser currentUser];
    
    UIColor *color = [[DataStore sharedInstance] randomColor:[self.arrayOfTasksLocally count]];
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    PFObject *task = [PFObject objectWithClassName:@"Tasks"];
    task[@"taskString"] = taskString;
    task[@"taskUsernameId"] = user.objectId;
    task[@"color"] = colorAsString;
    task[@"principal"] = user.username;
    task[@"deleteId"] = taskId;
    
    return task;
}


-(NSString *)getRandomId
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    return uuidString;
}


    
-(UIColor *)randomColor:(NSUInteger )item{
        
        NSArray *rainbowColors = [[NSArray alloc] initWithObjects:
                                  [UIColor colorWithRed:255/255.0 green:202/255.0 blue:94/255.0 alpha:1],
                                  [UIColor colorWithRed:255/255.0 green:94/255.0 blue:115/255.0 alpha:1],
                                  [UIColor colorWithRed:101/255.0 green:192/255.0 blue:197/255.0 alpha:1],
                                  [UIColor colorWithRed:133/255.0 green:117/255.0 blue:167/255.0 alpha:1],
                                  [UIColor colorWithRed:154/255.0 green:212/255.0 blue:107/255.0 alpha:1],
                                  [UIColor colorWithRed:215/255.0 green:216/255.0 blue:184/255.0 alpha:1],
                                  [UIColor colorWithRed:0/255.0 green:181/255.0 blue:156/255.0 alpha:1],
                                  nil];
        
        NSInteger modInd = item % [rainbowColors count];
        return [rainbowColors objectAtIndex:modInd];
        

}

-(void)clearAll
{
    self.arrayOfFriendsLocally = nil;
    self.arrayOfTasksLocally = nil;
    self.arrayOfColorsToPick = nil;
}



@end
