//
//  CommonViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 13-11-15.
//  Copyright (c) 2013年 Cao JianRong. All rights reserved.
//

#import "CommonViewController.h"
#import "RootNavViewController.h"
#import "LoginViewController.h"
#import "PublicDefine.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

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
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial-BoldMT" size:20],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    self.navigationController.navigationBar.titleTextAttributes = dict;

    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [backButton setImage:[UIImage imageNamed:@"m_back@2x.png"] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:@"m_back_v@2x.png"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(openSlider) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    temporaryBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem=temporaryBarButtonItem;
    [temporaryBarButtonItem release];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0.0, 0.0, 35.0, 35.0);
    [rightButton setImage:[UIImage imageNamed:@"menu_3@2x.png"] forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"menu_3_v@2x.png"] forState:UIControlStateHighlighted];
    [rightButton addTarget:self action:@selector(sendArticleNews) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *tempBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    tempBarButtonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem=tempBarButtonItem;
    [tempBarButtonItem release];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, SCREEN_HEIGHT)];
    [imgView setBackgroundColor:[UIColor colorWithRed:0.82f green:0.80f blue:0.69f alpha:1.00f]];
    [self.view addSubview:imgView];
    [imgView release];
}

-(void) openSlider {
    [self.navigationController popViewControllerAnimated:YES];
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

@end
