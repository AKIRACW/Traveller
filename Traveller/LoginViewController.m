//
//  LoginViewController.m
//  Traveller
//
//  Created by TY on 14-3-24.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "LoginViewController.h"
#import "RegViewController.h"
#import "SettingVC.h"
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
	self.navigationController.navigationBarHidden=NO;
	self.title=@"登陆";
	
	self.txtName.backgroundColor=[UIColor whiteColor];
	self.txtPass.backgroundColor=[UIColor whiteColor];
    self.btnLogin.backgroundColor=[UIColor orangeColor];
	
	self.txtName.placeholder=@"用户名/邮件";
	self.txtPass.placeholder=@"密码";
	
	
	
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
	[rigthButton setTitle:@"注 册" forState:UIControlStateNormal];
	
	rigthButton.titleLabel.font= [UIFont systemFontOfSize: 12];
	rigthButton.titleLabel.textColor=[UIColor blackColor];
    [rigthButton addTarget:self action:@selector(touchReg) forControlEvents:UIControlEventTouchUpInside];
    [rigthButtonView addSubview:rigthButton];
    UIBarButtonItem *rigthButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rigthButtonView];
    self.navigationItem.rightBarButtonItem=rigthButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)touchBack{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)touchReg{
	RegViewController *regVC=[[RegViewController alloc]init];
	[self.navigationController pushViewController:regVC animated:YES];
}

- (IBAction)touchLogin:(id)sender {
	//SettingVC *setVC=[[SettingVC alloc]init];
	//setVC.hidesBottomBarWhenPushed=NO;
	//[self.navigationController pushViewController:setVC animated:YES];
	
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self.view endEditing:YES];
}
@end
