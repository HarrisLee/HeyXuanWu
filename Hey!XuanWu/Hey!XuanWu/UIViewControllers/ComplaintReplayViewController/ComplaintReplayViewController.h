//
//  ComplaintReplayViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "CommentView.h"
#import "ComplaintReplayViewController.h"
#import "GetPeopleOpinionReturnReqBody.h"
#import "GetPeopleOpinionReturnRespBody.h"
#import "AddPeopleOpinionReturnReqBody.h"
#import "AddPeopleOpinionReturnRespBody.h"
#import "OptinReturnModel.h"
#import "ComplaintCell.h"

@interface ComplaintReplayViewController : CommonViewController<CommentViewDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    CommentView     *newsDiscussView;           //新闻评论界面
    CGPoint         point;
    CGPoint         bottomPoint;
    UIView *tview;
    NSMutableArray *reviewArray;
    NSMutableArray *heightArray;
    NSString *fullString;
    NSString *optionId;
}
@property (nonatomic, retain) NSString *optionId;
@end
