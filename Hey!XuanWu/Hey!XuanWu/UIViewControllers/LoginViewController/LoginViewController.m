//
//  LoginViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-2-10.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
    login = [[LoginView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    login.delegate = self;
    [self.view addSubview:login];
    [login release];
}

-(void)loginInServer:(id)sender
{
    NSLog(@"login  %@,%@",login.nameField.text,login.passField.text);
    VerifyLoginReqBody *reqBody = [[VerifyLoginReqBody alloc] init];
    reqBody.name = login.nameField.text;
    reqBody.password = login.passField.text;
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody
                                                                            andReqType:VERITY_LOGIN];
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        VerifyLoginRespBody *respBody = (VerifyLoginRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:VERITY_LOGIN];
        [self checkData:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求出错,请稍后重试.");
    }];
    
    [theOperation start];
    [theOperation release];
}

-(void) checkData:(VerifyLoginRespBody *) respBody
{
    if (![@"\"0\"" isEqualToString:respBody.isVerify]) {
        [DataCenter shareInstance].isLogined = YES;
        [DataCenter shareInstance].loginName = login.nameField.text;
        [DataCenter shareInstance].loginId = [respBody.isVerify stringByReplacingOccurrencesOfString:@" " withString:@""];
        [DataCenter shareInstance].loginId = [[[DataCenter shareInstance].loginId substringToIndex:[[DataCenter shareInstance].loginId length]-1] substringFromIndex:1];
        [self dismissViewControllerAnimated:YES completion:^{}];
    } else {
        alertMessage(@"登录失败,账户或密码错误.");
    }
}

-(void)registerInService:(NSString *)name WithPwd:(NSString *)pwd WithRureName:(NSString *)tname WithJob:(NSString *)job WithMobile:(NSString *)mobile
{
    NSLog(@"%@%@%@%@%@",name,pwd,tname,job,mobile);
    
    AddAccountReqBody *reqBody = [[AddAccountReqBody alloc] init];
    reqBody.accountName = name;
    reqBody.accountPassword = pwd;
    reqBody.peopleJob = job;
    reqBody.peopleName = tname;
    reqBody.peopleMobileNo = mobile;
    nameReg = [name retain];
    NSMutableURLRequest *request = [[AFHttpRequestUtils shareInstance] requestWithBody:reqBody
                                                                            andReqType:ADD_ACCOUNT];
    [reqBody release];
    
    AFHTTPRequestOperation *theOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [theOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        AddAccountRespBody *respBody = (AddAccountRespBody *)[[AFHttpRequestUtils shareInstance] jsonConvertObject:(NSData *)responseObject withReqType:ADD_ACCOUNT];
        [self checkRegster:respBody];
        
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", [error localizedDescription]);
        alertMessage(@"请求出错,请稍后重试.");
    }];
    
    [theOperation start];
    [theOperation release];
}

-(void) checkRegster:(AddAccountRespBody *)respBody
{
    if ([respBody.result isEqualToString:@"\"1\""]) {
        alertMessage(@"注册成功! 请登录");
    } else {
        alertMessage(@"注册失败,请重新提交注册.");
    }
}

-(void)cancleLogin:(id)sender
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
