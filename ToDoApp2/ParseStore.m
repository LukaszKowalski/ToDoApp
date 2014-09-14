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
    
    PFObject *task = [PFObject objectWithClassName:@"Tasks"];
    task[@"taskString"] = taskString;
    task[@"taskUsernameId"] = user.objectId;
    [task saveInBackground];
    
}

-(void)addFriend:(NSString *)username{
    
    // Check if User exists. 
    
//    PFQuery *query = [PFUser query];
//    [query whereKey:@"username" equalTo:username];
    
    [[PFUser currentUser] addObject:username forKey:@"friendsArray"];
    [[PFUser currentUser] saveInBackground];
}

-(void)deleteTask:(NSString *)taskString{
    
}

-(void)deleteFriend:(NSString *)username{
    
}
- (void)loadTasks:(ToDoViewController *)delegate{
    PFUser *user = [PFUser currentUser];
    
    __block NSMutableArray *arrayOfParseTasks = [NSMutableArray new];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Tasks"];
    [query whereKey:@"taskUsernameId" equalTo:[NSString stringWithFormat:@"%@", user.objectId]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %lu task.", (unsigned long)objects.count);
            
            for (id object in objects) {
                [arrayOfParseTasks addObject:object];
            }
            
            dispatch_async(dispatch_get_main_queue(),^{
                [delegate loadArrayOfTasks:arrayOfParseTasks];
            });
            
            
            }
    }];
    NSLog(@"tasks outside the block: %lu", (unsigned long)arrayOfParseTasks.count);
}
- (void)loadFriends:(FriendsViewController *)delegate{
    PFUser *user = [PFUser currentUser];
    
    NSMutableArray *arrayOfUserFriends = [NSMutableArray new];
    arrayOfUserFriends = [user objectForKey:@"friendsArray"];
    NSLog(@"licza ziomków: %lu", (unsigned long)arrayOfUserFriends.count);
    [delegate loadArrayOfFriends:arrayOfUserFriends];
}

@end
