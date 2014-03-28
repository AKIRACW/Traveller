//
//  SettingVC.m
//  Traveller
//
//  Created by TY on 14-3-19.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "SettingVC.h"
#import "LoginViewController.h"
@interface SettingVC ()

@end

@implementation SettingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
	[self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.AccountLbl.text=@"   我的帐户";
    self.AccountLbl.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickUILable)];
    [self.AccountLbl addGestureRecognizer:tapGesture];
	[self.navigationController setNavigationBarHidden:YES animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)onClickUILable{
    LoginViewController *loginVC=[[LoginViewController alloc]init];
	loginVC.hidesBottomBarWhenPushed=YES;
	[self.navigationController pushViewController:loginVC animated:NO];
}
@end
