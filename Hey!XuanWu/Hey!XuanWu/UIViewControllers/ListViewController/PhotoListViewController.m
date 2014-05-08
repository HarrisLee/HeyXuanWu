//
//  PhotoListViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-18.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "PhotoListViewController.h"

@interface PhotoListViewController ()

@end

@implementation PhotoListViewController
@synthesize secDirId;

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
    
    self.secDirId = [self.secDirId stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    self.secDirId = [self.secDirId stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    
    iArray = [[NSMutableArray alloc] init];

    waterFlower = [[WaterFlowView alloc] initWithFrame:CGRectMake(0, 64, 320, SCREEN_HEIGHT-64)];
    waterFlower.delegate = self;
    waterFlower.pullDelegate = self;
//    waterFlower.canPullDown = YES;
//    waterFlower.canPullUp = YES;
    waterFlower.viewDataSource = self;
    waterFlower.viewDelegate = self;
    [self.view addSubview:waterFlower];
    [waterFlower release];
    [waterFlower loadData];
    
//    [waterFlower setContentOffset:CGPointMake(0, -64)];
    
    imageArray = [[NSMutableArray alloc] init];
    
    GetImgListReqBody *reqBody = [[GetImgListReqBody alloc] init];
    
    reqBody.idSecondDirectory = self.secDirId;

    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody andReqType:IMG_LIST];
    
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject){
        
        GetImgListRespBody *respBody = (GetImgListRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:IMG_LIST];
        [self reloadImages:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        NSLog(@"Error : %@",[error localizedDescription]);
        alertMessage(@"获取照片失败");
    }];
    [theOperation start];
    [theOperation release];
    
}

-(void) reloadImages:(GetImgListRespBody *)respBody
{
    if (!respBody.imageList || [respBody.imageList count] == 0) {
        return ;
    }
    
    [imageArray removeAllObjects];
    
    for (ImageModel *model in respBody.imageList) {
        [imageArray addObject:model];
    }
    
    [waterFlower loadData];
}


/**
 *  多选照片的代理方法。在这里进行选择，上传等一系列操作
 */
#pragma mark - QBImagePickerControllerDelegate

- (void)imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    
    if(imagePickerController.allowsMultipleSelection) {
        NSArray *mediaInfoArray = (NSArray *)info;
        [self dismissViewControllerAnimated:YES completion:^{
            [self uploadImageWith:mediaInfoArray];
        }];
        NSLog(@"Selected %d photos and mediaInfoArray==%@", mediaInfoArray.count,mediaInfoArray);
    } else {
        NSDictionary *mediaInfo = (NSDictionary *)info;
        NSLog(@"Selected: %@", mediaInfo);
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(void) uploadImageWith:(NSArray *)mediaInfoArray
{
    errorCount = 0;
    startTag = YES;
    finishCount = 0;
    if (startTag == YES) {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:HUD];
        // Set determinate mode
        HUD.mode = MBProgressHUDModeAnnularDeterminate;
        HUD.delegate = self;
        HUD.labelText = @"图片上传中...";
        [HUD show:YES];
        startTag = NO;
        UIActivityIndicatorView *actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        actView.frame = CGRectMake(150, (SCREEN_HEIGHT - 20)/2-11, 20, 20);
        [actView startAnimating];
        [HUD addSubview:actView];
        [actView release];
    }
    
    @autoreleasepool {
        for (ALAsset *asset in mediaInfoArray) {
            if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypePhoto) {
                [iArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
            }
        }
        
        [self upLoadImageWithSort];
    }
}

-(void) upLoadImageWithSort
{
    if ([iArray count] == 0 || finishCount >= [iArray count]) {
        [HUD hide:YES];
        errorCount = 0;
        finishCount = 0;
        [iArray removeAllObjects];
        return ;
    }
    
    UploadFileReqBody *upreqBody = [[UploadFileReqBody alloc] init];

    upreqBody.idSecondDirectory = [self.secDirId stringByReplacingOccurrencesOfString:@" " withString:@""];

    upreqBody.nameImg = [NSString stringWithFormat:@"%@_%d.png",nameString,finishCount+1];

    upreqBody.describeImg = desString;

    upreqBody.addAccountId = [DataCenter shareInstance].loginId;

    NSData *data = UIImagePNGRepresentation([iArray objectAtIndex:finishCount]);

    NSString *dataStr = [NSString base64Encode:data];

    upreqBody.fs = dataStr;

    NSMutableURLRequest *requestUp = [[AFHttpRequestUtils shareInstance] requestWithBody:upreqBody andReqType:UPLOAD_FILE];

    AFHTTPRequestOperation *theOperationUp = [[AFHTTPRequestOperation alloc] initWithRequest:requestUp];
    [theOperationUp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject){

    UploadFileRespBody *respBody = (UploadFileRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:UPLOAD_FILE];
        
        [self reloadWaterView:respBody];
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        
        NSLog(@"Error : %@",[error localizedDescription]);
        [self uploadFail:error];
        
    }];
    [theOperationUp start];
    [theOperationUp release];
}

