//
//  SelectDayViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "SelectDayViewController.h"

@interface SelectDayViewController ()

@end

@implementation SelectDayViewController
@synthesize delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 320, SCREEN_HEIGHT - 64)];
    [self.view addSubview:bgView];
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [bgView addSubview:calendar];
    [calendar release];
    [bgView release];
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    
    //用[NSDate date]可以获取系统当前时间
    
    currentDateStr = [[dateFormatter stringFromDate:date] retain];
    
    [self chooseDay:currentDateStr];
    NSLog(@"Selected date = %@",currentDateStr);
}

-(void) chooseDay:(NSString *)day
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(chooseDay:)]) {
        [self.delegate chooseDay:day];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    if (currentDateStr) {
        [currentDateStr release];
    }
    [super dealloc];
}

@end
