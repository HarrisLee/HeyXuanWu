//
//  WelcomeViewController.m
//  LuxuryA4L
//
//  Created by Cao JianRong on 13-12-10.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

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
    imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
//    [imgView setImage:[[UIImage imageNamed:@"gradient7.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:1]];
    imgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imgView];
    [imgView release];
    
    tips = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 320, 20)];
    tips.text = @"公告";
    tips.textAlignment = NSTextAlignmentCenter;
    tips.textColor = [UIColor purpleColor];
    tips.backgroundColor = [UIColor clearColor];
    [tips setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:17.0f]];
    [self.view addSubview:tips];
    [tips release];
    [tips setHidden:YES];
    
    info = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, SCREEN_HEIGHT-80)];
    info.numberOfLines = 0;
    info.textAlignment = NSTextAlignmentLeft;
    info.backgroundColor = [UIColor clearColor];
    info.textColor = [UIColor purpleColor];
    [info setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0f]];
    [self.view addSubview:info];
    [info release];
    
    dateInfo = [[UILabel alloc] initWithFrame:CGRectMake(10, 100, 300, SCREEN_HEIGHT-80)];
    dateInfo.textAlignment = NSTextAlignmentRight;
    dateInfo.backgroundColor = [UIColor clearColor];
    dateInfo.textColor = [UIColor purpleColor];
    [dateInfo setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0f]];
    [self.view addSubview:dateInfo];
    [dateInfo release];
    
    GetMainInfoReqBody *reqBody = [[GetMainInfoReqBody alloc] init];
    
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_MAIN];
    
    [reqBody release];

    AFHTTPRequestOperation *theOpertion = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOpertion setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        GetMainInfoRespBody *respBody = (GetMainInfoRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_MAIN];
        [self updateInfo:respBody];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        alertMessage(@"请求失败，未获取到公告信息");
        [self performSelector:@selector(playWelcome) withObject:nil afterDelay:0.1];
    }];
    [theOpertion start];
    [theOpertion release];
}

-(void) updateInfo:(GetMainInfoRespBody *)respBody
{
    if (!respBody.workInfo || [respBody.workInfo length]==0) {
        return ;
    }
    [self performSelector:@selector(playWelcome) withObject:nil afterDelay:0.1];
    [tips setHidden:NO];
    
    info.text = respBody.workInfo;
    NSString *date = respBody.addTime;
    if (!date.length || date.length < 10) {
        date = @"";
    } else {
        date = [date substringToIndex:10];
    }
    
    info.text = [NSString stringWithFormat:@"      %@",info.text];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize size = [info.text boundingRectWithSize:CGSizeMake(300, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    info.frame = CGRectMake(10, 100, 300, size.height);
    
    dateInfo.frame = CGRectMake(10, info.frame.origin.y + size.height + 30, 300, 20);
    dateInfo.text = date;
    
    webSite = [respBody.webSite retain];
}

/**
 *  播放欢迎页面的动画效果
 */
-(void) playWelcome
{
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scale setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [scale setFromValue:[NSNumber numberWithFloat:1.0]];
    [scale setToValue:[NSNumber numberWithFloat:1.5]];
    [scale setDuration:kShowTime];
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [rotation setFromValue:[NSNumber numberWithFloat:1.0]];
    [rotation setToValue:[NSNumber numberWithFloat:0.5]];
    [rotation setDuration:kShowTime];
    [rotation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = kShowTime;
    group.autoreverses = NO;
    [group setDelegate:self];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [group setAnimations:[NSArray arrayWithObjects:scale,rotation,nil]];
    
    [imgView.layer addAnimation:group forKey:@"animation"];
}

/**
 *  动画结束后进入到首页
 *
 *  @param anim 动画参数
 *  @param flag 动画播放是否结束
 */
-(void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [imgView setAlpha:0.0];
    indexView = [[IndexViewController alloc] init];
    indexView.webSite = webSite;
    [self.navigationController pushViewController:indexView animated:NO];
    [indexView release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [webSite release];
    [super dealloc];
}

@end
