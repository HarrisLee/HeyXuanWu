//
//  AppDelegate.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-1-26.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    RootNavViewController *m_RootNavCtr;
}
@property (strong, nonatomic) UIWindow *window;

@property (retain,nonatomic)  RootNavViewController *m_RootNavCtr;

@end
