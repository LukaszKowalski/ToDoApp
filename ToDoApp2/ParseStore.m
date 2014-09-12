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
            NSLog(@"Successfully retrieved %d task.", objects.count);
            
            for (id object in objects) {
                [arrayOfParseTasks addObject:object];
            }
            
            dispatch_async(dispatch_get_main_queue(),^{
                [delegate loadArrayOfTasks:arrayOfParseTasks];
            });
            
            
            }
    }];
    NSLog(@"tasks outside the block: %d", arrayOfParseTasks.count);
}

@end
