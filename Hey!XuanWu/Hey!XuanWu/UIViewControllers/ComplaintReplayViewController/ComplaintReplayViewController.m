//
//  ComplaintReplayViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ComplaintReplayViewController.h"
#import "OutLoginViewController.h"

@interface ComplaintReplayViewController ()

@end

#define NEWSDISCUSS_VIEW_FRAME          CGRectMake(0, 0, 320, SCREEN_HEIGHT)

@implementation ComplaintReplayViewController
@synthesize optionId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) viewDidAppear:(BOOL)animated
{
    newsDiscussView.bottomBack.center = bottomPoint;
}

-(void) viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = nil;
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    rightButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
//    [rightButton setImage:[UIImage imageNamed:@"menu_3@2x.png"] forState:UIControlStateNormal];
//    [rightButton setImage:[UIImage imageNamed:@"menu_3_v@2x.png"] forState:UIControlStateHighlighted];
//    [rightButton addTarget:self action:@selector(sendArticleNews) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *tempBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    tempBarButtonItem.style = UIBarButtonItemStylePlain;
//    self.navigationItem.rightBarButtonItem=tempBarButtonItem;
//    [tempBarButtonItem release];
    
    newsDiscussView = [[CommentView alloc] initWithFrame:NEWSDISCUSS_VIEW_FRAME];
    newsDiscussView.m_Delegate = self;
    newsDiscussView.discussTableView.showsVerticalScrollIndicator = NO;
    newsDiscussView.discussTableView.delegate = self;
    newsDiscussView.discussTableView.dataSource = self;
    [self.view addSubview:newsDiscussView];
    [newsDiscussView.discussTableView setRefreshViewColor:[UIColor clearColor]];
    [newsDiscussView release];
    reviewArray = [[NSMutableArray alloc] init];
    heightArray = [[NSMutableArray alloc] init];
    point = newsDiscussView.bottomBack.center;
    bottomPoint = newsDiscussView.bottomBack.center;
    
    tview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT-300)];
    tview.backgroundColor = [UIColor clearColor];
    [tview setHidden:YES];
    [tview whenTapped:^{
        [self.view endEditing:YES];
    }];
    [self.view addSubview:tview];
    [tview release];
    
    GetPeopleOpinionReturnReqBody *reqBody = [[GetPeopleOpinionReturnReqBody alloc] init];
    reqBody.peopleOpinionId= self.optionId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:PEOOPTIONRETURN];
    [reqBody release];
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetPeopleOpinionReturnRespBody *respBody = (GetPeopleOpinionReturnRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:PEOOPTIONRETURN];
        [self checkOptionListComment:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取微心愿评论失败.");
    }];
    [theOperation start];
    [theOperation release];
    
//    [reviewArray addObject:@"sdahkzxcnvjklhfaksdlhfkahsdjkfhaklsdfjhladksdjfhkladjsf"];
//    [reviewArray addObject:@"开发Web等网络应用程序的时候，需要确认网络环境，连接情况等信息。如果没有处理它们，是不会通过Apple的审查的。Apple 的 例程 Reachability 中介绍了取得/检测网络状态的方法。要在应用程序程序中使用Reachability，首先要完成如下两部："];
//    [reviewArray addObject:@"呵呵。"];
//    [reviewArray addObject:@"好的啊啊啊 啊啊"];
//    [reviewArray addObject:@"开发Web等网络应用程序的时候，需要确认网络环境，连接情况等信息。如果没有处理它们，是不会通过Apple的审查的。Apple 的 例程 Reachability 中介绍了取得/检测网络状态的方法。要在应用程序程序中使用Reachability，首先要完成如下两部：开发Web等网络应用程序的时候，需要确认网络环境，连接情况等信息。如果没有处理它们，是不会通过Apple的审查的。Apple 的 例程 Reachability 中介绍了取得/检测网络状态的方法。要在应用程序程序中使用Reachability，首先要完成如下两部：开发Web等网络应用程序的时候，需要确认网络环境，连接情况等信息。如果没有处理它们，是不会通过Apple的审查的。Apple 的 例程 Reachability 中介绍了取得/检测网络状态的方法。要在应用程序程序中使用Reachability，首先要完成如下两部：开发Web等网络应用程序的时候，需要确认网络环境，连接情况等信息。如果没有处理它们，是不会通过Apple的审查的。Apple 的 例程 Reachability 中介绍了取得/检测网络状态的方法。要在应用程序程序中使用Reachability，首先要完成如下两部："];
//    
//    
//    for (NSString *string in reviewArray) {
//        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
//        CGSize size = [string boundingRectWithSize:CGSizeMake(300, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//        [heightArray addObject:[NSNumber numberWithFloat:size.height]];
//    }
//    
//    [newsDiscussView.discussTableView reloadData];
    
}


