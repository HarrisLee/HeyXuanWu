//
//  TKViewController.m
//  Hey!XuanWu
//
//  Created by Cao JianRong on 14-3-17.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "TKViewController.h"

@interface TKViewController ()

@end

@implementation TKViewController

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
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 320, SCREEN_HEIGHT-64)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    
    indexArray = [[NSMutableArray alloc] init];
    [indexArray addObject:@"微心愿"];
    [indexArray addObject:@"微活动"];
    [indexArray addObject:@"微阵地"];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    [cell.textLabel setFont:[UIFont fontWithName:@"DFWaWa-W7-HKP-BF" size:15.0f]];
    cell.textLabel.text = [indexArray objectAtIndex:indexPath.row];
    return  cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ComplaintViewController *complaint = [[ComplaintViewController alloc] init];
        complaint.title = [indexArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:complaint animated:YES];
        [complaint release];
    } else if (indexPath.row == 1){
        SecondaryViewController *second = [[SecondaryViewController alloc] init];
        second.title = [indexArray objectAtIndex:indexPath.row];
        second.directory = @"whd88888";
        [self.navigationController pushViewController:second animated:YES];
        [second release];
    } else {
        SecondaryViewController *second = [[SecondaryViewController alloc] init];
        second.title = [indexArray objectAtIndex:indexPath.row];
        second.directory = @"wzd88888";
        [self.navigationController pushViewController:second animated:YES];
        [second release];
    }
}

-(void) dealloc
{
    [indexArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
