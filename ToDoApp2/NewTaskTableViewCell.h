//
//  NewTaskTableViewCell.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/4/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DoTask.h"
#import "DataStore.h"

@class ToDoViewController;

@interface NewTaskTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *newestTask;
@property (nonatomic, strong) UIButton *done;
@property (nonatomic, strong) UIButton *no;
@property (nonatomic, strong) DoTask *task;
@property (nonatomic, weak) ToDoViewController *viewController;
@property (nonatomic, strong) UILabel *blinkLabel;


@end