-(void)checkOptionListComment:(GetPeopleOpinionReturnRespBody *)respBody
{
    
    if (!respBody.optinReturnArray || [respBody.optinReturnArray count] == 0) {
        return ;
    }
    
    [reviewArray removeAllObjects];
    
    for (OptinReturnModel *model in respBody.optinReturnArray) {
        model.addtime = [model.addtime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        model.addtime = [model.addtime substringToIndex:19];
        
        [reviewArray addObject:model];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize size = [model.returnOpinion boundingRectWithSize:CGSizeMake(300, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        [heightArray addObject:[NSNumber numberWithFloat:size.height]];
    }
    
    [newsDiscussView.discussTableView reloadData];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [[heightArray objectAtIndex:indexPath.row] floatValue] + 30.0f;
    return height;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [reviewArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    OptinReturnModel *model = [reviewArray objectAtIndex:indexPath.row];
    ComplaintCell *cell = (ComplaintCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[ComplaintCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
//    cell.nameLabel.text = @"Lexssss睡觉";
//    cell.timeLabel.text = @"2014/03/05 15:00:00";
//    cell.contentLable.text = [reviewArray objectAtIndex:indexPath.row];
    
    if ([model.accountName isKindOfClass:[NSNull class]]) {
        model.accountName = @"";
    }
    
    cell.nameLabel.text = model.accountName;
    cell.timeLabel.text = model.addtime;
    cell.contentLable.text = model.returnOpinion;
    [cell setContent:[[heightArray objectAtIndex:indexPath.row] floatValue]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void) submitComment:(NSString *)comment
{
    if (![DataCenter shareInstance].isLogined) {
        UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您尚未登录，请先登录." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alertView show];
        [alertView release];
        return ;
    }
    
    if (comment.length==0) {
        alertMessage(@"请输入评论内容");
        return ;
    }
    fullString = [comment retain];
    AddPeopleOpinionReturnReqBody *reqBody = [[AddPeopleOpinionReturnReqBody alloc] init];
    reqBody.peopleOpinionId = self.optionId;
    reqBody.returnOpinion = comment;
    reqBody.accountId = [DataCenter shareInstance].loginId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_POPTIONRETURN];
    [reqBody release];
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AddPeopleOpinionReturnRespBody *respBody = (AddPeopleOpinionReturnRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_POPTIONRETURN];
        [self updateOptionReturn:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"发表评论失败.");
    }];
    [theOperation start];
    [theOperation release];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.view endEditing:YES];
        LoginViewController *login = [[LoginViewController alloc] init];
        login.title = @"登录";
        [UIView  beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.75];
        [self presentViewController:login animated:YES completion:^{}];
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
        [UIView commitAnimations];
        [login release];
    }
}

-(void) updateOptionReturn:(AddPeopleOpinionReturnRespBody *)respBody
{
    if ([@"\"0\"" isEqualToString:respBody.result]) {
        alertMessage(@"发表评论失败.");
        return ;
    }
    newsDiscussView.discussFiled.text = @"";
    OptinReturnModel *model = [[OptinReturnModel alloc] init];
    model.Id = respBody.result;
    model.peopleOpinionId = self.optionId;
    model.returnOpinion = fullString;
    model.addtime = [Utils stringWithDate:[NSDate date] andFormat:@"yyyy/MM/dd HH:mm:ss"];
    model.AccountId = [DataCenter shareInstance].loginId;
    model.accountName = [DataCenter shareInstance].loginName;
    model.isDel = @"1";
    [reviewArray insertObject:model atIndex:0];
    [fullString release];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize size = [model.returnOpinion boundingRectWithSize:CGSizeMake(300, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [heightArray insertObject:[NSNumber numberWithFloat:size.height] atIndex:0];
    
    [model release];
    
    [newsDiscussView.discussTableView reloadData];
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    newsDiscussView.bottomBack.center = point;
    NSValue *keyboardBoundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardBounds;
    [keyboardBoundsValue getValue:&keyboardBounds];
    CGPoint changePoint = newsDiscussView.bottomBack.center;
    changePoint.y -= keyboardBounds.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        newsDiscussView.bottomBack.center = changePoint;
    }];
    [tview setHidden:NO];
    if (keyboardBounds.origin.y >= boundsHeight) {
        [UIView animateWithDuration:0.3 animations:^{
            newsDiscussView.bottomBack.frame = CGRectMake(0, boundsHeight - 47 - 64, 320, 47);
            [tview setHidden:YES];
        }];
    }
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void) sendArticleNews
{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.title = @"登录";
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self presentViewController:login animated:YES completion:^{}];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    [login release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [optionId release];
    [heightArray release];
    [reviewArray release];
    [super dealloc];
}

@end
