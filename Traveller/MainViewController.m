//
//  MainViewController.m
//  Traveller
//
//  Created by TY on 14-3-19.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

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

    self.weather_model=[[weatherModel alloc] init];
    _Viewarr=[[NSMutableArray alloc] init];
   NSString *str= [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"junketing" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic=[str JSONValue];

    [self readyhotspot];
    [self readhotpost];
    [self readyFunction];
    [self readyweather];
    
    [_Viewarr addObject:self.weather_view];
    [_Viewarr addObject:self.hot_Spot_view];
    [_Viewarr addObject:self.hot_post_view];
    [_Viewarr addObject:self.Function_view];


    self.table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.table setDelegate:self];
    [self.table setDataSource:self];
    [self.view addSubview:self.table];
    self.title=@"热门推荐";
    
}
    
    
    
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_Viewarr count];
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    MaintableCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MaintableCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    [cell.contentView addSubview:[_Viewarr objectAtIndex:indexPath.section]];


    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *view=[_Viewarr objectAtIndex:indexPath.section];
    return view.frame.size.height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
//天气预报
-(void)readyweather{
    [self getweathInfo];
    self.weather_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    self.weather_view.backgroundColor=[UIColor blueColor];
    UIImageView *weather_imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.weather_view.frame.size.width, self.weather_view.frame.size.height)];
    weather_imgview.image=[UIImage imageNamed:[self.weather_model.weather stringByAppendingString:@".jpg"]];
    [self.weather_view addSubview:weather_imgview];

    [self settingWeatherInfo];
}
//热门推荐景区
-(void)readyhotspot{
    NSString *str= [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"junketing" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    _dicCityInfo =[str JSONValue];
    self.hot_Spot_view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    self.hot_spot_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.hot_Spot_view.frame.size.width, self.hot_Spot_view.frame.size.height)];
    [self settingreadyhotspot];

}

-(void)settingreadyhotspot{
    NSArray *cityArr=[_dicCityInfo objectForKey:@"data"];
    for (int i=0; i<[cityArr count];i++ ) {
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(10+80*i, 20, 60, 80)];
        btn.backgroundColor=[UIColor yellowColor];
        [btn setBackgroundImage:[UIImage imageNamed:[[[cityArr objectAtIndex:i] objectForKey:@"CityName"] stringByAppendingString:@".jpg"]] forState:UIControlStateNormal];
        btn.tag=10000+i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.hot_spot_scrollView addSubview:btn];
    }
    [self.hot_spot_scrollView setContentSize:CGSizeMake(20+80*[cityArr count], 0)];
    [self.hot_Spot_view addSubview:self.hot_spot_scrollView];
}
-(void)btnAction:(UIButton*)sender{
    NSLog(@"%d",sender.tag);
    NSArray *cityArr=[_dicCityInfo objectForKey:@"data"];
    NSString *strcity=[[cityArr objectAtIndex:sender.tag-10000] objectForKey:@"CityName"];
    NSLog(@"%@",strcity);
    NSString *str=[[cityArr objectAtIndex:sender.tag-10000] objectForKey:@"condent"];
    NSLog(@"%@",str);
    
    cityViewController *cityVC=[[cityViewController alloc] init];
    [cityVC getcityInfo:[cityArr objectAtIndex:sender.tag-10000]];
    self.tabBarController.tabBar.hidden=YES;
    [self.navigationController pushViewController:cityVC animated:YES];
    

}
//热门经验帖
-(void)readhotpost{
    self.hot_post_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    self.hot_post_view.backgroundColor=[UIColor blueColor];
}
//功能界面
-(void)readyFunction{
    self.Function_view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 70)];
//    self.Function_view.backgroundColor=[UIColor grayColor];
    [self colloctInfo];
    
}
////收藏
-(void)colloctInfo{
    //设置商城按钮
    UIButton *col_hotspot_Button=[[UIButton  alloc] initWithFrame:CGRectMake(10, 20, 150, 30)];
    [col_hotspot_Button addTarget:self action:@selector(col_hotspot_ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    //        [storeButton addTarget:self action:@selector(resigion) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *col_hotspot_img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 18)];
    [col_hotspot_img setImage:[UIImage imageNamed:@"money"]];
    [col_hotspot_Button addSubview:col_hotspot_img];
    
    //设置商城lbl
    UILabel *col_hotspot_lbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 0, 130, 20)];
    col_hotspot_lbl.text=@"地点收藏";
    col_hotspot_lbl.font=[UIFont systemFontOfSize:10];
    col_hotspot_lbl.textColor=[UIColor blueColor];
    [col_hotspot_Button addSubview:col_hotspot_lbl];
    [self.Function_view addSubview:col_hotspot_Button];
    
    //设置
    UIButton *col_activity_Button=[[UIButton alloc] initWithFrame:CGRectMake(10, 50, 130, 30)];
    [col_activity_Button addTarget:self action:@selector(col_activity_ButtonAtcion:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *col_activity_img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 18)];
    [col_activity_img setImage:[UIImage imageNamed:@"money"]];
    [col_activity_Button addSubview:col_activity_img];
    
    //设置商城lbl
    UILabel *col_activity_lbl=[[UILabel alloc]initWithFrame:CGRectMake(25, 0, 130, 20)];

    col_activity_lbl.text=@"我参加的活动";
    col_activity_lbl.font=[UIFont systemFontOfSize:10];
    col_activity_lbl.textColor=[UIColor blueColor];
    [col_activity_Button addSubview:col_activity_lbl];
    col_activity_Button.tintColor=[UIColor blueColor];
    [self.Function_view addSubview:col_activity_Button];
    
}
//获得天气信息
-(void)getweathInfo{
    NSString *city=[NSString stringWithFormat:@"%d",[weatherjson cityChangCityID:@"重庆"] ];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://www.weather.com.cn/data/cityinfo/%@.html",city]];
        NSError *error=nil;
    NSString *strContents=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    self.weather_model=[weatherjson newWeatherWithString:strContents];
    NSLog(@"%@",self.weather_model.city);
}
//设置天气info
-(void)settingWeatherInfo{
    UILabel *citylbl=[[UILabel alloc] initWithFrame:CGRectMake(270, 20, 30, 20)];
    citylbl.text=self.weather_model.city;
    citylbl.textColor=[UIColor whiteColor];
    NSLog(@"%@",citylbl.text);
    citylbl.adjustsFontSizeToFitWidth=YES;
    
    UILabel *templbl=[[UILabel alloc] initWithFrame:CGRectMake(270,45,40,20)];
    templbl.text=self.weather_model.temp;
    templbl.adjustsFontSizeToFitWidth=YES;
    templbl.textColor=[UIColor whiteColor];
    UILabel *weatherlbl=[[UILabel alloc] initWithFrame:CGRectMake(270, 70, 30, 20)];
    weatherlbl.text=self.weather_model.weather;
    weatherlbl.adjustsFontSizeToFitWidth=YES;
    weatherlbl.textColor=[UIColor whiteColor];
    [self.weather_view addSubview:weatherlbl];
    [self.weather_view addSubview:templbl];
    [self.weather_view addSubview:citylbl];
}
-(void)col_activity_ButtonAtcion:(UIButton*)sender{
    self.tabBarController.tabBar.hidden=YES;
    ActingViewController *actVC=[[ActingViewController alloc] init];
    [self.navigationController pushViewController:actVC animated:YES];
}
-(void)col_hotspot_ButtonAction{
    self.tabBarController.tabBar.hidden=YES;
    hotspotColloctionViewController *collVC=[[hotspotColloctionViewController alloc]init];
    [self.navigationController pushViewController:collVC animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
