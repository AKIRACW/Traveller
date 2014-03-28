//
//  RegViewController.m
//  Traveller
//
//  Created by TY on 14-3-24.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "RegViewController.h"
#import "SettingVC.h"
#import "LoginViewController.h"
@interface RegViewController ()

@end

@implementation RegViewController

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
	self.txtName.backgroundColor=[UIColor whiteColor];
	self.txtUserNmae.backgroundColor=[UIColor whiteColor];
	self.txtPass.backgroundColor=[UIColor whiteColor];
	self.btnReg.backgroundColor=[UIColor orangeColor];
	
	self.txtName.placeholder=@"  你的昵称";
	self.txtUserNmae.placeholder=@"  用户名/邮箱";
	self.txtPass.placeholder=@"  密码";
	
	
	UIView *homeButtonView = [[UIView alloc]initWithFrame:CGRectMake(-20, 0, 35, 40)];
    UIImageView *homeButtonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 10, 35, 25)];
    homeButtonImageView.image = [UIImage imageNamed:@"contenttoolbar_hd_back"];
    UIButton *homeButton = [[UIButton alloc]initWithFrame:CGRectMake(-20, 0, 45, 40)];
    homeButton.backgroundColor = [UIColor clearColor];
    [homeButton addTarget:self action:@selector(touchBack) forControlEvents:UIControlEventTouchUpInside];
    [homeButtonView addSubview:homeButtonImageView];
    [homeButtonView addSubview:homeButton];
    //创建home按钮
    UIBarButtonItem *homeButtonItem = [[UIBarButtonItem alloc]initWithCustomView:homeButtonView];
    self.navigationItem.leftBarButtonItem=homeButtonItem;
	
	
	UIView *rigthButtonView = [[UIView alloc]initWithFrame:CGRectMake(200, 0, 35, 40)];
    UIButton *rigthButton = [[UIButton alloc]initWithFrame:CGRectMake(-13, 9, 50, 25)];
    rigthButton.backgroundColor = [UIColor clearColor];
	[rigthButton setBackgroundImage:[UIImage imageNamed:@"reg"] forState:UIControlStateNormal];
	[rigthButton setTitle:@"登 陆" forState:UIControlStateNormal];
	rigthButton.titleLabel.font= [UIFont systemFontOfSize: 12];
	rigthButton.titleLabel.textColor=[UIColor blackColor];
    [rigthButton addTarget:self action:@selector(touchLogin) forControlEvents:UIControlEventTouchUpInside];
    [rigthButtonView addSubview:rigthButton];
    UIBarButtonItem *rigthButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rigthButtonView];
    self.navigationItem.rightBarButtonItem=rigthButtonItem;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

-(void)touchBack{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)touchLogin{
	LoginViewController *loginVC=[[LoginViewController alloc]init];
	[self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)touchReg:(id)sender {
	[self.navigationController popToRootViewControllerAnimated:YES];
	//给数据
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}
@end
