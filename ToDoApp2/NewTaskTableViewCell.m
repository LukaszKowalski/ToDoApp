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
        self.newestTask.frame = CGRectMake(0, 0, 320, 70);
        self.newestTask.textColor = [UIColor whiteColor];
        self.newestTask.font = [UIFont systemFontOfSize:26];
        [self.newestTask setUserInteractionEnabled:YES];
        
        self.whoAddedTask = [[UILabel alloc] init];
        self.whoAddedTask.frame = CGRectMake(0, 0, 320, 70);
        self.whoAddedTask.textColor = [UIColor whiteColor];
        self.whoAddedTask.font = [UIFont systemFontOfSize:26];
        self.whoAddedTask.backgroundColor = [UIColor colorWithRed:48/255.0f green:52/255.0f blue:104/255.0f alpha:1.0f];
        
        [self.contentView addSubview:self.newestTask];
        self.done = [[UIButton alloc] initWithFrame:(CGRectMake(0, 0, 200, 70))];
        self.no = [[UIButton alloc] initWithFrame:(CGRectMake(200,0, 120, 70))];
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

-(void)didSwipeRightInCell:(id)sender {
    
    // Inform the delegate of the right swipe
   // [delegate didSwipeRightInCellWithIndexPath:_indexPath];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    // Swipe top view left
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.newestTask setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 70)];
        
    }
//                     completion:^(BOOL finished) {
//        
//        // Bounce lower view
//        [UIView animateWithDuration:0.15 animations:^{
//            
//            [self.newestTask setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 70)];
//            
//        }
//                         completion:^(BOOL finished) {
//            
//            [UIView animateWithDuration:0.15 animations:^{
//                [self.newestTask setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 70)];
//            }];
//        }];
//    }
         ];
    
 //   }];
}

-(void)didSwipeLeftInCell:(id)sender {
    
    // Inform the delegate of the left swipe
   // [delegate didSwipeLeftInCellWithIndexPath:_indexPath];
    
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.newestTask setFrame:CGRectMake(-280, 0, self.contentView.frame.size.width, 70)];
    }
//                     completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.15 animations:^{
//            [self.newestTask setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 70)];
//        }];
//    }
     ];
    
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
    
    UIView *view = [[[[self.contentView superview] superview] superview] superview];
    [view addSubview:self.blinkLabel];
    [view sendSubviewToBack:self.blinkLabel];
    

         [UITableViewCell animateWithDuration:1.0f
                          animations:^
          {
              
              [self setBounds:CGRectMake(-320, 0, 320, 78)];
          }
                          completion:^(BOOL finished)
          {
              
              [[ParseStore sharedInstance] deleteTask:@""];
              [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadTableView" object:nil];
              self.done.hidden = YES;
              self.no.hidden = YES;
              self.newestTask.hidden = NO;
              self.blinkLabel.hidden = YES;
              [self setBounds:CGRectMake(0, 0, 320, 78)];
          }
          ];
     }
#pragma mark - horizontal pan gesture methods
//-(BOOL)gestureRecognizerShouldBegin:(UISwipeGestureRecognizer *)gestureRecognizer {
//    CGPoint translation = [gestureRecognizer translationInView:self.newestTask];
//    // Check for horizontal gesture
//    if (fabsf(translation.x) > fabsf(translation.y)) {
//        return YES;
//    }
//    return NO;
//}
//
//-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
//    // 1
//    [self subviews];
//    
//    
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        // if the gesture has just started, record the current centre location
//        __originalCenter = self.newestTask.center;
//    }
//    
//    // 2
//    if (recognizer.state == UIGestureRecognizerStateChanged) {
//        // translate the center
//        CGPoint translation = [recognizer translationInView:self.newestTask];
//        
//        self.newestTask.center = CGPointMake(__originalCenter.x + translation.x, __originalCenter.y);
//        // determine whether the item has been dragged far enough to initiate a delete / complete
//        __deleteOnDragRelease = self.newestTask.frame.origin.x < -self.newestTask.frame.size.width / 2;
//        
//    }
//    
//    // 3
//    if (recognizer.state == UIGestureRecognizerStateEnded) {
//        CGPoint translation = [recognizer translationInView:self.newestTask];
//        if (__originalCenter.x + translation.x > -110) {
//            self.newestTask.center = CGPointMake(-110, __originalCenter.y);
//        }
//        // the frame this cell would have had before being dragged
//        CGRect originalFrame = CGRectMake(0, self.newestTask.frame.origin.y,
//                                          self.newestTask.bounds.size.width, self.newestTask.bounds.size.height);
//        if (!__deleteOnDragRelease) {
//            // if the item is not being deleted, snap back to the original location
//            [UIView animateWithDuration:0.2
//                             animations:^{
//                                 self.newestTask.frame = originalFrame;
//                             }
//             ];
//        }
//    }
//}

@end
