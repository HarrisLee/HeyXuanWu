//
//  DetailViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "GetImgReqBody.h"
#import "GetImgRespBody.h"
#import "ImageDetailModel.h"
#import "ImageCommentViewController.h"
#import "AddGoodReqBody.h"
#import "AddGoodRespBody.h"
#import "ImageModel.h"

@interface DetailViewController : CommonViewController<UIAlertViewDelegate,UIScrollViewDelegate>
{
    UIButton *zan;
    UIButton *goComment;
    UILabel *contentView;
    CGSize size;
    ImageModel *indexModel;
    NSMutableArray *modelArray;
    NSInteger index;
    AFHTTPRequestOperation *imageOperation;
}

-(void) setArray:(NSMutableArray *)array withIndex:(NSInteger)number;

@end
