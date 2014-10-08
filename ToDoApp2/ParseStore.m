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

-(void)addTask:(NSString *)taskString forNumber:(NSUInteger)number{
    
    PFUser *user = [PFUser currentUser];
    
    UIColor *color = [[DataStore sharedInstance] randomColor:number];
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    PFObject *task = [PFObject objectWithClassName:@"Tasks"];
    task[@"taskString"] = taskString;
    task[@"taskUsernameId"] = user.objectId;
    task[@"color"] = colorAsString;
    task[@"principal"] = user.username;
    
    [task saveInBackground];
    
}

-(void)addTaskDoTeam:(NSString *)taskString forNumber:(NSUInteger)number{
    
    PFUser *user = [PFUser currentUser];
    
    UIColor *color = [[DataStore sharedInstance] randomColor:number];
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    PFObject *task = [PFObject objectWithClassName:@"Tasks"];
    task[@"taskString"] = taskString;
    task[@"taskUsernameId"] = user.objectId;
    task[@"color"] = colorAsString;
    task[@"principal"] = @"DoTeam";
    
    [task save];
    
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
    
                [[PFUser currentUser] addObject:user.objectId forKey:@"friendsArray"];
                [[DataStore sharedInstance] changeUserData:user];
                [[PFUser currentUser] saveInBackground];
               [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
            }
            }else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"user doesn't exist" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil, nil];
                [SVProgressHUD dismiss];
                    [alert show];
            }
        }
    }];
}


-(void)deleteTask:(NSString *)taskString withId:(NSString *)taskId{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    [query whereKey:@"objectId" equalTo:taskId];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                [object deleteInBackground];
            }
        }
    }];
}


-(void)deleteFriend:(NSString *)username{
    
}
- (void)loadTasks{
    
    [SVProgressHUD showWithStatus:@"Loading tasks..." maskType:SVProgressHUDMaskTypeGradient];

    PFUser *user = [PFUser currentUser];
    __block NSMutableArray *arrayOfParseTasks = [NSMutableArray new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    
    [query orderByAscending:@"createdAt"];
    
    [query whereKey:@"taskUsernameId" equalTo:[NSString stringWithFormat:@"%@", user.objectId]];
    [query includeKey:@"objectId"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
                        
            for (id object in objects) {
                NSLog(@" kurwa objectId %@", [object objectId]);
                [arrayOfParseTasks insertObject:object atIndex:0];

            }
            arrayOfParseTasks = [[DataStore sharedInstance] changeArrayOfParseObjects:arrayOfParseTasks];
            [[DataStore sharedInstance] saveData:arrayOfParseTasks  withKey:@"tasksArrayLocally"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTaskTableView" object:nil];
            NSLog(@"loaded");

//            dispatch_async(dispatch_get_main_queue(),^{
//                [delegate loadArrayOfTasks:arrayOfParseTasks];
//                
//            });
            
        }
    }];
}

- (void)loadFriends{
    
      __block NSMutableArray *arrayOfParseFriends = [NSMutableArray new];
    
    PFQuery *query= [PFUser query];
    [query whereKey:@"username" equalTo:[[PFUser currentUser]username]];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *objects, NSError *error){
        
        if (!error) {
            NSLog(@"object %@", objects);
            arrayOfParseFriends = [objects objectForKey:@"friendsArray"];
            NSLog(@"array friendow %@", arrayOfParseFriends);
            
            for (NSString *userId in arrayOfParseFriends) {
                PFQuery *queryAboutUser = [PFUser query];
                [queryAboutUser whereKey:@"objectId" equalTo:userId];
                PFUser *user = (PFUser *)[queryAboutUser getFirstObject];
                [[DataStore sharedInstance] changeUserData:user];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
//            [[DataStore sharedInstance] saveData:arrayOfParseFriends  withKey:@"friendsArrayLocally"];
        }
    }];
}

- (void)loadTasksForUser:(FriendsToDoViewController *)delegate forUser:(NSString*)username{
    
    PFQuery *queryAboutUser = [PFUser query];
    [queryAboutUser whereKey:@"username" equalTo:username];
    PFUser *user = (PFUser *)[queryAboutUser getFirstObject];
    
//   NSDictionary *user = [[ParseStore sharedInstance] whosViewControllerItIs];
    
    __block NSMutableArray *arrayOfUserTasks = [NSMutableArray new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    [query orderByDescending:@"createdAt"];

    [query whereKey:@"taskUsernameId" equalTo:[NSString stringWithFormat:@"%@", user.objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (id object in objects) {
                [arrayOfUserTasks addObject:object];
            }
                [delegate loadArrayOfTaskss:arrayOfUserTasks];
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
    [push setData: @{ @"alert":message, @"reload":@"reload data", @"taskString":task }];
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
    
    [task save];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadSomeoneTableView" object:nil];

    
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

-(void)asignArrayOfTasks:(NSMutableArray *)array{    
    self.asignedArrayOfTasks = array;
};
-(NSMutableArray *)getArrayOfTasks{
    return self.asignedArrayOfTasks;
};



@end
