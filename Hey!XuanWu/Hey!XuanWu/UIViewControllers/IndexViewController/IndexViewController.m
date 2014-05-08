//
//  IndexViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-1-26.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "IndexViewController.h"
#import "GetTopDirectoryReqBody.h"
#import "GetTopDirectoryRespBody.h"
#import "DetailViewController.h"
#import "TKViewController.h"
#import "WebSiteViewController.h"
#import "JMWhenTapped.h"

@interface IndexViewController ()

@end

@implementation IndexViewController
@synthesize webSite;

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
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"首页";
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [backButton addTarget:self action:@selector(openSlider) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;
    [temporaryBarButtonItem release];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 65, 320, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:scroll];
    
    indexView = [[IndexView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    indexView.delegate = self;
    indexView.backgroundColor = [UIColor clearColor];
    [scroll addSubview:indexView];
    [indexView release];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"走听转办" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor brownColor]];
    button.layer.cornerRadius = 8.0;
    [button.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    button.frame = CGRectMake(240, SCREEN_HEIGHT - 40, 70, 30);
    [button addTarget:self action:@selector(complaintNavi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *config = [UIButton buttonWithType:UIButtonTypeCustom];
    [config setTitle:@"配置" forState:UIControlStateNormal];
    [config setBackgroundColor:HEXCOLOR(0xff0000)];
    config.layer.cornerRadius = 8.0;
    [config.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    config.frame = CGRectMake(10, SCREEN_HEIGHT - 40, 70, 30);
    [config addTarget:self action:@selector(configIpAddress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:config];
    
    UIButton *web = [UIButton buttonWithType:UIButtonTypeCustom];
    [web setTitle:@"网站" forState:UIControlStateNormal];
    [web setBackgroundColor:[UIColor purpleColor]];
    web.layer.cornerRadius = 8.0;
    [web.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    web.frame = CGRectMake(128, SCREEN_HEIGHT - 40, 70, 30);
    [web addTarget:self action:@selector(webSiteNav) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:web];
    
    [scroll setContentSize:CGSizeMake(320, indexView.frame.size.height)];
    [scroll release];
    
    GetTopDirectoryReqBody *reqBody = [[GetTopDirectoryReqBody alloc] init];
    
    NSMutableURLRequest *urlRequets = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_TOPDIR];
    
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequets];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetTopDirectoryRespBody *respBody = (GetTopDirectoryRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_TOPDIR];
        [self checkData:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，获取一级目录不成功.");
    }];
    
    [theOperation start];
    [theOperation release];
}

/**
 *  获取一级目录回调函数
 *
 *  @param response 返回的数据
 */
-(void)checkData:(GetTopDirectoryRespBody *)response
{
    topArray = [[NSMutableArray alloc] init];
    
    for (FDirectoryModel *model in response.topDirectoryArray) {
        [topArray addObject:model];
        if ([topArray count] >= 6) {
            break ;
        }
    }
    
    [indexView setButtonTitle:topArray];
}

/**
 *  根据点击按钮进入下一级目录
 *
 *  @param sender 点击按钮
 */
-(void) goIndexWith:(id)sender
{
    
    SecondaryViewController *photo = [[SecondaryViewController alloc] init];
    [self.navigationController pushViewController:photo animated:YES];
    [photo release];
    return ;
    
    int index = [sender tag] - 21;
    if (index >= [topArray count]) {
        return ;
    }
    FDirectoryModel *model = [topArray objectAtIndex:index];
    NSLog(@"%@",model.nameTopDirectory);

    SecondaryViewController *second = [[SecondaryViewController alloc] init];
    second.title = model.nameTopDirectory;
    second.directory = model.idTopDirectory;
    [self.navigationController pushViewController:second animated:YES];
    [second release];
}

/**
 *  走听转办
 */
-(void) complaintNavi
{
    TKViewController *complaint = [[TKViewController alloc] init];
    complaint.title = @"走听转办";
    [self.navigationController pushViewController:complaint animated:YES];
    [complaint release];
}

/**
 *  配置IP地址
 */
-(void) configIpAddress
{
    NSString *plistName = [NSString stringWithFormat:@"Config.plist"];
    // 创建本地Plist文件实现缓存
    NSString *plistPath = [Utils documentsPath:plistName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [[NSFileManager defaultManager] createFileAtPath:plistPath contents:dic attributes:nil];
        [dic release];
    }
    NSMutableDictionary *infoDictionary = [[[NSMutableDictionary alloc] initWithContentsOfFile:plistPath] mutableCopy];
    
    UITextView *field = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, 300, 100)];
    field.font = [UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0];
    field.layer.borderWidth = 1.0;
    field.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    field.text = [infoDictionary objectForKey:@"service"];
    
    UIView *configview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    configview.backgroundColor = [UIColor whiteColor];
    [configview whenTapped:^{
        if (field.text.length != 0) {

            [infoDictionary setObject:field.text forKey:@"service"];
            
            [infoDictionary writeToFile:plistPath atomically:YES];
        }
        [configview removeFromSuperview];
    }];
    
    [configview addSubview:field];
    [field release];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:configview];
    [configview release];
}

/**
 *  进入WebSite网站
 */
-(void) webSiteNav
{
    WebSiteViewController *webContrller = [[WebSiteViewController alloc] init];
    webContrller.webSite = self.webSite;
    webContrller.title = @"公告站点";
    [self.navigationController pushViewController:webContrller animated:YES];
    [webContrller release];
}

-(void) openSlider
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
