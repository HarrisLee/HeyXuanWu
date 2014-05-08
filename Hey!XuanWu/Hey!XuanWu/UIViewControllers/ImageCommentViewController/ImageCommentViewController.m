//
//  ImageCommentViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "ImageCommentViewController.h"

@interface ImageCommentViewController ()

@end

#define NEWSDISCUSS_VIEW_FRAME          CGRectMake(0, 0, 320, SCREEN_HEIGHT)

@implementation ImageCommentViewController
@synthesize imageId;

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
    
    self.title = @"评论";
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
    
    self.imageId = [self.imageId stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    GetImgCommentReqBody *reqBody = [[GetImgCommentReqBody alloc] init];
    reqBody.idImg = self.imageId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:IMG_COMMENT];
    [reqBody release];
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetImgCommentRespBody *respBody = (GetImgCommentRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:IMG_COMMENT];
        [self checkImgComment:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取评论列表详情失败.");
    }];
    [theOperation start];
    [theOperation release];
}

-(void)checkImgComment:(GetImgCommentRespBody *)respBody
{
    if (!respBody.imageCommentArray || [respBody.imageCommentArray count] == 0) {
        return ;
    }
    
    [reviewArray removeAllObjects];
    
    for (ImageCommentModel *model in respBody.imageCommentArray) {
        [reviewArray addObject:model];
        NSString *comment = [NSString stringWithFormat:@"%@:%@",model.accountName,model.comment];
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
        CGSize size = [comment boundingRectWithSize:CGSizeMake(300, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        [heightArray addObject:[NSNumber numberWithFloat:size.height]];
    }
    
    [newsDiscussView.discussTableView reloadData];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [[heightArray objectAtIndex:indexPath.row] floatValue] + 20;
    return height;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [reviewArray count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cellIdentifier";
    ImageCommentModel *model = [reviewArray objectAtIndex:indexPath.row];
    ComplaintCell *cell = (ComplaintCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[ComplaintCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    if (!model.comment) {
        model.comment = @"";
    }
    if (!model.accountName || [model.accountName isEqualToString:@"(null)"]) {
        model.accountName = @"";
    }
    NSString *comment = [NSString stringWithFormat:@"%@:%@",model.accountName,model.comment];
    
    cell.contentLable.text = comment;
    [cell setContent:[[heightArray objectAtIndex:indexPath.row] floatValue] withNothing:YES];
    
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
    AddCommentReqBody *reqBody = [[AddCommentReqBody alloc] init];
    reqBody.imgId = self.imageId;
    reqBody.commentNote = comment;
    reqBody.accountId = [DataCenter shareInstance].loginId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_COMMENT];
    [reqBody release];
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AddCommentRespBody *respBody = (AddCommentRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_COMMENT];
        [self updateImgComment:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"发表评论失败.");
    }];
    [theOperation start];
    [theOperation release];
}

-(void) updateImgComment:(AddCommentRespBody *)respBody
{
    if (![@"\"1\"" isEqualToString:respBody.result]) {
        alertMessage(@"发表评论失败.");
        return ;
    }
    newsDiscussView.discussFiled.text = @"";
    ImageCommentModel *model = [[ImageCommentModel alloc] init];
    model.idImg = self.imageId;
    model.comment = fullString;
    model.addtime = [Utils stringWithDate:[NSDate date] andFormat:@"yyyy/MM/dd HH:mm:ss"];
    model.commentAccountId = [DataCenter shareInstance].loginId;
    model.accountName = [DataCenter shareInstance].loginName;
    [reviewArray insertObject:model atIndex:0];
    
    NSString *comment = [NSString stringWithFormat:@"%@:%@",model.accountName,model.comment];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    CGSize size = [comment boundingRectWithSize:CGSizeMake(300, 3000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    [heightArray insertObject:[NSNumber numberWithFloat:size.height] atIndex:0];
    
    [model release];
    
    [newsDiscussView.discussTableView reloadData];
    
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

-(void) dealloc
{
    [reviewArray release];
    [heightArray release];
    [imageId release];
    [super dealloc];
}

@end
