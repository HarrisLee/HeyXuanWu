//
//  IndexView.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "IndexView.h"

@implementation IndexView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self CreateIndexView];
    }
    return self;
}

-(void) CreateIndexView
{
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0f]];
    button1.frame = CGRectMake(7, 5, kButtonWidth, kButtonHeight);
    button1.layer.cornerRadius = 8.0;
    [button1 setTitle:@"1" forState:UIControlStateNormal];
    button1.tag = kIndexTag + 1;
    [button1 addTarget:self action:@selector(goIndexWith:) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor = HEXCOLOR(0x96CCDB);
    [self addSubview:button1];
    
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0f]];
    button2.frame = CGRectMake(215, 5, kButtonWidthMin, kButtonHeiMin);
    button2.layer.cornerRadius = 4.0;
    [button2 setTitle:@"2" forState:UIControlStateNormal];
    button2.tag = kIndexTag + 2;
    [button2 addTarget:self action:@selector(goIndexWith:) forControlEvents:UIControlEventTouchUpInside];
    button2.backgroundColor = HEXCOLOR(0xE3B331);
    [self addSubview:button2];
    
    button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0f]];
    button3.frame = CGRectMake(215, 86, kButtonWidthMin, kButtonHeiMin);
    button3.layer.cornerRadius = 4.0;
    [button3 setTitle:@"3" forState:UIControlStateNormal];
    button3.tag = kIndexTag + 3;
    [button3 addTarget:self action:@selector(goIndexWith:) forControlEvents:UIControlEventTouchUpInside];
    button3.backgroundColor = HEXCOLOR(0x99BA3E);
    [self addSubview:button3];
    
    button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button4.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0f]];
    button4.frame = CGRectMake(7, 168, kButtonWidthMin, kButtonHeiMin);
    button4.layer.cornerRadius = 4.0;
    [button4 setTitle:@"4" forState:UIControlStateNormal];
    button4.tag = kIndexTag + 4;
    [button4 addTarget:self action:@selector(goIndexWith:) forControlEvents:UIControlEventTouchUpInside];
    button4.backgroundColor = HEXCOLOR(0x4D7ED0);
    [self addSubview:button4];
    
    button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button5.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0f]];
    button5.frame = CGRectMake(7, 249, kButtonWidthMin, kButtonHeiMin);
    button5.layer.cornerRadius = 4.0;
    [button5 setTitle:@"5" forState:UIControlStateNormal];
    button5.tag = kIndexTag+5;
    [button5 addTarget:self action:@selector(goIndexWith:) forControlEvents:UIControlEventTouchUpInside];
    button5.backgroundColor = HEXCOLOR(0x68479B);
    [self addSubview:button5];
    
    button6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button6.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0f]];
    button6.frame = CGRectMake(111, 168, kButtonWidth, kButtonHeight);
    button6.layer.cornerRadius = 8.0;
    [button6 setTitle:@"6" forState:UIControlStateNormal];
    button6.tag = kIndexTag+6;
    [button6 addTarget:self action:@selector(goIndexWith:) forControlEvents:UIControlEventTouchUpInside];
    button6.backgroundColor = HEXCOLOR(0xC35C21);
    [self addSubview:button6];
}

-(void) setButtonTitle:(NSArray *)titleArray
{
    if (!titleArray || [titleArray count]==0) {
        return ;
    }
    
    for (int i = 0; i<titleArray.count; i++) {
        UIButton *button = (UIButton *)[self viewWithTag:kIndexTag+i+1];
        [button setTitle:[[titleArray objectAtIndex:i] nameTopDirectory] forState:UIControlStateNormal];
    }
    
    
}

-(void) goIndexWith:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(goIndexWith:)]) {
        [self.delegate goIndexWith:sender];
    }
}

@end
