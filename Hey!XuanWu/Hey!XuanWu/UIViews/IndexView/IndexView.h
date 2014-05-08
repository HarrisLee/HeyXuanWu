//
//  IndexView.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IndexViewDelegate <NSObject>

-(void) goIndexWith:(id)sender;

@end

@interface IndexView : UIView
{
    id<IndexViewDelegate> delegate;
    UIButton *button1;
    UIButton *button2;
    UIButton *button3;
    UIButton *button4;
    UIButton *button5;
    UIButton *button6;
}
@property (nonatomic, assign) id<IndexViewDelegate> delegate;

-(void) setButtonTitle:(NSArray *)titleArray;

@end
