//
//  FriendsToDoTableViewCell.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 10/5/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseStore.h"
#import "FriendsToDoViewController.h"

@interface FriendsToDoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *taskForFriend;
@property (nonatomic, strong) UILabel *remiderSent;
@property (strong, nonatomic) NSDictionary *objectId;
@property (strong, nonatomic) NSMutableArray *arrayOfUserTasksForNotification;

@end
