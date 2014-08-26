//
//  NewTaskTableViewCell.m
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import "NewTaskTableViewCell.h"
#import "ToDoViewController.h"

@implementation NewTaskTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.newestTask = [[UILabel alloc] init];
        self.newestTask.frame = CGRectMake(0, 0, 320, 78);
        self.newestTask.textColor = [UIColor whiteColor];
        self.newestTask.font = [UIFont systemFontOfSize:26];
        [self.contentView addSubview:self.newestTask];
        self.done = [[UIButton alloc] initWithFrame:(CGRectMake(0, 0, 160, 78))];
        self.no = [[UIButton alloc] initWithFrame:(CGRectMake(160,0, 160, 78))];
        self.done.titleLabel.text = @"Done";
        self.done.backgroundColor = [UIColor greenColor];
        self.no.titleLabel.text = @"No";
        self.no.backgroundColor = [UIColor redColor];
        self.done.hidden = YES;
        self.no.hidden = YES;
        
        [self.done addTarget:self action:@selector(doneFired:) forControlEvents:UIControlEventTouchUpInside];
        [self.no addTarget:self action:@selector(noFired:) forControlEvents:UIControlEventTouchUpInside];
        [self.no setTitle:@"No" forState:UIControlStateNormal];
        [self.done setTitle:@"Done" forState:UIControlStateNormal];

        
        
        
        [self.contentView addSubview:self.no];
        [self.contentView addSubview:self.done];
    }
    return self;
}

//-(void)reset {
//    
//    self.newestTask = [[UILabel alloc] init];
//    self.newestTask.frame = CGRectMake(0, 0, 320, 78);
//    self.newestTask.textColor = [UIColor whiteColor];
//    self.newestTask.font = [UIFont systemFontOfSize:26];
//    [self.contentView addSubview:self.newestTask];
//    self.done = [[UIButton alloc] initWithFrame:(CGRectMake(0, 0, 160, 78))];
//    self.no = [[UIButton alloc] initWithFrame:(CGRectMake(160,0, 160, 78))];
//    self.done.titleLabel.text = @"Done";
//    self.done.backgroundColor = [UIColor greenColor];
//    self.no.titleLabel.text = @"No";
//    self.no.backgroundColor = [UIColor redColor];
//    self.done.hidden = YES;
//    self.no.hidden = YES;
//    
//    [self.contentView addSubview:self.no];
//    [self.contentView addSubview:self.done];
//
//}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)noFired:(id)sender{

    self.done.hidden = YES;
    self.no.hidden = YES;
    self.newestTask.hidden = NO;
}

-(void)doneFired:(id)sender{
    
    [[DataStore sharedInstance] deleteTask:self.task];
//    [self.viewController reloadTableView];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
    self.done.hidden = YES;
    self.no.hidden = YES;
    self.newestTask.hidden = NO;
}




@end
