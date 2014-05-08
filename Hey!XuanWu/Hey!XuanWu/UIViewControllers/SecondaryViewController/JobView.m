//
//  JobView.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "JobView.h"

@implementation JobView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createInitView];
    }
    return self;
}

-(void) createInitView
{
    jobArray = [[NSMutableArray alloc] init];
    
    jobTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    jobTable.delegate = self;
    jobTable.dataSource = self;
    [self addSubview:jobTable];
    [jobTable release];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [jobArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    JobModel *model = [jobArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = model.jobName;
    return  cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JobModel *model = [jobArray objectAtIndex:indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectJob:withId:)]) {
        [self.delegate selectJob:model.jobName withId:model.id];
    }
    [UIView animateWithDuration:0.3 animations:^{
        jobTable.frame = CGRectMake(0, 0, 320, 0);
    }];
}

-(void) reloadJobs:(NSArray *)array
{
    [UIView animateWithDuration:1.0 animations:^{
        jobTable.frame = CGRectMake(0, 0, 320, SCREEN_HEIGHT-64);//44*array.count);
    }];
    [jobArray removeAllObjects];
    for (JobModel *model in array) {
        [jobArray addObject:model];
    }
    
    [jobTable reloadData];
}

@end
