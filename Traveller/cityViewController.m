//
//  cityViewController.m
//  Traveller
//
//  Created by TY on 14-3-24.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "cityViewController.h"

@interface cityViewController ()

@end

@implementation cityViewController

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
    _thepage=1;
    _strategy_view_arr=[[NSMutableArray alloc] init];
    _ViewArray=[[NSMutableArray alloc] init];
    _strategy_arr=[[NSMutableArray alloc] init];
    [super viewDidLoad];
    
    //初始化内容信息
    [self readyCondentInfo];
    //初始化食物信息
    [self readyFoodInfo];
    self.title=[_citydic objectForKey:@"CityName"];
    //获得攻略信息
    [self getstategyInfo];
    
    
    
    self.table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.table setDataSource:self];
    [self.table setDelegate:self];
    //设置导航拦
    [self readyGuidebtn];
    self.table.separatorStyle=UITableViewCellSelectionStyleNone;
    //自定义navicontrollerbar
    [self userDefinedNavicontrollerBar];
    [self.view addSubview:self.table];



}
//自定义navicontrollerbar
-(void)userDefinedNavicontrollerBar{
    UIButton *navleftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [navleftButton setBackgroundImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    
    [navleftButton addTarget:self action:@selector(click_back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navleftItem = [[UIBarButtonItem alloc]initWithCustomView:navleftButton];
    self.navigationItem.leftBarButtonItem = navleftItem;
    
    
    
}
//获得攻略信息
-(void)getstategyInfo{
    NSString *str= [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"strategy" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic=[str JSONValue];
    NSArray *cityinfo_arr=[dic objectForKey:@"data"];
    for (NSDictionary *cityinfo_dic in cityinfo_arr) {
        if ([[cityinfo_dic objectForKey:@"Posts_travel_notes_city" ] isEqualToString:self.title]) {
            [_strategy_arr addObject:cityinfo_dic];
        }
    }
    [self readystrategyView];

}
//初始化攻略界面
-(void)readystrategyView{
    for (NSDictionary *cityinfo_dic in _strategy_arr) {
        UIView *strategyView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
        UIImageView *strategy_img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 100)];
        strategy_img.image=[UIImage imageNamed:[cityinfo_dic objectForKey:@"Posts_travel_notes_image"]];
        UILabel *strategy_title_lable=[[UILabel alloc] initWithFrame:CGRectMake(90, 10, 220, 20)];
        strategy_title_lable.text=[cityinfo_dic objectForKey:@"Posts_title"];
        UILabel *strategy_contentinfo_lable=[[UILabel alloc] initWithFrame:CGRectMake(100, 30, 220, 40)];
        strategy_contentinfo_lable.font=[UIFont systemFontOfSize:12];
        strategy_contentinfo_lable.text=[cityinfo_dic objectForKey:@"Posts_content"];
        
        UILabel *nickName_lable=[[UILabel alloc] initWithFrame:CGRectMake(250, 80, 70, 20)];
        nickName_lable.font=[UIFont systemFontOfSize:10];
        nickName_lable.text=[cityinfo_dic objectForKey:@"User_nickname"];
        [strategyView addSubview:nickName_lable];
        [strategyView addSubview:strategy_img];
        [strategyView addSubview:strategy_title_lable];
        [strategyView addSubview:strategy_contentinfo_lable];
        [_strategy_view_arr addObject:strategyView];
    }

}
//返回之前界面
-(void)click_back{
    self.tabBarController.tabBar.hidden=NO;
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//初始化简介数据
-(void)readyCondentInfo{
    UIView *condentView=[[UIView alloc] init];
    UILabel *introduc_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320 , 20)];
    introduc_lbl.text=@"简介";
    introduc_lbl.textColor=[UIColor orangeColor];
    UIView *introduc_view=[[UIView alloc] initWithFrame:CGRectMake(0, introduc_lbl.frame.size.height, self.view.frame.size.width, 0.3)];
    introduc_view.backgroundColor=[UIColor orangeColor];
    [condentView addSubview:introduc_view];
    UILabel *label=[[UILabel alloc] init];
    label.numberOfLines=0;
    label.lineBreakMode=UILineBreakModeCharacterWrap;
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];
    CGSize size = CGSizeMake(320,2000);
    CGSize labelsize = [[_citydic objectForKey:@"condent"] sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    label.text=[_citydic objectForKey:@"condent"];
    label.font=[UIFont fontWithName:@"Arial" size:14];
    label.frame = CGRectMake(0.0, 25, labelsize.width, labelsize.height );
    [condentView addSubview:label];
    [condentView addSubview:introduc_lbl];
    condentView.frame=CGRectMake(0, 0, 320,label.frame.size.height+introduc_lbl.frame.size.height+20);
//    [self.view addSubview:condentView];
    
    [_ViewArray addObject:condentView];
}
//初始化美食信息
-(void)readyFoodInfo{
    UIView *foodView=[[UIView alloc]init];
    UILabel *introduc_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320 , 20)];
