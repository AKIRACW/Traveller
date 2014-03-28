//
//  strategyViewController.m
//  Traveller
//
//  Created by TY on 14-3-27.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "strategyViewController.h"

@interface strategyViewController ()

@end

@implementation strategyViewController

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
    strategy_view_arr=[[NSMutableArray alloc] init];
    self.table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.table setDataSource:self];
    [self.table setDelegate:self];
    [self readystrategyInfo];
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
    
    
    UIButton *navrightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [navrightButton setBackgroundImage:[UIImage imageNamed:@"icon_star_selected"] forState:UIControlStateNormal];
    
    [navrightButton addTarget:self action:@selector(collection_action) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navrightItem = [[UIBarButtonItem alloc]initWithCustomView:navrightButton];
    self.navigationItem.rightBarButtonItem = navrightItem;
    
    
}
-(void)collection_action{
    NSString *homepath=NSHomeDirectory();
    NSString *path=[homepath stringByAppendingPathComponent:@"strategy_collect"];
    NSFileManager *file= [NSFileManager defaultManager];

    //当无归档得时候
    if (![file fileExistsAtPath:path]||![NSKeyedUnarchiver unarchiveObjectWithFile:path]) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        [dic setObject:dic_info forKey:[dic_info objectForKey:@"Posts_id"]];
        NSData *data1=[NSKeyedArchiver archivedDataWithRootObject:dic];
        [data1 writeToFile:path atomically:YES];
    }else{
        //当有归档得时候
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
        dic=[NSKeyedUnarchiver unarchiveObjectWithFile:path];
        [dic setObject:dic_info forKey:[dic_info objectForKey:@"Posts_id"]];
        NSData *data1=[NSKeyedArchiver archivedDataWithRootObject:dic];
        [data1 writeToFile:path atomically:YES];
    }
    UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"恭喜" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    
    [alt show];
}
-(void)click_back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)readystrategyInfo{
    UIView *strategyView=[[UIView alloc]init];
    UILabel *strategy_troduce_lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,320 , 20)];
    //    设置标头
    [strategyView addSubview:strategy_troduce_lbl];
    strategy_troduce_lbl.text=@"攻略";
    strategy_troduce_lbl.textColor=[UIColor orangeColor];
    float height=0;//设置位移标示
    NSArray *strategy_arr=[dic_info objectForKey:@"Posts_contentinfo"];
    for (NSDictionary *dic_condent in strategy_arr) {
        UILabel *label=[[UILabel alloc] init];
        label.numberOfLines=0;
        label.lineBreakMode=UILineBreakModeCharacterWrap;
        UIFont *font = [UIFont fontWithName:@"Arial" size:14];
        CGSize size = CGSizeMake(320,2000);
        CGSize labelsize = [[dic_condent objectForKey:@"plan"] sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        label.text=[dic_condent objectForKey:@"plan"];
        label.font=[UIFont fontWithName:@"Arial" size:14];
        label.frame = CGRectMake(0.0,height+20, labelsize.width, labelsize.height );
        [strategyView addSubview:label];
        height=height+labelsize.height+20;//位移量
        if ([dic_condent objectForKey:@"imgurl"]) {
            UIImageView *strateg_img=[[UIImageView alloc] initWithFrame:CGRectMake(40, height, 240, 100)];
            strateg_img.image=[UIImage imageNamed:[dic_condent objectForKey:@"imgurl"]];
            height=height+100;
            strategyView.frame=CGRectMake(0, 0, self.view.frame.size.width, height);
            [strategyView addSubview:strateg_img];
        }

    }
    [strategy_view_arr addObject:strategyView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [strategy_view_arr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    MaintableCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
    cell = [[MaintableCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
    }
    [cell.contentView addSubview:[strategy_view_arr objectAtIndex:indexPath.row]];
    cell.userInteractionEnabled = NO;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIView *view=[strategy_view_arr objectAtIndex:indexPath.row];
    return view.frame.size.height;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getstrategyinfo:(NSDictionary*)thedic{
    dic_info=thedic;
}
@end
