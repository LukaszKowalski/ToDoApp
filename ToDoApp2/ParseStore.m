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
    
    PFUser *user = [PFUser currentUser];
    
    UIColor *color = self.randomColor;
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    NSString *colorAsString = [NSString stringWithFormat:@"%f,%f,%f,%f", components[0], components[1], components[2], components[3]];
    
    PFObject *task = [PFObject objectWithClassName:@"Tasks"];
    task[@"taskString"] = taskString;
    task[@"taskUsernameId"] = user.objectId;
    task[@"color"] = colorAsString;
    [task saveInBackground];
    
}

-(void)addFriend:(NSString *)username{
    
    // Check if User exists.


    PFQuery *query = [PFUser query];
    [query whereKey:@"username" equalTo:username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"%@", objects);
            if (objects.count > 0) {
            {
                PFUser *user = [objects firstObject];
                [user fetch];
                NSLog(@"user %@", user);
                [[PFUser currentUser] addObject:user forKey:@"friendsArray"];
                [[PFUser currentUser] save];
//                NSArray *friends = [[PFUser currentUser] objectForKey:@"friendsArray"];
//                for (NSString *friend in friends) {
//                    PFQuery *query = [PFUser query];
//                    [query whereKey:@"objectId" equalTo:friend];

                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
            }
            
            }}];
            
        
//    
//    
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


- (void)loadFriends:(FriendsViewController *)delegate{
    
    PFUser *user = [PFUser currentUser];
    
    NSLog(@"load user %@", user);
    [user objectForKey:@"friendsArray"];
    [user fetch];
    
    NSMutableArray *arrayOfUserFriends = [NSMutableArray new];
    arrayOfUserFriends = [user objectForKey:@"friendsArray"];
    NSLog(@"load user array of friends %@", arrayOfUserFriends); 
    [delegate loadArrayOfFriends:arrayOfUserFriends];
    
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
    [task saveInBackground];
    
}
-(UIColor *)randomColor{
    
    NSArray *rainbowColors = [[NSArray alloc] initWithObjects:
                              [UIColor colorWithRed:255/255.0 green:232/255.0 blue:0/255.0 alpha:1],
                              [UIColor colorWithRed:20/255.0 green:162/255.0 blue:212/255.0 alpha:1],
                              [UIColor colorWithRed:175/255.0 green:94/255.0 blue:156/255.0 alpha:1],
                              [UIColor colorWithRed:0/255.0 green:177/255.0 blue:106/255.0 alpha:1],
                              [UIColor colorWithRed:247/255.0 green:148/255.0 blue:30/255.0 alpha:1],
                              [UIColor colorWithRed:0/255.0 green:82/255.0 blue:156/255.0 alpha:1],
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

@end
