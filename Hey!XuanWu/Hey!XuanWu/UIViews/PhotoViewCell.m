//
//  PhotoViewCell.m
//  SilderDeveloperModule
//
//  Created by Cao JianRong on 13-11-28.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#import "PhotoViewCell.h"

@implementation PhotoViewCell
@synthesize imgView;

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
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 130)];
    [img setImage:[UIImage imageNamed:@"2.png"]];
    self.imgView = img;
    [self addSubview:img];
    [img release];
}

-(void) dealloc
{
    [imgView release];
    [super dealloc];
}

@end
