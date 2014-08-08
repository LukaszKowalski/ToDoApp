//
//  FriendsTableViewCell.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/8/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendsTableViewCell : UITableViewCell

@property (nonatomic, strong) UIButton *newestFriend;
-( UIColor *)randomColor;

@end
