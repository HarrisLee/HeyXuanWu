//
//  RootNavViewController.m
//  Hey!XuanWu
//
//  Created by Melo on 13-6-13.
//  Copyright (c) 2013年 Melo. All rights reserved.
//

#import "RootNavViewController.h"


@interface RootNavViewController ()

@end

@implementation RootNavViewController

#pragma mark -
#pragma mark RootNavViewController Singleton Implementation
static RootNavViewController *m_RootNavCtr = nil;

+(RootNavViewController*)shareInstance {
    @synchronized(self)
	{
		if (m_RootNavCtr == nil)
		{
			m_RootNavCtr = [[RootNavViewController alloc] init];
		}
	}
	return m_RootNavCtr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial-BoldMT" size:20],NSFontAttributeName,[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    self.navigationBar.titleTextAttributes = dict;
    
    [self.navigationBar loadNavigationBar];
    
    [self goIndexView:nil];
}

/**
 *  进入欢迎页面
 *
 *  @param sender 可以为nil
 */
-(void) goIndexView:(id)sender
{
    welcomeController = [[WelcomeViewController alloc] init];
    [self pushViewController:welcomeController animated:NO];
    [welcomeController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
