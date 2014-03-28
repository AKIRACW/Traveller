//
//  hotspotColloctionViewController.m
//  Traveller
//
//  Created by TY on 14-3-26.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "hotspotColloctionViewController.h"

@interface hotspotColloctionViewController ()

@end

@implementation hotspotColloctionViewController

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
    self.title=@"收藏";
    [self userDefinedNavicontrollerBar];
    [self getcollectinfo];
    self.table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.table setDelegate:self];
    [self.table setDataSource:self];

    [self.view addSubview:self.table];
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //
    NSLog(@"手指撮动了");
    return UITableViewCellEditingStyleDelete;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr=[dic_info allKeys];
    return [arr count];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    hotspotCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[hotspotCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    NSArray *arr=[dic_info allKeys];
    NSMutableDictionary *dic=[dic_info objectForKey:[arr objectAtIndex:indexPath.row]];
    cell.lblinfo.text=[dic  objectForKey:@"Posts_title"];
    return cell;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    NSLog(@"moveRowAtIndexPath");
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *arr= [dic_info allKeys];
    NSDictionary *dic_strategy=[dic_info objectForKey:[arr objectAtIndex:indexPath.row]];
    strategyViewController *stra_VC=[[strategyViewController alloc] init];
    [stra_VC getstrategyinfo:dic_strategy];
    [self.navigationController pushViewController:stra_VC animated:YES];
}

-(void)getcollectinfo{
    NSString *homepath=NSHomeDirectory();
    NSString *path=[homepath stringByAppendingPathComponent:@"strategy_collect"];
    dic_info=[[NSMutableDictionary alloc] init];
    dic_info=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
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
