//
//  ImageCommentViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "ImageCommentModel.h"
#import "GetImgCommentReqBody.h"
#import "GetImgCommentRespBody.h"
#import "CommentView.h"
#import "AddCommentReqBody.h"
#import "AddCommentRespBody.h"
#import "ComplaintCell.h"


@interface ImageCommentViewController : CommonViewController<CommentViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    CommentView     *newsDiscussView;           //新闻评论界面
    CGPoint         point;
    CGPoint         bottomPoint;
    UIView *tview;
    NSMutableArray *reviewArray;
    NSMutableArray *heightArray;
    NSString *fullString;
    NSString *imageId;
}
@property (nonatomic, retain) NSString *imageId;
@end
