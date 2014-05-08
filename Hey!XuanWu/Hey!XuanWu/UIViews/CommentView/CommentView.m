//
//  CommentView.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommentView.h"

#define DISCUSSTABLEVIEW_FRAME          CGRectMake(5, 5, 310, viewWithNavNoTabbar-47-7+64)
#define BOTTOM_BACK_FRAME               CGRectMake(0, viewWithNavNoTabbar-47 + 64, 320, 47)
#define TEXTFIELD_BACK_FRAME            CGRectMake(10, 10, 205.5, 27.5)
#define DISCUSSFIELD_FRAME              CGRectMake(20, 16, 185.5, 17)
#define PUBLISH_BUTTON_FRAME            CGRectMake(235, 10, 70, 30)

@implementation CommentView

//@synthesize titleLabel;
@synthesize discussTableView;
@synthesize m_Delegate;
@synthesize bottomBack;
@synthesize discussFiled;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        viewHeader.backgroundColor = [UIColor clearColor];
        UITableView *tableView = [[UITableView alloc] initWithFrame:DISCUSSTABLEVIEW_FRAME];
        tableView.backgroundColor = [UIColor clearColor];
        tableView.tableHeaderView = viewHeader;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.rowHeight = 50;
        self.discussTableView = tableView;
        [viewHeader release];
        [self addSubview:discussTableView];
        [tableView release];
        
        //底部黑色背景
        UIImageView *bottomBackView = [[UIImageView alloc] initWithFrame:BOTTOM_BACK_FRAME];
        self.bottomBack = bottomBackView;
        self.bottomBack.userInteractionEnabled = YES;
        self.bottomBack.image = [UIImage imageNamed:@"table6.png"];
        [self addSubview:self.bottomBack];
        [bottomBackView release];
        
        point = bottomBack.center;
        
        //输入框背景
        UIImageView *textFieldBack = [[UIImageView alloc] initWithFrame:TEXTFIELD_BACK_FRAME];
        textFieldBack.image = [UIImage imageNamed:@"table7.png"];
        [bottomBack addSubview:textFieldBack];
        [textFieldBack release];
        
        UITextField *discussFileds = [[UITextField alloc] initWithFrame:DISCUSSFIELD_FRAME];
        self.discussFiled = discussFileds;
        self.discussFiled.font = [UIFont fontWithName:@"Arial" size:13];
        self.discussFiled.delegate = self;
        self.discussFiled.placeholder = @"请输入评论(200字以内)";
        [bottomBack addSubview:self.discussFiled];
        [discussFileds release];
        
        UIButton *publishBtn = [[UIButton alloc] initWithFrame:PUBLISH_BUTTON_FRAME];
        [publishBtn addTarget:self action:@selector(publishComment) forControlEvents:UIControlEventTouchUpInside];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"button_13.png"] forState:UIControlStateNormal];
        [bottomBack addSubview:publishBtn];
        [publishBtn release];
    }
    return self;
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    self.bottomBack.center = point;
    NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardBounds;
    [keyboardBoundsValue getValue:&keyboardBounds];
    CGPoint changePoint = bottomBack.center;
    changePoint.y -= keyboardBounds.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomBack.center = changePoint;
    }];
    
    NSLog(@"%.2f",keyboardBounds.size.height);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomBack.center = point;
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if ([string isEqualToString:@"&"]) {
        return NO;
    }
    if ([toBeString length] > 200) {
        textField.text = [toBeString substringToIndex:200];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"输入评论内容过长！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return NO;
    }
    
    return YES;
}
- (void)publishComment {
    [discussFiled resignFirstResponder];
    if (m_Delegate && [m_Delegate respondsToSelector:@selector(submitComment:)]) {
        [m_Delegate submitComment:discussFiled.text];
    }
}

- (void)dealloc {
    [discussTableView release];
    [bottomBack release];
    [discussFiled release];
    [super dealloc];
}
@end
