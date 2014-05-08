//
//  ComplaintViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ComplaintViewController.h"
#import "OutLoginViewController.h"

@interface ComplaintViewController ()

@end

#define NEWSDISCUSS_VIEW_FRAME          CGRectMake(0, 0, 320, SCREEN_HEIGHT)

@implementation ComplaintViewController

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
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [rightButton setImage:[UIImage imageNamed:@"menu_3@2x.png"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"menu_3_v@2x.png"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(sendArticleNews) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tempBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    tempBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem=tempBarButtonItem;
    [tempBarButtonItem release];
    
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
    
    GetPeopleOpinionListReqBody *reqBody = [[GetPeopleOpinionListReqBody alloc] init];
    reqBody.startTime = @"2014/01/01 00:00:00";
    reqBody.endTime = [Utils stringWithDate:[NSDate date] andFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:PEO_OPTIONLIST];
    [reqBody release];
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetPeopleOpinionListRespBody *respBody = (GetPeopleOpinionListRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:PEO_OPTIONLIST];
        [self checkOptinList:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取微心愿列表失败.");
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


-(void)checkOptinList:(GetPeopleOpinionListRespBody *)respBody
{
    
    if (!respBody.peopleOptinArray || [respBody.peopleOptinArray count] == 0) {
        return ;
    }
    
    [reviewArray removeAllObjects];
    
    for (PeopleOptinModel *model in respBody.peopleOptinArray) {
        
        model.addTime = [model.addTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        model.addTime = [model.addTime substringToIndex:19];
        
        [reviewArray addObject:model];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize size = [model.opinionNote boundingRectWithSize:CGSizeMake(300, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
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
    PeopleOptinModel *model = [reviewArray objectAtIndex:indexPath.row];
    ComplaintCell *cell = (ComplaintCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[ComplaintCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
//    cell.nameLabel.text = @"Leex韦德";
//    cell.timeLabel.text = @"2014/03/10 13:55:09";
//    cell.contentLable.text = [reviewArray objectAtIndex:indexPath.row];
    
    if ([model.PeopleName isKindOfClass:[NSNull class]]) {
        model.PeopleName = @"";
    }
    
    cell.nameLabel.text = model.PeopleName;
    cell.timeLabel.text = model.addTime;
    cell.contentLable.text = model.opinionNote;
    
    [cell setContent:[[heightArray objectAtIndex:indexPath.row] floatValue]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PeopleOptinModel *model = [reviewArray objectAtIndex:indexPath.row];
    ComplaintReplayViewController *replay = [[ComplaintReplayViewController alloc] init];
    replay.title = @"回复";
    replay.optionId = model.id;
    [self.navigationController pushViewController:replay animated:YES];
    [replay release];
}

-(void) submitComment:(NSString *)comment
{
    if (![DataCenter shareInstance].isOutLogin) {
        UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您尚未登录，请先登录." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alertView show];
        [alertView release];
        return ;
    }
    if (comment.length==0) {
        alertMessage(@"请输入微心愿");
        return ;
    }
    fullString = [[NSString stringWithFormat:@"%@",comment] retain];
    AddPeopleOpinionReqBody *reqBody = [[AddPeopleOpinionReqBody alloc] init];
    reqBody.addIpAddress = [GetIpAddress deviceIPAdress];
    reqBody.opinionNote = comment;
    reqBody.PeopleId = [DataCenter shareInstance].outLoginId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_PEOOPTION];
    [reqBody release];
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AddPeopleOpinionRespBody *respBody = (AddPeopleOpinionRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_PEOOPTION];
        [self updateOption:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"发表微心愿失败.");
    }];
    [theOperation start];
    [theOperation release];
}

-(void) updateOption:(AddPeopleOpinionRespBody *)respBody
{
    if ([@"\"0\"" isEqualToString:respBody.result]) {
        alertMessage(@"发表微心愿失败.");
        return ;
    }
    newsDiscussView.discussFiled.text = @"";
    PeopleOptinModel *model = [[PeopleOptinModel alloc] init];
    model.PeopleName = [DataCenter shareInstance].outLoginName;
    model.PeopleId = [DataCenter shareInstance].outLoginId;
    model.opinionNote = fullString;
    model.addTime = [Utils stringWithDate:[NSDate date] andFormat:@"yyyy/MM/dd HH:mm:ss"];
    model.addIpAddress = [GetIpAddress deviceIPAdress];
    model.isDel = @"1";
    model.Id = [respBody.result stringByReplacingOccurrencesOfString:@"\"" withString:@""];//换成获取的ID
    [reviewArray insertObject:model atIndex:0];
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize size = [model.opinionNote boundingRectWithSize:CGSizeMake(300, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [heightArray insertObject:[NSNumber numberWithFloat:size.height] atIndex:0];
    
    [model release];
    
    [newsDiscussView.discussTableView reloadData];
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.view endEditing:YES];
        OutLoginViewController *login = [[OutLoginViewController alloc] init];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) sendArticleNews
{
    [self.view endEditing:YES];
    OutLoginViewController *login = [[OutLoginViewController alloc] init];
    login.title = @"登录";
    [UIView  beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.75];
    [self presentViewController:login animated:YES completion:^{}];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    [login release];
}

@end
