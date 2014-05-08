//
//  PhotoListViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-18.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "WaterFlowView.h"
#import "PhotoViewCell.h"
#import "UIScrollView+PullLoad.h"
#import "GetImgListReqBody.h"
#import "GetImgListRespBody.h"
#import "ImageModel.h"
#import "DetailViewController.h"
#import "UploadFileReqBody.h"
#import "UploadFileRespBody.h"
#import "QBImagePickerController.h"
#import "MBProgressHUD.h"
#import "HUDView.h"

@interface PhotoListViewController : CommonViewController<WaterFlowViewDataSource,WaterFlowViewDelegate,PullDelegate,QBImagePickerControllerDelegate,MBProgressHUDDelegate,HUDViewDelegate>
{
    WaterFlowView *waterFlower;
    NSString *secDirId;
    NSMutableArray *imageArray;
    NSMutableArray *iArray;
    
    NSInteger finishCount;
    NSInteger errorCount;
    MBProgressHUD *HUD;
    HUDView *m_view;
    NSString *nameString;
    NSString *desString;
    BOOL startTag;
    UIWindow *m_window;
}
@property (nonatomic, retain) NSString *secDirId;
@end
