//
//  JobView.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobModel.h"

@protocol JobViewDelegate <NSObject>

-(void) selectJob:(NSString *)jobName withId:(NSString *)jobId;

@end

@interface JobView : UIView <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *jobTable;
    NSMutableArray *jobArray;
    id<JobViewDelegate> delegate;
}

@property (nonatomic, assign) id<JobViewDelegate> delegate;

-(void) reloadJobs:(NSArray *)array;

@end
