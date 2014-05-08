//
//  SelectDayViewController.h
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "VRGCalendarView.h"

@protocol DaySelectDelegate <NSObject>

-(void) chooseDay:(NSString *)day;

@end

@interface SelectDayViewController : CommonViewController<VRGCalendarViewDelegate>
{
    NSString    *currentDateStr;
    id<DaySelectDelegate> delegate;
}
@property (nonatomic, assign) id<DaySelectDelegate> delegate;
@end
