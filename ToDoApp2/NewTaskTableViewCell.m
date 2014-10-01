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
        
        self.background = [[UILabel alloc] init];
        
        self.newestTask = [[UILabel alloc] init];
        self.newestTask.frame = CGRectMake(13, 0, 294, 66);
        self.newestTask.textColor = [UIColor whiteColor];
        self.newestTask.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        [self.newestTask setUserInteractionEnabled:YES];
        
        self.whoAddedTask = [[UILabel alloc] init];
        self.whoAddedTask.frame = CGRectMake(0, 0, 320, 66);
        self.whoAddedTask.textColor = [UIColor whiteColor];
        self.whoAddedTask.userActivity = NO; 
        self.whoAddedTask.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        self.whoAddedTask.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
        [self.contentView addSubview:self.newestTask];

        self.currentStatus = SWIPE_TYPE_START;
        
        [self.contentView insertSubview:self.whoAddedTask belowSubview:self.newestTask];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRightInCell:)];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];

        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeLeftInCell:)];
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        

        [self.newestTask addGestureRecognizer:swipeRight];
        [self.newestTask addGestureRecognizer:swipeLeft];
        
        // Prevent selection highlighting
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
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
    
}

-(void)didSwipeRightInCell:(id)sender{
    NSIndexPath *indexPath = [(UITableView *)self.superview.superview indexPathForCell: self];

    if (self.currentStatus == SWIPE_TYPE_LEFT) {

    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.5 animations:^{
        [self.newestTask setFrame:CGRectMake(13, 0, self.contentView.frame.size.width-13, 66)];
        }];
        self.currentStatus = SWIPE_TYPE_START;
    }
//    else if (self.currentStatus == SWIPE_TYPE_START){
//
//        [UIView animateWithDuration:0.5 animations:^{
//            [self.newestTask setFrame:CGRectMake(320, 0, self.contentView.frame.size.width-26, 70)];
//        }];
//        
//        double delayInSeconds = 0.7;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            
//            [self.delegate removeTaskforRowAtIndexPath:indexPath];
//            
//        });
//
//        self.currentStatus = SWIPE_TYPE_START;
//        [self.newestTask setFrame:CGRectMake(13, 0, self.contentView.frame.size.width-26, 70)];
//
//    }
}

-(void)didSwipeLeftInCell:(id)sender {
    
    self.currentStatus = SWIPE_TYPE_LEFT;
    NSLog(@"swipe left");
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.3 animations:^{
        [self.newestTask setFrame:CGRectMake(-200, 0, self.contentView.frame.size.width-26, 66)];
    }];
}



@end
