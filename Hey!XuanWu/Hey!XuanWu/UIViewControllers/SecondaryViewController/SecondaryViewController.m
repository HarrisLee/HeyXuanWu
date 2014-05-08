//
//  SecondaryViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "SecondaryViewController.h"

@interface SecondaryViewController ()

@end

@implementation SecondaryViewController
@synthesize directory;

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
    self.navigationItem.rightBarButtonItem = nil;

    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [rightButton setImage:[UIImage imageNamed:@"group_edit_createbutton_background@2x.png"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"group_edit_createbutton_background_highlighted@2x.png"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(uploadImage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tempBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    tempBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = tempBarButtonItem;
    [tempBarButtonItem release];


    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 99)];
    viewHeader.backgroundColor = [UIColor clearColor];
    
    startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake(5, 64, 73.5, 35);
    startBtn.tag = 1000;
    startBtn.backgroundColor = [UIColor clearColor];
    [startBtn.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    [startBtn setBackgroundImage:[[UIImage imageNamed:@"common_button_green_disable@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateHighlighted];
    [startBtn setBackgroundImage:[[UIImage imageNamed:@"common_button_green_highlighted@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateNormal];
    [startBtn setTitle:@"开始日期" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(pickTime:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:startBtn];
    
    endBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    endBtn.frame = CGRectMake(83.5, 64, 73.5, 35);
    endBtn.tag = 2000;
    endBtn.backgroundColor = [UIColor clearColor];
    [endBtn.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    [endBtn setBackgroundImage:[[UIImage imageNamed:@"common_button_green_disable@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateHighlighted];
    [endBtn setBackgroundImage:[[UIImage imageNamed:@"common_button_green_highlighted@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateNormal];
    [endBtn setTitle:@"结束日期" forState:UIControlStateNormal];
    [endBtn addTarget:self action:@selector(pickTime:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:endBtn];
    
    jobBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    jobBtn.frame = CGRectMake(162, 64, 73.5, 35);
    jobBtn.tag = 3000;
    jobBtn.backgroundColor = [UIColor clearColor];
    [jobBtn.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    [jobBtn setBackgroundImage:[[UIImage imageNamed:@"common_button_green_disable@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateHighlighted];
    [jobBtn setBackgroundImage:[[UIImage imageNamed:@"common_button_green_highlighted@2x.png"] stretchableImageWithLeftCapWidth:15 topCapHeight:1] forState:UIControlStateNormal];
    [jobBtn setTitle:@"活动单位" forState:UIControlStateNormal];
    [jobBtn addTarget:self action:@selector(pickCompany:) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:jobBtn];
    
    search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(240.5, 65, 73.5, 33);
    search.layer.cornerRadius = 8.0;
    search.backgroundColor = [UIColor blueColor];
    [search.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    [search setTitle:@"搜索" forState:UIControlStateNormal];
    [search addTarget:self action:@selector(searchSecDir) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:search];
    
    dirTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT) style:UITableViewStylePlain];
    dirTable.tableHeaderView = viewHeader;
    dirTable.delegate = self;
    dirTable.dataSource = self;
    if ([dirTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [dirTable setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:dirTable];
    [viewHeader release];
    [dirTable release];

    [dirTable setContentOffset:CGPointMake(0, 35)];
    
    secArray = [[NSMutableArray alloc] init];
    
    serviceArray = [[NSMutableArray alloc] init];
    
    jobsArray = [[NSMutableArray alloc] init];
    
    jId = @"";
    
    self.directory = [self.directory stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    GetSecondDirectoryReqBody *reqBody = [[GetSecondDirectoryReqBody alloc] init];
    
    reqBody.idTopDirectory = self.directory;

    NSMutableURLRequest *urlRequets = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GETSECDIR];
    
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequets];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetSecondDirectoryRespBody *respBody = (GetSecondDirectoryRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GETSECDIR];
        [self checkData:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求失败，获取二级目录不成功.");
    }];
    [theOperation start];
    [theOperation release];
    
    jobView = [[JobView alloc] initWithFrame:CGRectMake(0, 64, 320, 0)];
    jobView.delegate = self;
    [self.view addSubview:jobView];
    [jobView setHidden:YES];
}

-(void)checkData:(GetSecondDirectoryRespBody *)response
{
    if (!response.sDirectoryArray || [response.sDirectoryArray count] == 0) {
        return ;
    }
    
    [secArray removeAllObjects];
    [serviceArray removeAllObjects];
    
    [dirTable setContentOffset:CGPointMake(0, 35)];
    
    for (SDirectoryModel *model in response.sDirectoryArray) {
        [secArray addObject:model];
        [serviceArray addObject:model];
    }
    
    [dirTable reloadData];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [secArray count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.0f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    view.backgroundColor = [UIColor grayColor];
    return [view autorelease];
}


-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Section标题";
}
 */

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"rowIdentifier";
    
    SDirectoryModel *model = [secArray objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = model.nameSecondDirectory;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SDirectoryModel *model = [secArray objectAtIndex:indexPath.row];
    PhotoListViewController *list = [[PhotoListViewController alloc] init];
    list.title = model.nameSecondDirectory;
    list.secDirId = model.idSecondDirectory;
    [self.navigationController pushViewController:list animated:YES];
    [list release];
}

/**
 *    新建目录
 */
-(void) uploadImage
{
    if (![DataCenter shareInstance].isLogined) {
        LoginViewController *login = [[LoginViewController alloc] init];
        login.title = @"登录";
        [UIView  beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [self presentViewController:login animated:YES completion:^{}];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
        [login release];
        return ;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"请输入活动主题"delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView textFieldAtIndex:0].keyboardType = UIKeyboardTypeDefault;
    [alertView textFieldAtIndex:0].delegate = self;
    [alertView show];
    [alertView release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d",buttonIndex);
    if ([dirName length] == 0) {
        return ;
    }
    if (buttonIndex == 1) {   //创建相册
        AddSecondDirectoryReqBody *reqBody = [[AddSecondDirectoryReqBody alloc] init];
        reqBody.idTopDirectory = [self.directory stringByReplacingOccurrencesOfString:@" " withString:@""];
        reqBody.nameSecondDirectory = dirName;
        reqBody.addAccountId = [DataCenter shareInstance].loginId;
        
        NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_SECDIR];
        
        [reqBody release];
        
        AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            AddSecondDirectoryRespBody *respBody = (AddSecondDirectoryRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_SECDIR];
            [self addSecDirSuccess:respBody];
            NSLog(@"%@",respBody.accountId);
            
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error : %@", [error localizedDescription]);
            alertMessage(@"创建活动主题失败,请重新创建.");
        }];
        [theOperation start];
        [theOperation release];
    }
}

-(void) addSecDirSuccess:(AddSecondDirectoryRespBody *)respBody
{
    if ([@"\"0\"" isEqualToString:respBody.accountId]) {
        alertMessage(@"创建活动主题失败.请重新创建");
        return ;
    }
    
    SDirectoryModel *model = [[SDirectoryModel alloc] init];
    model.idSecondDirectory = respBody.accountId;
    model.nameSecondDirectory = dirName;
    [secArray addObject:model];
    [serviceArray addObject:model];
    [model release];
    [dirTable reloadData];
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    dirName = [textField.text retain];
    NSLog(@"%@",dirName);
}

/**
 *    根据时间进行目录搜索
 */
-(void) searchSecDir
{
    //去除搜索结果
    if ([[search currentTitle] hasSuffix:@"结果"]) {
        [search setTitle:@"搜索" forState:UIControlStateNormal];
        [secArray removeAllObjects];
        for (SDirectoryModel *model in serviceArray) {
            [secArray addObject:model];
        }
        [dirTable reloadData];
        return ;
    }
    NSString *start = [startBtn currentTitle];
    NSString *endStr = [endBtn currentTitle];
    if ([jId isEqualToString:@""] || [jId length] == 0) {
        alertMessage(@"您尚未选择活动单位。");
        return ;
    }
    if ([start hasSuffix:@"时间"]||[endStr hasSuffix:@"时间"]) {
        alertMessage(@"请确认开始时间和结束时间都已选择");
        return ;
    }
    
    if (![self earlyDay:start compareWithAnotherDay:endStr]) {
        alertMessage(@"请确认开始时间不晚于结束时间");
        return ;
    }
    
    start = [start stringByAppendingString:@" 00:00:00"];
    endStr = [endStr stringByAppendingString:@" 23:59:59"];
    NSLog(@"%@,%@",start,endStr);
    
    GetSecondDirectoryOfTimeReqBody *reqBody = [[GetSecondDirectoryOfTimeReqBody alloc] init];
    reqBody.startTime = start;
    reqBody.endTime = endStr;
    reqBody.jobId = jId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:SEC_DIROFTIME];
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetSecondDirectoryOfTimeRespBody *respBody = (GetSecondDirectoryOfTimeRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:SEC_DIROFTIME];
        [self pickData:respBody];
        NSLog(@"%@",respBody.searchArray);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"搜索活动主题失败,请重新搜索.");
    }];
    [theOperation start];
    [theOperation release];
}

-(BOOL) earlyDay:(NSString *)date compareWithAnotherDay:(NSString *)anotherDay
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd"];
    format.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 3600];
    
    NSDate *d1 = [format dateFromString:date];
    NSDate *d2 = [format dateFromString:anotherDay];
    
    NSDate *dat = [d1 earlierDate:d2];

    if ([[format stringFromDate:dat] isEqualToString:date]) {
        return YES;
    } else {
        return NO;
    }
}

-(void)pickData:(GetSecondDirectoryOfTimeRespBody *)response
{
    if (!response.searchArray || [response.searchArray count] == 0) {
        return ;
    }
    
    [search setTitle:@"清除结果" forState:UIControlStateNormal];
    
    [secArray removeAllObjects];
    
    [dirTable setContentOffset:CGPointMake(0, 35)];
    
    for (SDirectoryModel *model in response.searchArray) {
        [secArray addObject:model];
    }
    
    [dirTable reloadData];
}

-(void) pickTime:(id)sender
{
    if ([[search currentTitle] hasSuffix:@"结果"]) {
        [search setTitle:@"搜索" forState:UIControlStateNormal];
    }
    btnTag = [sender tag];
    SelectDayViewController *select = [[SelectDayViewController alloc] init];
    select.delegate = self;
    [self.navigationController pushViewController:select animated:YES];
    [select release];
}

-(void) chooseDay:(NSString *)day
{
    NSLog(@"choose day is %@",day);
    if (btnTag == 1000) {
        [startBtn setTitle:day forState:UIControlStateNormal];
    } else {
        [endBtn setTitle:day forState:UIControlStateNormal];
    }
}

/**
 *  选择活动单位
 *
 *  @param sender 按钮
 */
-(void) pickCompany:(id) sender
{
    GetJobReqBody *reqBody = [[GetJobReqBody alloc] init];
    
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:GET_JOB];
    
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetJobRespBody *respBody = (GetJobRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:GET_JOB];
        [self updateJobView:respBody];
        NSLog(@"%@",respBody.jobArray);
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取单位列表失败，请重新请求.");
    }];
    [theOperation start];
    [theOperation release];
    
    
    

}

-(void) updateJobView:(GetJobRespBody *)respBody
{
    if (!respBody.jobArray || [respBody.jobArray count] == 0) {
        return ;
    }
    
    [jobsArray removeAllObjects];
    
    for (JobModel *model in respBody.jobArray) {
        [jobsArray addObject:model];
    }
    
    [jobView reloadJobs:jobsArray];
    
    [jobView setHidden:NO];
    if (jobView.frame.size.height == 0) {
        [UIView animateWithDuration:1.0 animations:^{
            jobView.frame = CGRectMake(0, 64, 320, SCREEN_HEIGHT-64);
        }];
    }
    
    
}

/**
 *  选择活动单位回调
 *
 *  @param jobName 活动单位
 *  @param jobId   活动单位ID
 */
-(void) selectJob:(NSString *)jobName withId:(NSString *)jobId
{
    [UIView animateWithDuration:0.3 animations:^{
        [jobView setHidden:YES];
    }];
    
    [jobBtn setTitle:jobName forState:UIControlStateNormal];
    if (jId.length > 0) {
        [jId release];
    }
    
    jobId = [jobId stringByReplacingOccurrencesOfString:@" " withString:@""];
    jobId = [jobId stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    jId = [jobId retain];
    
    [jobBtn setTitle:jobName forState:UIControlStateNormal];
    
    NSLog(@"%@_%@",jobName,jobId);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [jobView release];
    [directory release];
    [secArray release];
    [super dealloc];
}

@end
