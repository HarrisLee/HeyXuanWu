//
//  OutLoginViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-7.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "OutLoginViewController.h"

@interface OutLoginViewController ()

@end

@implementation OutLoginViewController

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
    login = [[OutLoginView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    login.delegate = self;
    [self.view addSubview:login];
    [login release];
}

-(void)outloginInServer:(id)sender
{
    NSLog(@"login  %@,%@",login.nameField.text,login.passField.text);
    VerifyOutsideLoginReqBody *reqBody = [[VerifyOutsideLoginReqBody alloc] init];
    reqBody.name = login.nameField.text;
    reqBody.password = login.passField.text;
    
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody
                                                                            andReqType:VERITY_OUT];
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        VerifyOutsideLoginRespBody *respBody = (VerifyOutsideLoginRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:VERITY_OUT];
        [self checkData:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求出错,请稍后重试.");
    }];
    
    [theOperation start];
    [theOperation release];
}

-(void) checkData:(VerifyOutsideLoginRespBody *) respBody
{
    if (![@"\"0\"" isEqualToString:respBody.isVerify]) {
        [DataCenter shareInstance].isOutLogin = YES;
        [DataCenter shareInstance].outLoginName = login.nameField.text;
        [DataCenter shareInstance].outLoginId = [[[respBody.isVerify substringToIndex:[respBody.isVerify length]-1] substringFromIndex:1] stringByReplacingOccurrencesOfString:@" " withString:@""];
        [self dismissViewControllerAnimated:YES completion:^{}];
    } else {
        alertMessage(@"登录失败,账户或密码错误.");
    }
}

-(void)outregisterInService:(NSString *) name WithMobile:(NSString *)mobile
{
    NSLog(@"%@%@",name,mobile);
    
    AddPeopleAccountReqBody *reqBody = [[AddPeopleAccountReqBody alloc] init];
    reqBody.PeopleName = name;
    reqBody.peopleMobileNo = mobile;
    nameReg = [name retain];
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody
                                                                            andReqType:ADD_PEOACCOUNT];
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AddPeopleAccountRespBody *respBody = (AddPeopleAccountRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_PEOACCOUNT];
        [self checkRegster:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求出错,请稍后重试.");
    }];
    
    [theOperation start];
    [theOperation release];
}

-(void) checkRegster:(AddPeopleAccountRespBody *)respBody
{
    if (![@"\"0\"" isEqualToString:respBody.result]) {
        alertMessage(@"注册成功! 请登录");
    } else {
        alertMessage(@"注册失败,请重新提交注册.");
    }
}

-(void)outcancleLogin:(id)sender
{
    NSLog(@"cancle");
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
