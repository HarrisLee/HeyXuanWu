//
//  CommentView.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentViewDelegate <NSObject>
//提交评论内容
- (void)submitComment:(NSString*)comment;

@end

@interface CommentView : UIView<UITextFieldDelegate>
{
    //    UILabel     *titleLabel;            //新闻标题
    UITableView *discussTableView;      //评论内容表
    UIImageView *bottomBack;            //底部黑色背景
    UITextField *discussFiled;          //评论填写区
    id <CommentViewDelegate> m_Delegate;
    CGPoint point;
}
//@property (retain,nonatomic) UILabel     *titleLabel;
@property (retain,nonatomic) UITableView *discussTableView;
@property (retain,nonatomic) UIImageView *bottomBack;
@property (retain,nonatomic) UITextField *discussFiled;
@property (assign,nonatomic) id <CommentViewDelegate> m_Delegate;
@end
