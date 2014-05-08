//
//  IndexViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-1-26.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "QBImagePickerController.h"
#import "LoginViewController.h"
#import "AFJSONRequestOperation.h"
#import "SecondaryViewController.h"
#import "IndexView.h"
#import "FDirectoryModel.h"

@interface IndexViewController : CommonViewController <IndexViewDelegate>
{
    IndexView *indexView;
    NSMutableArray *topArray;
    NSString *webSite;
}
@property (nonatomic, retain) NSString *webSite;

@end