//    设置标头
    [foodView addSubview:introduc_lbl];
    introduc_lbl.text=@"美食";
    introduc_lbl.textColor=[UIColor orangeColor];
    UIView *introduc_view=[[UIView alloc] initWithFrame:CGRectMake(0, introduc_lbl.frame.size.height, self.view.frame.size.width, 0.3)];
    introduc_view.backgroundColor=[UIColor orangeColor];
    [foodView addSubview:introduc_view];

    NSDictionary *food_dic=[_citydic objectForKey:@"delicious_food"];
    NSArray *food_arr=[food_dic allKeys];
    float height=0;//设置位移标示
    for (int i=0; i<[food_arr count]; i++) {
        NSDictionary *dicintrodece=[food_dic objectForKey:[food_arr objectAtIndex:i]];
        UILabel *foodname=[[UILabel alloc] initWithFrame:CGRectMake(0,height+20, self.view.frame.size.width, 20)];
        height+=20;
        foodname.text=[food_arr objectAtIndex:i];
        foodname.textColor=[UIColor orangeColor];
        [foodView addSubview:foodname];
        for (int n=0; n<[[dicintrodece allKeys] count]; n++) {
            UILabel *label=[[UILabel alloc] init];
            label.numberOfLines=0;
            label.lineBreakMode=UILineBreakModeCharacterWrap;
            UIFont *font = [UIFont fontWithName:@"Arial" size:14];
            CGSize size = CGSizeMake(320,2000);
            CGSize labelsize = [[dicintrodece objectForKey:[[dicintrodece allKeys] objectAtIndex:n]] sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
            label.text=[dicintrodece objectForKey:[[dicintrodece allKeys] objectAtIndex:n]];

            label.font=[UIFont fontWithName:@"Arial" size:14];
            label.frame = CGRectMake(0.0,height+20, labelsize.width, labelsize.height );
            [foodView addSubview:label];
            height=height+labelsize.height+20;//惟一量

        }
    }
    foodView.frame=CGRectMake(0, 0, self.view.frame.size.width, height);
    [_ViewArray addObject:foodView];
    
}
#pragma mark-tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    int i=0;
    if (_thepage==1) {
        i=[_infoArray count];
    }else if(_thepage==2){
        i=[_strategy_arr count];
    }
    return i;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
    


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    MaintableCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        cell = [[MaintableCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    if (_thepage==1) {
    [cell.contentView addSubview:[_ViewArray objectAtIndex:indexPath.section]];
    cell.userInteractionEnabled = NO;
    }else{
    [cell.contentView addSubview:[_strategy_view_arr objectAtIndex:indexPath.section]];

    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic_strategy=[_strategy_arr objectAtIndex:indexPath.section];
    strategyViewController *stra_VC=[[strategyViewController alloc] init];
    [stra_VC getstrategyinfo:dic_strategy];
    [self.navigationController pushViewController:stra_VC animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *view=[[UIView alloc] init];
    if (_thepage==1) {
        view=[_ViewArray objectAtIndex:indexPath.section];
    }else{
        view=[_strategy_view_arr objectAtIndex:indexPath.section];
    }
    return view.frame.size.height;
}

//初始化导航栏
-(void)readyGuidebtn{
     introduction_btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    [introduction_btn setTitle:@"简介" forState:UIControlStateNormal];
    [introduction_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    introduction_btn.selected=YES;
    [introduction_btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
     strategy_btn=[[UIButton alloc]initWithFrame:CGRectMake(160, 0, 160, 30)];
    UIView *lineView_ON1=[[UIView alloc] initWithFrame:CGRectMake(160, 0, 0.5, 30)];
    lineView_ON1.backgroundColor=[UIColor blackColor];
    UIView *lineView_ON2=[[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 0.5)];
    lineView_ON2.backgroundColor=[UIColor blackColor];
    
    
    [strategy_btn setTitle:@"攻略" forState:UIControlStateNormal];
    [strategy_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [strategy_btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    [introduction_btn addTarget:self action:@selector(introduction_btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [strategy_btn addTarget:self action:@selector(strategy_btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *btnView=[[UIView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 30)];
    
    [btnView addSubview:strategy_btn];
    [btnView addSubview:introduction_btn];
    [btnView addSubview:lineView_ON1];
    [btnView addSubview:lineView_ON2];
    self.table.tableHeaderView=btnView;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 ***按钮动作***
*/
-(void)introduction_btnAction:(UIButton*)sender{
    introduction_btn.selected=YES;
    strategy_btn.selected=NO;
    self.table.separatorStyle=UITableViewCellSelectionStyleNone;

    _thepage=1;
    [self.table reloadData];
    
}
-(void)strategy_btnAction:(UIButton*)sender{
    introduction_btn.selected=NO;
    strategy_btn.selected=YES;
    self.table.separatorStyle=UITableViewCellSelectionStyleBlue;

    _thepage=2;
    [self.table reloadData];
    
}
//获得信息
-(void)getcityInfo:(NSMutableDictionary*)thedic{
    _citydic=[[NSMutableDictionary alloc] init];
    _infoArray=[[NSMutableArray alloc] init];
    _citydic=thedic;
    NSString *strcondent=@"condent";
    NSString *delicious_food=@"delicious_food";
    [_infoArray addObject:strcondent];
    [_infoArray addObject:delicious_food];
    
}
@end
