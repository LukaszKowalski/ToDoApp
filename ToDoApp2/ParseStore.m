//
//  ParseStore.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 9/10/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "ParseStore.h"

@implementation ParseStore

+ (instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)addTask:(NSString *)taskString{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"userTasks.plist"];
    NSMutableArray *userTasks = [NSMutableArray arrayWithContentsOfFile:path];
    
    if (nil == userTasks) {
        userTasks = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    PFUser *user = [PFUser currentUser];
    
    UIColor *color = self.randomColor;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    PFObject *task = [PFObject objectWithClassName:@"Tasks"];
    task[@"taskString"] = taskString;
    task[@"taskUsernameId"] = user.objectId;
    task[@"color"] = colorAsString;
    task[@"principal"] = user.username;
    
    [userTasks addObject:task];
    [userTasks writeToFile:path atomically: TRUE];
    NSLog(@"userTasks %@", userTasks);
    [task saveEventually];
    
}

-(void)addFriend:(NSString *)username{
    
    // Check if User exists.

    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            if (objects.count > 0) {
            {
                PFUser *user = [objects firstObject];
                [user fetch];
                NSArray *allKeys = [user allKeys];
                NSMutableDictionary *userData = [[NSMutableDictionary alloc] init];
                for (NSString * key in allKeys) {
                    [userData setValue:[user objectForKey:key] forKey:key];
                }
                // Create a dictionary from the JSON string
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                NSString *path = [documentsDirectory stringByAppendingPathComponent:@"friends.plist"];
                
                NSMutableArray *friend = [NSMutableArray arrayWithContentsOfFile:path];
                
                if (nil == friend) {
                    friend = [[NSMutableArray alloc] initWithCapacity:0];
                }
                NSMutableDictionary *array = [[NSMutableDictionary alloc]initWithDictionary:userData];
                [friend addObject:array];
                [friend writeToFile:path atomically: TRUE];
                [[PFUser currentUser] addObject:user.objectId forKey:@"friendsArray"];
                [[PFUser currentUser] saveEventually];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
            }else{
                NSLog(@"alert");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"user doesn't exist" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
                    [alert show];
            }
        }
    }];
            
        
    
//            if (user) {
//            [[PFUser currentUser] addObject:user forKey:@"friendsArray"];
//            [[PFUser currentUser] saveInBackground];
//                    } else {
//            NSLog(@"alert");
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"user doesn't exist" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
//            [alert show];
//                    }
}


-(void)deleteTask:(NSString *)taskString{
    
//    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
//    [query whereKey:@"taskString" equalTo:taskString];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            for (PFObject *object in objects) {
//                [object delete];
//            }
//        } else {
//            // Log details of the failure
//            NSLog(@"Error: %@ %@", error, [error userInfo]);
//        }
//    }];
    
}

-(void)deleteFriend:(NSString *)username{
    
}
- (void)loadTasks:(ToDoViewController *)delegate{
    
    

    PFUser *user = [PFUser currentUser];
    __block NSMutableArray *arrayOfParseTasks = [NSMutableArray new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"taskUsernameId" equalTo:[NSString stringWithFormat:@"%@", user.objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
                        
            for (id object in objects) {
                [arrayOfParseTasks addObject:object];
                
            }
            
            dispatch_async(dispatch_get_main_queue(),^{
                [delegate loadArrayOfTasks:arrayOfParseTasks];
                
            });
            
        }
    }];
}

- (void)loadTasksForStart:(ToDoViewController *)delegate{
    
    NSLog(@"work"); 
    
    PFUser *user = [PFUser currentUser];
    __block NSMutableArray *arrayOfParseTasks = [NSMutableArray new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"taskUsernameId" equalTo:[NSString stringWithFormat:@"%@", user.objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (id object in objects) {
                [arrayOfParseTasks addObject:object];
                
            }
            
            dispatch_async(dispatch_get_main_queue(),^{
                [delegate loadArrayOfTasksForStart:arrayOfParseTasks];
            });
            
        }
    }];
}


