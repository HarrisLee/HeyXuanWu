//
//  ComplaintCell.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ComplaintCell.h"

@implementation ComplaintCell
@synthesize nameLabel;
@synthesize timeLabel;
@synthesize contentLable;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createInitView];
    }
    return self;
}

-(void) createInitView
{
    UILabel *info = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 15)];
    info.backgroundColor = [UIColor clearColor];
    info.textColor = [UIColor darkGrayColor];
    [info setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:11.0]];
    self.nameLabel = info;
    [self addSubview:info];
    [info release];
    
    info = [[UILabel alloc] initWithFrame:CGRectMake(155, 10, 150, 15)];
    info.backgroundColor = [UIColor clearColor];
    info.textColor = [UIColor darkGrayColor];
    info.textAlignment = NSTextAlignmentRight;
    [info setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:11.0]];
    self.timeLabel = info;
    [self addSubview:info];
    [info release];
    
    info = [[UILabel alloc] initWithFrame:CGRectMake(5, 25, 300, 15)];
    info.backgroundColor = [UIColor clearColor];
    info.textColor = [UIColor darkGrayColor];
    info.numberOfLines = 0;
    [info setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    self.contentLable = info;
    [self addSubview:info];
    [info release];
}

-(void) setContent:(CGFloat)height
{
    self.contentLable.frame = CGRectMake(5, 25, 300, height);
}

-(void) setContent:(CGFloat)height withNothing:(BOOL)flag
{
    if (flag == NO) {
        [self setContent:height];
    } else {
        [self.nameLabel setHidden:YES];
        [self.timeLabel setHidden:YES];
        self.contentLable.frame = CGRectMake(5, 10, 300, height);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc
{
    [nameLabel release];
    [timeLabel release];
    [contentLable release];
    [super dealloc];
}

@end
