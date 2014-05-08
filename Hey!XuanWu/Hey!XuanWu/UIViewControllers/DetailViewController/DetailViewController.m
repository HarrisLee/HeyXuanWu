//
//  DetailViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-6.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        modelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void) setArray:(NSMutableArray *)array withIndex:(NSInteger)number
{
    for (ImageModel *model in array) {
        [modelArray addObject:model];
    }
    index = number;
    indexModel = [modelArray objectAtIndex:index];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 69, 320, SCREEN_HEIGHT- 64 - 50)];
    scroller.delegate = self;
    scroller.pagingEnabled = YES;
    scroller.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scroller];
    for (int i = 0; i<modelArray.count; i++) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, SCREEN_HEIGHT-64-50)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.tag = kImageViewTag+i;
        bgView.contentMode = UIViewContentModeScaleAspectFill;
        bgView.clipsToBounds = YES;
        [bgView setBackgroundColor:[UIColor blackColor]];
        [scroller addSubview:bgView];
        [bgView release];
    }
    [scroller setContentSize:CGSizeMake(320*modelArray.count, SCREEN_HEIGHT-64-50)];
    [scroller setContentOffset:CGPointMake(320*index, 0)];
    [scroller release];

    UIImageView *indexView = (UIImageView *)[self.view viewWithTag:kImageViewTag+index];
    [indexView setImageWithURL:[NSURL URLWithString:indexModel.virtualPath] placeholderImage:[UIImage imageNamed:@"2.png"]];
    
    UIImageView *bottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, 320, 40)];
    [bottom setImage:[UIImage imageNamed:@"bottomView.png"]];
    bottom.userInteractionEnabled = YES;
    [self.view addSubview:bottom];
    [bottom release];
    
    zan = [UIButton buttonWithType:UIButtonTypeCustom];
    [zan setBackgroundImage:[UIImage imageNamed:@"empty_like@2x.png"] forState:UIControlStateNormal];
    [zan setBackgroundImage:[UIImage imageNamed:@"preview_like_icon@2x.png"] forState:UIControlStateHighlighted];
    zan.frame = CGRectMake(10, 7.5, 25, 25);
    [zan addTarget:self action:@selector(addGoodMessage) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:zan];
    
    UIButton *comment = [UIButton buttonWithType:UIButtonTypeCustom];
    [comment setBackgroundImage:[UIImage imageNamed:@"empty_comment.png"] forState:UIControlStateNormal];
    [comment setBackgroundImage:[UIImage imageNamed:@"empty_comment.png"] forState:UIControlStateHighlighted];
    comment.frame = CGRectMake(45, 7.5, 25, 25);
    [comment addTarget:self action:@selector(ShowContentView) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:comment];
    
    goComment = [UIButton buttonWithType:UIButtonTypeCustom];
    goComment.frame = CGRectMake(220, 7.5, 100, 25);
    goComment.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    NSString *title = @"赞0  评论";
    [goComment setTitle:title forState:UIControlStateNormal];
    [goComment.titleLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    [goComment setImage:[UIImage imageNamed:@"common_icon_arrow@2x.png"] forState:UIControlStateNormal];
    goComment.imageEdgeInsets = UIEdgeInsetsMake(5, 88, 5, 0);
    [goComment addTarget:self action:@selector(goCommentView) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:goComment];
    
    contentView = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, 320, 100)];
    contentView.textColor = [UIColor whiteColor];
    contentView.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.7];
    [contentView setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:13.0]];
    contentView.numberOfLines = 0;
    [self.view addSubview:contentView];
    [contentView release];
    
    
    GetImgReqBody *reqBody = [[GetImgReqBody alloc] init];
    reqBody.idImg = [NSString stringWithFormat:@"%d",[indexModel.idImg intValue]];
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:IMG];
    [reqBody release];
    imageOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [imageOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetImgRespBody *respBody = (GetImgRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:IMG];
        [self checkImg:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取照片详情失败.");
    }];
    [imageOperation start];
    
}

