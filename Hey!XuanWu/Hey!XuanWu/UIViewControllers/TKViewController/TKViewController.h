//
//  TKViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "ComplaintViewController.h"
#import "SecondaryViewController.h"

@interface TKViewController : CommonViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *indexArray;
}
@end
