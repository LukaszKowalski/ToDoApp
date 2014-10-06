//
//  FriendsToDoTableViewCell.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 10/5/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "FriendsToDoTableViewCell.h"

@implementation FriendsToDoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.taskForFriend = [[UILabel alloc] init];
        self.taskForFriend.frame = CGRectMake(0, 0, 300, 66);
        self.taskForFriend.textColor = [UIColor whiteColor];
        self.taskForFriend.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        self.taskForFriend.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.taskForFriend];

        self.remiderSent = [[UILabel alloc] init];
        self.remiderSent.frame = CGRectMake(0, 0, 300, 66);
        self.remiderSent.backgroundColor = [UIColor whiteColor];
        self.remiderSent.textColor = [UIColor blackColor];
        self.remiderSent.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        self.remiderSent.text = @"You've sent a reminder";
        self.remiderSent.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.remiderSent];
        [self.contentView insertSubview:self.remiderSent aboveSubview:self.taskForFriend];
        self.remiderSent.hidden =YES;
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    longPress.minimumPressDuration = 1.0f;
    longPress.allowableMovement = 100.0f;
    [self.contentView addGestureRecognizer:longPress];
    
    
    return self;
}
- (void)handleGesture:(UILongPressGestureRecognizer *)sender{
    
    self.arrayOfUserTasksForNotification = [[ParseStore sharedInstance] asignedArrayOfTasks];
    NSIndexPath *indexPath = [(UITableView *)self.superview.superview indexPathForCell: self];
    PFObject *task  = [self.arrayOfUserTasksForNotification objectAtIndex:indexPath.row];
    
    if (sender.state == UIGestureRecognizerStateBegan){
        
    self.remiderSent.hidden = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.remiderSent.hidden = YES;
        });
        
    self.objectId = [[ParseStore sharedInstance] whosViewControllerItIs];
    NSString *username = [self.objectId objectForKey:@"username"];
    
    PFQuery *userQuery=[PFUser query];
    [userQuery whereKey:@"username" equalTo:username];
    
    // send push notification to the user
    PFQuery *pushQuery = [PFInstallation query];
    [pushQuery whereKey:@"Owner" matchesQuery:userQuery];
    
    PFPush *push = [PFPush new];
    [push setQuery: pushQuery];
    NSString *message= [NSString stringWithFormat:@"%@ remainds you about %@",[PFUser currentUser].username ,[task objectForKey:@"taskString"]];
    [push setData: @{ @"alert":message}];
    [push sendPushInBackground];
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
