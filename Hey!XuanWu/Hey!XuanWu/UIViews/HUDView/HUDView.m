//
//  HUDView.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-13.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "HUDView.h"

@implementation HUDView
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
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(60, 80, 200, 30)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = HEXCOLOR(0xA0A0A0).CGColor;
    view.layer.borderWidth = 1.0;
    [self addSubview:view];
    
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 190, 20)];
    nameField = name;
    [nameField setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    nameField.placeholder = @"请输入名称";
    nameField.layer.borderWidth = 0.0;
    nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:nameField];
    [name release];
    [view release];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(60, view.frame.origin.y + view.frame.size.height + 5, 200, 30)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = HEXCOLOR(0xA0A0A0).CGColor;
    view.layer.borderWidth = 1.0;
    [self addSubview:view];
    
    UITextField *pass = [[UITextField alloc] initWithFrame:CGRectMake( 5, 5, 190, 20)];
    passField = pass;
    [passField setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    passField.placeholder = @"请输入描述";
    passField.layer.borderWidth = 0.0;
    passField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:passField];
    [pass release];
    [view release];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(60, view.frame.origin.y + view.frame.size.height + 10, 95, 35);
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_disable@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateHighlighted];
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_highlighted@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0]];
    [loginButton setTitle:@"取消" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(cancleView:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:loginButton];
    
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle.frame = CGRectMake(165, view.frame.origin.y + view.frame.size.height + 10, 95, 35);
    [cancle setBackgroundImage:[[UIImage imageNamed:@"common_button_green_disable@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateHighlighted];
    [cancle setBackgroundImage:[[UIImage imageNamed:@"common_button_green_highlighted@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateNormal];
    [cancle.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0]];
    [cancle setTitle:@"创建" forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(addDescribe:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancle];
    
}

-(void) addDescribe:(id)sender
{
    if (nameField.text.length == 0 || passField.text.length == 0) {
        alertMessage(@"请确保图片名称和描述输入完整。");
        return ;
    }
    
    if (nameField.text.length >= 50 || passField.text.length >= 50) {
        alertMessage(@"请确保图片名称和描述在50字以内。");
        return ;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setPhotoInfo:withDescribeString:)]) {
        [self.delegate setPhotoInfo:nameField.text withDescribeString:passField.text];
    }
}

-(void) cancleView:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancleView)]) {
        [self.delegate cancleView];
    }
}


@end
