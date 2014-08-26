//
//  DataSource.h
//  ToDoApp2
//
//  Created by Łukasz Kowalski on 8/13/14.
//  Copyright (c) 2014 Lukasz Kowalski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataStore : NSObject

 +(instancetype) sharedInstance;

-(NSArray *)loadData:(NSString *)keyString;
-(void)saveData:(NSArray *)array withKey:(NSString *)keyString;


@end
