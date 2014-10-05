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

    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
