//
//  SecondaryViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "SecondDaryCell.h"
#import "PhotoListViewController.h"
#import "GetSecondDirectoryReqBody.h"
#import "GetSecondDirectoryRespBody.h"
#import "SDirectoryModel.h"
#import "AddSecondDirectoryReqBody.h"
#import "AddSecondDirectoryRespBody.h"
#import "SelectDayViewController.h"
#import "GetSecondDirectoryOfTimeReqBody.h"
#import "GetSecondDirectoryOfTimeRespBody.h"
#import "JobView.h"
#import "GetJobReqBody.h"
#import "GetJobRespBody.h"

@interface SecondaryViewController : CommonViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate,DaySelectDelegate,JobViewDelegate>
{
    NSString *directory;
    UITableView *dirTable;
    NSMutableArray *secArray;
    NSMutableArray *serviceArray;
    NSString *dirName;
    
    UIButton *startBtn;
    UIButton *endBtn;
    UIButton *search;
    UIButton *jobBtn;
    NSInteger btnTag;
    
    NSString *jId;
    
    JobView *jobView;
    
    NSMutableArray *jobsArray;
}
@property (nonatomic, retain) NSString *directory;
@end