-(void) checkImg:(GetImgRespBody *) respBody
{
    if (!respBody.model.idImg) {
        alertMessage(@"获取照片详情失败.");
        return ;
    }
    NSString *content = respBody.model.describeImg;
    contentView.text = content;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13]};
    size = [content boundingRectWithSize:CGSizeMake(320, 1000) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    [contentView whenTapped:^{
        [UIView animateWithDuration:0.5 animations:^{
            contentView.frame = CGRectMake(0, SCREEN_HEIGHT, size.width, size.height);
        }];
    }];
    
    NSString *title = [NSString stringWithFormat:@"赞%@  评论",respBody.model.goodCount];
    [goComment setTitle:title forState:UIControlStateNormal];
}

-(void) addGoodMessage
{
    if (![DataCenter shareInstance].isLogined) {
        UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您尚未登录，请先登录." delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alertView show];
        [alertView release];
        return ;
    }
    
    AddGoodReqBody *reqBody = [[AddGoodReqBody alloc] init];
    reqBody.imgId = [NSString stringWithFormat:@"%d",[indexModel.idImg intValue]];
    reqBody.AccountId = [DataCenter shareInstance].loginId;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:ADD_GOOD];
    [reqBody release];
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AddGoodRespBody *respBody = (AddGoodRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_GOOD];
        [self checkGood:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"点赞失败，请重新赞一次.");
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

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"%.2f,%.2f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    
    NSString *title = [NSString stringWithFormat:@"赞0  评论"];
    [goComment setTitle:title forState:UIControlStateNormal];
    contentView.text = @"";
    [zan setEnabled:YES];
    

    NSInteger tag = scrollView.contentOffset.x/320;
    index = tag;
    indexModel = [modelArray objectAtIndex:tag];
    
    
    self.title = indexModel.nameImg;
    UIImageView *indexView = (UIImageView *)[self.view viewWithTag:kImageViewTag+index];
    [indexView setImageWithURL:[NSURL URLWithString:indexModel.virtualPath] placeholderImage:[UIImage imageNamed:@"2.png"]];
    
    if (!imageOperation.isFinished) {
        [imageOperation resume];
    }
    [imageOperation release];
    GetImgReqBody *reqBody = [[GetImgReqBody alloc] init];
    reqBody.idImg = [NSString stringWithFormat:@"%d",[indexModel.idImg intValue]];
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:IMG];
    [reqBody release];
    imageOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [imageOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        GetImgRespBody *respBody = (GetImgRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:IMG];
        [self checkImg:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"获取照片详情失败.");
    }];
    [imageOperation start];
}

-(void)checkGood:(AddGoodRespBody *)respBody
{
    if ([respBody.result isEqualToString:@"-1"]) {
        alertMessage(@"点赞失败,请重新尝试");
        return ;
    }
    
    if ([respBody.result isEqualToString:@"\"0\""]) {
        alertMessage(@"已经点赞了.请勿重复点赞");
        return ;
    }
    
    NSString *title = [[respBody.result substringToIndex:[respBody.result length]-1] substringFromIndex:1];
    title = [NSString stringWithFormat:@"赞%@  评论",title];
    [goComment setTitle:title forState:UIControlStateNormal];
    [zan setEnabled:NO];
}

-(void) ShowContentView
{
    if (contentView.frame.origin.y >= SCREEN_HEIGHT) {
        [UIView animateWithDuration:0.5 animations:^{
            contentView.frame = CGRectMake(0, SCREEN_HEIGHT - 40 - size.height, size.width, size.height);
        }];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            contentView.frame = CGRectMake(0, SCREEN_HEIGHT, size.width, size.height);
        }];
    }
}

-(void) goCommentView
{
    ImageCommentViewController *comment = [[ImageCommentViewController alloc] init];
    comment.imageId = [NSString stringWithFormat:@"%d",[indexModel.idImg intValue]];
    [self.navigationController pushViewController:comment animated:YES];
    [comment release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [imageOperation release];
    [modelArray release];
    [super dealloc];
}

@end
