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
        
        self.contentView.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
        
        self.whoAddedTask = [[UILabel alloc] init];
        self.whoAddedTask.frame = CGRectMake(0, 0, 320, 66);
        self.whoAddedTask.textColor = [UIColor whiteColor];
        self.whoAddedTask.userInteractionEnabled = NO;
        self.whoAddedTask.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        self.whoAddedTask.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
        [self.contentView addSubview:self.newestTask];
        
        // confirm
        
        UIImage *confirmImage = [UIImage imageNamed:@"IcoCheckColor.png"];
        self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.confirmButton setImage:confirmImage forState:UIControlStateNormal];
        self.confirmButton.frame = CGRectMake(80, 0, 81, 75);
        self.confirmButton.backgroundColor = [UIColor clearColor];
        [self.confirmButton addTarget:self action:@selector(confirmTask) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.confirmButton];
        [self.contentView insertSubview:self.confirmButton belowSubview:self.newestTask];
        
        self.confirmButton.hidden = YES;
        
        //
        
        // no
        
        
        self.no = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *plusImage = [UIImage imageNamed:@"IcoPlus.png"];
        [self.no setImage:plusImage forState:UIControlStateNormal];
        self.no.backgroundColor = [UIColor clearColor];
        [self.no addTarget:self action:@selector(noTask) forControlEvents:UIControlEventTouchUpInside];
        self.no.frame = CGRectMake(150, 0, 81, 75);
        
        [self.contentView addSubview:self.no];
        [self.contentView insertSubview:self.no belowSubview:self.newestTask];
        
        self.no.hidden = YES;
        
        //
        
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
    //    NSIndexPath *indexPath = [(UITableView *)self.superview.superview indexPathForCell: self];
    
    if (self.currentStatus == SWIPE_TYPE_LEFT) {
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:0.5 animations:^{
            [self.newestTask setFrame:CGRectMake(13, 0, self.contentView.frame.size.width-13, 66)];
        }];
        self.currentStatus = SWIPE_TYPE_START;
    }
    else if (self.currentStatus == SWIPE_TYPE_START){
        self.whoAddedTask.hidden = YES;
        self.confirmButton.hidden = NO;
        self.no.hidden = NO;
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:0.5 animations:^{
            [self.newestTask setFrame:CGRectMake(260, 0, self.contentView.frame.size.width-13, 66)];
        }];
        
        //        double delayInSeconds = 0.7;
        //        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        //        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //
        
        
        self.currentStatus = SWIPE_TYPE_RIGHT;
    }
}

-(void)didSwipeLeftInCell:(id)sender {
    
    if (self.currentStatus == SWIPE_TYPE_START){
        self.currentStatus = SWIPE_TYPE_LEFT;
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:0.5 animations:^{
            [self.newestTask setFrame:CGRectMake(-220, 0, self.contentView.frame.size.width-13, 66)];
        }];
    }else if (self.currentStatus == SWIPE_TYPE_RIGHT){
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:0.5 animations:^{
            [self.newestTask setFrame:CGRectMake(13, 0, self.contentView.frame.size.width-13, 66)];
            self.currentStatus = SWIPE_TYPE_START;
        } completion:^(BOOL finished) {
            self.whoAddedTask.hidden = NO;
            self.confirmButton.hidden = YES;
            self.no.hidden = NO;
            
        }];
    }
}
-(void) noTask{
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView animateWithDuration:0.5 animations:^{
        [self.newestTask setFrame:CGRectMake(13, 0, self.contentView.frame.size.width-13, 66)];
        self.currentStatus = SWIPE_TYPE_START;
    } completion:^(BOOL finished) {
        self.whoAddedTask.hidden = NO;
        self.confirmButton.hidden = YES;
        self.no.hidden = NO;
    }];
}
-(void) confirmTask{
    
    NSIndexPath *indexPath = [(UITableView *)self.superview.superview indexPathForCell: self];
    
    self.currentStatus = SWIPE_TYPE_START;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView animateWithDuration:0.8 animations:^{
        self.newestTask.text = @"Task Done";
        self.newestTask.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:22];
        [self.newestTask setFrame:CGRectMake(13, 0, self.contentView.frame.size.width-13, 66)];
        
    } completion:^(BOOL finished) {
        self.whoAddedTask.hidden = NO;
        self.confirmButton.hidden = YES;
        self.no.hidden = NO;
        self.newestTask.textColor = [UIColor whiteColor];
        
        [UIView transitionWithView:self.newestTask duration:0.7 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            self.newestTask.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
            self.newestTask.text = @"";
        } completion:^(BOOL finished){
            
            [self.delegate removeTaskforRowAtIndexPath:indexPath];
            
        }];
        
    }];
    
    
    self.currentStatus = SWIPE_TYPE_START;
    
    
}


@end
