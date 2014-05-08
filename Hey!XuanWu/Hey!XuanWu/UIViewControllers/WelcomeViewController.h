//
//  WelcomeViewController.h
//  LuxuryA4L
//
//  Created by Cao JianRong on 13-12-10.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "IndexViewController.h"
#import "GetMainInfoReqBody.h"
#import "GetMainInfoRespBody.h"

@interface WelcomeViewController : CommonViewController
{
    IndexViewController *indexView;
    UIImageView   *imgView;
    UILabel *info;
    UILabel *dateInfo;
    UILabel *tips;
    NSString *webSite;
}

@end
