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
        self.done = [[UIButton alloc] initWithFrame:(CGRectMake(0, 0, 200, 78))];
        self.no = [[UIButton alloc] initWithFrame:(CGRectMake(200,0, 120, 78))];
        self.done.titleLabel.text = @"Done";
        self.done.titleLabel.font = [UIFont systemFontOfSize:26];
        self.done.backgroundColor  = [UIColor colorWithRed:49/255.0f green:151/255.0f blue:43/255.0f alpha:1.0f];
        self.no.titleLabel.text = @"No";
        self.no.titleLabel.font = [UIFont systemFontOfSize:26];
        self.no.backgroundColor =  [UIColor colorWithRed:227/255.0f green:4/255.0f blue:15/255.0f alpha:1.0f];
        self.done.hidden = YES;
        self.no.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
        
        [self.done addTarget:self action:@selector(doneFired:) forControlEvents:UIControlEventTouchUpInside];
        [self.no addTarget:self action:@selector(noFired:) forControlEvents:UIControlEventTouchUpInside];
        [self.no setTitle:@"No" forState:UIControlStateNormal];
        [self.done setTitle:@"Done" forState:UIControlStateNormal];
        
        
        self.done.tag = 10000;
        self.no.tag = 10001;

        [self.contentView addSubview:self.no];
        [self.contentView addSubview:self.done];
        NSLog(@"contentView komorki %@", self.contentView.subviews);
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
-(void)noFired:(id)sender{

    self.done.hidden = YES;
    self.no.hidden = YES;
    self.newestTask.hidden = NO;
}

-(void)doneFired:(id)sender{
    
    self.blinkLabel = [[UILabel alloc] initWithFrame:self.frame];
    self.blinkLabel.backgroundColor = [UIColor colorWithRed:255/255.0f green:114/255.0f blue:0/255.0f alpha:1];
    self.blinkLabel.text = @"Task Done";
    self.blinkLabel.textAlignment = NSTextAlignmentCenter;
    self.blinkLabel.textColor = [UIColor whiteColor];
    self.blinkLabel.font = [UIFont systemFontOfSize:26];
    
    
    CGRect cellFrame = self.frame;
    self.blinkLabel.frame = CGRectMake(cellFrame.origin.x, cellFrame.origin.y+self.superview.superview.frame.origin.y+64, cellFrame.size.width, cellFrame.size.height);
    NSLog(@"%@, %@", self.superview.superview , self.superview);
    
    UIView *view = [[[[self.contentView superview] superview] superview] superview];
    [view addSubview:self.blinkLabel];
    [view sendSubviewToBack:self.blinkLabel];
    
    NSLog(@"what superview is that :%@", [[[[self.contentView superview] superview] superview] superview] ); //when running on simiulator it is UIView
    
         [UITableViewCell animateWithDuration:1.0f
                          animations:^
          {
              
              [self setBounds:CGRectMake(-320, 0, 320, 78)];
          }
                          completion:^(BOOL finished)
          {
              
              [[DataStore sharedInstance] deleteTask:self.task];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
              self.done.hidden = YES;
              self.no.hidden = YES;
              self.newestTask.hidden = NO;
              self.blinkLabel.hidden = YES;
              [self setBounds:CGRectMake(0, 0, 320, 78)];
          }
          ];
     }

@end
