//
//  NewTaskTableViewCell.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "NewTaskTableViewCell.h"

@implementation NewTaskTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.newestTask = [UIButton buttonWithType:UIButtonTypeCustom];
        self.newestTask.frame = CGRectMake(0, 0, 320, 78);
        [self.newestTask addTarget:self action:@selector(confirmTask) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.newestTask];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)confirmTask{
    self.newestTask.backgroundColor = [UIColor greenColor];
}


@end