- (void)loadTasksForUser:(FriendsToDoViewController *)delegate forUser:(NSString*)username{
    
    
    
    PFQuery *queryAboutUser = [PFUser query];
    [queryAboutUser whereKey:@"username" equalTo:username];
    PFUser *user = (PFUser *)[queryAboutUser getFirstObject];
    
    __block NSMutableArray *arrayOfUserTasks = [NSMutableArray new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"taskUsernameId" equalTo:[NSString stringWithFormat:@"%@", user.objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (id object in objects) {
                [arrayOfUserTasks addObject:object];
            }
            
            dispatch_async(dispatch_get_main_queue(),^{
                [delegate loadArrayOfTaskss:arrayOfUserTasks];
            });
            
            
        }
    }];
}
-(void)sendNotificationNewTask:(NSDictionary *)user withString:(NSString *)task{
    
    NSDictionary *objectId = user;
    NSString *username = [objectId objectForKey:@"username"];
    PFQuery *userQuery=[PFUser query];
    
    [userQuery whereKey:@"username" equalTo:username];
    
    // send push notification to the user
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"Owner" matchesQuery:userQuery];
    
    PFPush *push = [PFPush new];
    [push setQuery: pushQuery];
    NSString *message= [NSString stringWithFormat:@"New task for you \"%@\"", task];
    [push setData: @{ @"alert":message}];
    [push sendPushInBackground];
    

    
    
}

- (void)loadFriends:(FriendsViewController *)delegate withObjectId:(NSString *)objectID{
    
    PFUser *user = [self userFromObjectId:objectID];
    
    
    NSMutableArray *arrayOfUserFriends = [NSMutableArray new];
    arrayOfUserFriends = [user objectForKey:@"friendsArray"];
    //
    NSMutableArray *friendsArray = [NSMutableArray new];
    for (NSString *friendId in arrayOfUserFriends) {
        PFUser *friend = [self userFromObjectId:friendId];
        [friendsArray addObject:friend];
    }
    
      [delegate loadArrayOfFriends:friendsArray];
    
}
-(PFUser *)userFromObjectId:(NSString *)objectId {
 
    PFQuery *queryAboutUser = [PFUser query];
    [queryAboutUser whereKey:@"objectId" equalTo:objectId];
    PFUser *user = (PFUser *)[queryAboutUser getFirstObject];
    
    if (user) {
        [user fetch];
    }
    return user;
}

-(void)addTask:(NSString *)taskString forUser:(NSString *)username{
    
    UIColor *color = self.randomColor;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    PFQuery *queryAboutUser = [PFUser query];
    [queryAboutUser whereKey:@"username" equalTo:username];
    PFUser *user = (PFUser *)[queryAboutUser getFirstObject];
    
    PFObject *task = [PFObject objectWithClassName:@"Tasks"];
    task[@"taskString"] = taskString;
    task[@"taskUsernameId"] = user.objectId;
    task[@"color"] = colorAsString;
    task[@"principal"] = [[PFUser currentUser] username];
    
    [task saveEventually];
    
    
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
    return color;
}
-(UIColor *)giveColorfromStringColor:(NSString *)colorAsString
{
    NSArray *components = [colorAsString componentsSeparatedByString:@","];
    CGFloat r = [[components objectAtIndex:0] floatValue];
    CGFloat g = [[components objectAtIndex:1] floatValue];
    CGFloat b = [[components objectAtIndex:2] floatValue];
    CGFloat a = [[components objectAtIndex:3] floatValue];
    UIColor *color = [UIColor colorWithRed:r green:g blue:b alpha:a];
    return color;
}
- (void)registerUserForPushNotification{
    
    PFUser *currentUser = [PFUser currentUser];
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setObject:currentUser forKey:@"Owner"];
    [currentInstallation saveInBackground];
    
};

-(void)asignWhosViewControllerItIs:(NSDictionary *)user{
    self.usersViewController = user;
};
-(NSDictionary *)whosViewControllerItIs{
    return self.usersViewController;
};

//- (void)loadUserData:(NSString *)objectId{
//    
//    PFUser *user = [PFUser currentUser];
//    
//    __block NSMutableArray *arrayOfParseTasks = [NSMutableArray new];
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
//    query.cachePolicy = kPFCachePolicyNetworkElseCache;
//    [query whereKey:@"taskUsernameId" equalTo:[NSString stringWithFormat:@"%@", user.objectId]];
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            
//            for (id object in objects) {
//                [arrayOfParseTasks addObject:object];
//            }
//            
//            dispatch_async(dispatch_get_main_queue(),^{
//                [delegate loadArrayOfTasks:arrayOfParseTasks];
//            });
//            
//            
//        }
//    }];
//
//

@end
