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
    
    NSMutableArray *encodedAllData =  [[[NSUserDefaults standardUserDefaults] objectForKey:keyString] mutableCopy];
    self.arrayOfTasksLocally = encodedAllData;
    return self.arrayOfTasksLocally;
}
-(void)saveData:(NSMutableArray *)myArray withKey:(NSString *)keyString{
    
    [[myArray reverseObjectEnumerator] allObjects];
    [[NSUserDefaults standardUserDefaults] setObject:myArray forKey:keyString];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTaskTableView" object:nil];

}
-(void)saveUser:(NSDictionary *)myDictionary withKey:(NSString *)keyString{
    
    [[NSUserDefaults standardUserDefaults] setObject:myDictionary forKey:keyString];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTaskTableView" object:nil];
    
}


-(NSMutableArray *)loadFriends:(NSString *)keyString
{
    NSMutableArray *encodedAllData =  [[[NSUserDefaults standardUserDefaults] objectForKey:keyString] mutableCopy];;
    NSLog(@"Ty suk %@", [encodedAllData class]);

    self.arrayOfFriendsLocally = encodedAllData;
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
    
    [self.arrayOfTasksLocally addObject:taskLocally];
    [[DataStore sharedInstance] saveData:self.arrayOfTasksLocally withKey:@"tasksArrayLocally"];
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
-(void)changeUserData:(PFObject *)object{
    NSArray *allKeys = [object allKeys];
    NSMutableDictionary *changedData = [[NSMutableDictionary alloc] init];
    for (NSString * key in allKeys) {
        [changedData setValue:[object objectForKey:key] forKey:key];
    }
    NSLog(@"changedData = %@", changedData);
    if (!self.arrayOfFriendsLocally) {
        self.arrayOfFriendsLocally = [NSMutableArray new];
    }
    
    [self.arrayOfFriendsLocally addObject:changedData];
    [[DataStore sharedInstance] saveData:self.arrayOfFriendsLocally withKey:@"friendsArrayLocally"];
    NSLog(@"data store array %@", self.arrayOfFriendsLocally); 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
}


-(PFObject *)createTaskLocally:(NSString *)taskString{
    PFUser *user = [PFUser currentUser];
    
    UIColor *color = self.randomColor;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    PFObject *task = [PFObject objectWithClassName:@"Tasks"];
    task[@"taskString"] = taskString;
    task[@"taskUsernameId"] = user.objectId;
    task[@"color"] = colorAsString;
    task[@"principal"] = user.username;
    
    return task;
}


-(NSString *)getRandomId
{
    CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
    NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
    CFRelease(newUniqueId);
    return uuidString;
}

-(UIColor *)randomColor{
    
    NSArray *rainbowColors = [[NSArray alloc] initWithObjects:
                              [UIColor colorWithRed:255/255.0 green:202/255.0 blue:94/255.0 alpha:1],
                              [UIColor colorWithRed:255/255.0 green:94/255.0 blue:115/255.0 alpha:1],
                              [UIColor colorWithRed:101/255.0 green:192/255.0 blue:197/255.0 alpha:1],
                              [UIColor colorWithRed:133/255.0 green:117/255.0 blue:167/255.0 alpha:1],
                              [UIColor colorWithRed:154/255.0 green:212/255.0 blue:107/255.0 alpha:1],
                              [UIColor colorWithRed:215/255.0 green:216/255.0 blue:184/255.0 alpha:1],
                              [UIColor colorWithRed:0/255.0 green:181/255.0 blue:156/255.0 alpha:1],
                              nil];
    
    UIColor *color = [rainbowColors objectAtIndex:arc4random()%[rainbowColors count]];
    
    self.arrayOfColorsToPick = [[NSMutableArray alloc] init];
    [self.arrayOfColorsToPick addObject:color];
    if ([self.arrayOfColorsToPick containsObject:color]) {
        NSLog(@"jesteś frajerem");
    }
    if (self.arrayOfColorsToPick.count > 6){
        [self.arrayOfColorsToPick removeAllObjects];
        
    }
    
    return color;

}



@end
