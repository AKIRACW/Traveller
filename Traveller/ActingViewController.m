//
//  ActingViewController.m
//  Traveller
//
//  Created by TY on 14-3-26.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "ActingViewController.h"

@interface ActingViewController ()

@end

@implementation ActingViewController

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
    self.title=@"活动";
	[self userDefinedNavicontrollerBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//自定义navicontrollerbar
-(void)userDefinedNavicontrollerBar{
    UIButton *navleftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [navleftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    
    [navleftButton addTarget:self action:@selector(click_back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navleftItem = [[UIBarButtonItem alloc]initWithCustomView:navleftButton];
    self.navigationItem.leftBarButtonItem = navleftItem;
}
//返回之前界面
-(void)click_back{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
