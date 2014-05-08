//
//  HUDView.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-13.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HUDViewDelegate <NSObject>

-(void) setPhotoInfo:(NSString *)name withDescribeString:(NSString *)describe;

-(void) cancleView;

@end

@interface HUDView : UIView
{
    UITextField *nameField;
    UITextField *passField;
    id<HUDViewDelegate> delegate;
}
@property (nonatomic, assign) id<HUDViewDelegate> delegate;
@end
