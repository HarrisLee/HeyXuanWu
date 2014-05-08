//
//  SecondDaryCell.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "SecondDaryCell.h"

@implementation SecondDaryCell
@synthesize detailImage;
@synthesize nameLabel;

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
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    img.layer.borderColor = [UIColor lightGrayColor].CGColor;
    img.layer.borderWidth = 2.0;
    img.layer.shadowColor = [UIColor redColor].CGColor;
    img.layer.shadowOffset = CGSizeMake(3.0, 3.0);
    img.layer.cornerRadius = 5.0;
    img.layer.shadowRadius = 5.0;
    self.detailImage = img;
    [self addSubview:img];
    [img release];
 
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(55, 15, 260, 20)];
    [name setTextColor:[UIColor redColor]];
    name.backgroundColor = [UIColor clearColor];
    [name setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    self.nameLabel = name;
    [self addSubview:name];
    [name release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) dealloc
{
    [detailImage release];
    [nameLabel release];
    [super dealloc];
}

@end