-(void) reloadWaterView:(UploadFileRespBody *)respBody
{
    finishCount ++;
    HUD.progress = ((float)finishCount)/iArray.count;
    if ([@"\"0\"" isEqualToString:respBody.result]) {
        [self upLoadImageWithSort];
        errorCount ++;
        if (finishCount == [iArray count] && errorCount > 0) {
            alertMessage(@"有图片上传失败。");
        }
        return ;
    }
    respBody.result = [respBody.result stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSArray *array = [respBody.result componentsSeparatedByString:@"|"];
    ImageModel *model = [[ImageModel alloc] init];
    model.goodCount = @"0";
    model.virtualPath = [array objectAtIndex:0];
    model.idImg = [array objectAtIndex:1];
    model.nameImg = [NSString stringWithFormat:@"%@_%d.png",nameString,finishCount];
    [imageArray addObject:model];
    
    [waterFlower loadData];
    
    [self upLoadImageWithSort];
}

-(void) uploadFail:(NSError *)error
{
    finishCount ++;
    HUD.progress = ((float)finishCount)/iArray.count;
    [self upLoadImageWithSort];
    errorCount ++;
    if (finishCount == [iArray count] && errorCount > 0) {
        alertMessage(@"有图片上传失败。");
    }
}

- (void)imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController
{
    NSLog(@"取消选择");
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *)descriptionForSelectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";
}

- (NSString *)descriptionForDeselectingAllAssets:(QBImagePickerController *)imagePickerController
{
    return @"";
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    return [NSString stringWithFormat:@"图片%d张", numberOfPhotos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfVideos:(NSUInteger)numberOfVideos
{
    return [NSString stringWithFormat:@"视频%d", numberOfVideos];
}

- (NSString *)imagePickerController:(QBImagePickerController *)imagePickerController descriptionForNumberOfPhotos:(NSUInteger)numberOfPhotos numberOfVideos:(NSUInteger)numberOfVideos
{
    return [NSString stringWithFormat:@"图片%d 视频%d", numberOfPhotos, numberOfVideos];
}

#pragma mark -
#pragma mark PullDelegate
- (void)loadWithState:(LoadState)state {
    NSLog(@"1");
    if (state == PullDownLoadState) {
//        currentPage = 0;
//        [self getNewsWithCurrentPage:currentPage];
    } else {
//        [self getNewsWithCurrentPage:currentPage];
    }
}

- (void)refreshView {
    NSLog(@"2");
//    currentPage = 0;
//    [self getNewsWithCurrentPage:currentPage];
}

- (void)loadMore {
    NSLog(@"3");
//    [self getNewsWithCurrentPage:currentPage];
}

-(void) loadFinished
{
    //加载信息完成之后调用
    [waterFlower stopLoadWithState:PullUpLoadState];
    [waterFlower stopLoadWithState:PullDownLoadState];
}

//该视图中的小视图总数
- (NSInteger)numberOfViewsInWaterFlowView:(WaterFlowView *)waterFlowView
{
    return [imageArray count];
}

//该视图每页有多少列
- (NSInteger)numberOfColumsInWaterFlowView:(WaterFlowView *)waterFlowView
{
    return 3;
}

//该视图每行高度
- (CGFloat)waterFlowView:(WaterFlowView *)waterFlowView heightForIndex:(NSInteger)index
{
    return 135.0f;
}

//获取视图
- (UIView*)waterFlowView:(WaterFlowView*)waterFlowView viewAtIndex:(NSInteger)index
{
    static NSString *identifier = @"photoIdentifiet";
    ImageModel *model = [imageArray objectAtIndex:index];
    PhotoViewCell *cell = (PhotoViewCell *)[waterFlowView dequeueReusableViewWithIdentifier:identifier];
    if (!cell) {
        cell = [[[PhotoViewCell alloc] initWithFrame:CGRectMake(0, 0, 100, 130)] autorelease];
        cell.identifier = identifier;
    }
    
    if ([model.virtualPath length] == 0) {
        model.virtualPath = @"";
    }
    
    NSURL *url = [NSURL URLWithString:model.virtualPath];
    [cell.imgView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"2.png"]];
    return cell;
}

//获取页面宽度
- (CGFloat)widthForSiderInWaterFlowView:(WaterFlowView*)waterFlowView
{
    return 5.0f;
}

- (void)waterFlowView:(WaterFlowView*)waterFlowView selectItemAtIndex:(NSInteger)index
{
    ImageModel *model = [imageArray objectAtIndex:index];
    DetailViewController *second = [[DetailViewController alloc] init];
    second.title = model.nameImg;
    [second setArray:imageArray withIndex:index];
    [self.navigationController pushViewController:second animated:YES];
    [second release];
}


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
    
    m_view = [[HUDView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    m_view.delegate = self;
    m_view.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:m_view];
    [m_view release];
}

-(void) setPhotoInfo:(NSString *)name withDescribeString:(NSString *)describe
{
    nameString = [name retain];
    desString = [describe retain];
    
    [m_view removeFromSuperview];
    
    QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsMultipleSelection = YES;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [self presentViewController:navigationController animated:YES completion:NULL];
    [imagePickerController release];
    [navigationController release];
}

-(void) cancleView
{
    [m_view removeFromSuperview];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[HUD removeFromSuperview];
	[HUD release];
	HUD = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [secDirId release];
    [imageArray release];
    [super dealloc];
}

@end
