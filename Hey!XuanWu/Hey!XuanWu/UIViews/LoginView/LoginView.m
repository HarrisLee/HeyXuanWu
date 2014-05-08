//
//  LoginView.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "LoginView.h"
#import "UIView+RectCorner.h"

@implementation LoginView
@synthesize nameField;
@synthesize passField;
@synthesize delegate;
@synthesize registerView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self CreateInitView];
    }
    return self;
}

-(void)CreateInitView
{
    self.backgroundColor = HEXCOLOR(0x7F117C);//rgbaColor(118, 4, 112, 1.0);
    
    topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320,SCREEN_HEIGHT - 64)];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor = HEXCOLOR(0xCECAB0);
    [self addSubview:topView];
    [topView release];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 300, 44)];
    title.textAlignment = NSTextAlignmentLeft;
    title.text = @"登录哟!玄武";
    title.textColor = [UIColor whiteColor];
    [title setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:20]];
    [self addSubview:title];
    [title release];
    
    UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    cancle.frame = CGRectMake(270, 25, 45, 35);
    [cancle.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    [cancle setTitleColor:HEXCOLOR(0xFFFFFF) forState:UIControlStateNormal];
    [cancle setTitleColor:HEXCOLOR(0xEC7B07) forState:UIControlStateHighlighted];
    [cancle setTitle:@"取消" forState:UIControlStateNormal];
    [cancle addTarget:self action:@selector(cancleLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancle];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 20, 200, 0)];
    logoView.backgroundColor = [UIColor yellowColor];
    [topView addSubview:logoView];
    [logoView release];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(60, logoView.frame.origin.y + logoView.frame.size.height + 30, 200, 30)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = HEXCOLOR(0xA0A0A0).CGColor;
    view.layer.borderWidth = 1.0;
    [topView addSubview:view];
    
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 190, 20)];
    self.nameField = name;
    [self.nameField setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    self.nameField.placeholder = @"内部用户名";
    self.nameField.layer.borderWidth = 0.0;
    self.nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:self.nameField];
    [name release];
    [view release];
    
    view = [[UIView alloc] initWithFrame:CGRectMake(60, view.frame.origin.y + view.frame.size.height + 5, 200, 30)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = HEXCOLOR(0xA0A0A0).CGColor;
    view.layer.borderWidth = 1.0;
    [topView addSubview:view];
    
    UITextField *pass = [[UITextField alloc] initWithFrame:CGRectMake( 5, 5, 190, 20)];
    self.passField = pass;
    self.passField.secureTextEntry = YES;
    [self.passField setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    self.passField.placeholder = @"密码";
    self.passField.layer.borderWidth = 0.0;
    self.passField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [view addSubview:self.passField];
    [pass release];
    [view release];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(60, view.frame.origin.y + view.frame.size.height + 10, 200, 35);
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_disable@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateHighlighted];
    [loginButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_highlighted@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateNormal];
    [loginButton.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0]];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginInServer:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:loginButton];
    
//    UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rButton.frame = CGRectMake(180, loginButton.frame.origin.y + loginButton.frame.size.height + 5, 80, 20);
//    [rButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_disable@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateHighlighted];
//    [rButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_highlighted@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateNormal];
//    [rButton.titleLabel setFont:[UIFont systemFontOfSize:11.0]];
//    [rButton setTitle:@"注册账户" forState:UIControlStateNormal];
//    [rButton addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:rButton];
    
    UIView *rview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320,SCREEN_HEIGHT - 64)];
    rview.userInteractionEnabled = YES;
    rview.backgroundColor = HEXCOLOR(0xCECAB0);
    self.registerView = rview;
    [self addSubview:rview];
    [rview release];
    [rview setHidden:YES];
    
    NSArray *array = [NSArray arrayWithObjects:@"请输入账户名称",@"请输入密码",@"请输入真实姓名",@"请输入工作单位",@"请输入手机号码", nil];
    
    for (int i = 0; i<5; i++) {
        UIView *review = [[UIView alloc] initWithFrame:CGRectMake(60, 20+35*i, 200, 30)];
        review.backgroundColor = [UIColor whiteColor];
        review.layer.borderColor = HEXCOLOR(0xA0A0A0).CGColor;
        review.layer.borderWidth = 1.0;
        [rview addSubview:review];
        
        UITextField *rfield = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 190, 20)];
        [rfield setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
        rfield.placeholder = [array objectAtIndex:i];
        rfield.layer.borderWidth = 0.0;
        rfield.tag = kLoginTextTag + i;
        
        if (i==1) {
            rfield.secureTextEntry = YES;
        }
        
        if (i==4) {
            rfield.keyboardType = UIKeyboardTypeNumberPad;
        }
        
        
        rfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [review addSubview:rfield];
        [rfield release];
        [review release];
    }
    
    UIButton *reButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reButton.frame = CGRectMake(60, 195 , 200, 35);
    [reButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_disable@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateHighlighted];
    [reButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_highlighted@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateNormal];
    [reButton.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0]];
    [reButton setTitle:@"注册" forState:UIControlStateNormal];
    [reButton addTarget:self action:@selector(registerInServer:) forControlEvents:UIControlEventTouchUpInside];
    [rview addSubview:reButton];
    
    UIButton *lButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lButton.frame = CGRectMake(180, reButton.frame.origin.y + reButton.frame.size.height + 5, 80, 20);
    [lButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_disable@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateHighlighted];
    [lButton setBackgroundImage:[[UIImage imageNamed:@"common_button_green_highlighted@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateNormal];
    [lButton.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:11.0]];
    [lButton setTitle:@"登录" forState:UIControlStateNormal];
    [lButton addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    [rview addSubview:lButton];
}

/**
 *  登录代理
 *
 *  @param sender 登录按钮
 */
-(void)loginInServer:(id)sender
{
    if (self.nameField.text.length == 0) {
        alertMessage(@"请输入帐号");
        return ;
    }
    
    if (self.passField.text.length == 0) {
        alertMessage(@"请输入密码");
        return ;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginInServer:)]) {
        [self.delegate loginInServer:sender];
    }
}

-(void)registerInServer:(id)sender
{
    NSString *name = [(UITextField *)[self viewWithTag:kLoginTextTag] text];
    
    NSString *pwd = [(UITextField *)[self viewWithTag:kLoginTextTag+1] text];
    
    NSString *tname = [(UITextField *)[self viewWithTag:kLoginTextTag+2] text];
    
    NSString *job = [(UITextField *)[self viewWithTag:kLoginTextTag+3] text];
    
    NSString *phone = [(UITextField *)[self viewWithTag:kLoginTextTag+4] text];
    
    if (name.length == 0 || pwd.length == 0 || tname.length == 0 || job.length == 0 || phone.length == 0 ) {
        alertMessage(@"请确认信息是否输入完整");
        return ;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(registerInService:WithPwd:WithRureName:WithJob:WithMobile:)]) {
        [self.delegate registerInService:name WithPwd:pwd WithRureName:tname WithJob:job WithMobile:phone];
    }
}

-(void)toRegister
{
    [self.registerView setHidden:NO];
    [topView setHidden:YES];
}

-(void) toLogin
{
    [self.registerView setHidden:YES];
    [topView setHidden:NO];
}

/**
 *  退出登录代理
 *
 *  @param sender 取消按钮
 */
-(void)cancleLogin:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancleLogin:)]) {
        [self.delegate cancleLogin:sender];
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

-(void) dealloc
{
    [nameField release];
    [passField release];
    [super dealloc];
}

@end
