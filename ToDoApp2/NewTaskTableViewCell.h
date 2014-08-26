//
//  NewTaskTableViewCell.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *newestTask;
@property (nonatomic, strong) UIButton *done;
@property (nonatomic, strong) UIButton *no;

// -(void)reset;

@end
