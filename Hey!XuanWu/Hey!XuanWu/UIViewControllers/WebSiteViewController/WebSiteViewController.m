//
//  WebSiteViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "WebSiteViewController.h"

@interface WebSiteViewController ()

@end

@implementation WebSiteViewController
@synthesize webSite;

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
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webSite]];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, 320, SCREEN_HEIGHT-64)];
    [web loadRequest:request];
    [self.view addSubview:web];
    [web release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    [webSite release];
    [super dealloc];
}

@end
