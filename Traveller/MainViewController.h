//
//  MainViewController.h
//  Traveller
//
//  Created by TY on 14-3-19.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "weatherjson.h"
#import "weatherModel.h"
#import "cityViewController.h"
#import "MaintableCell.h"
#import "hotspotColloctionViewController.h"
#import <ImageIO/CGImageSource.h>
#import "ActingViewController.h"
@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_Viewarr;
    NSDictionary *_dicCityInfo;

}
@property(nonatomic,strong)UIView *hot_Spot_view;
@property(nonatomic,strong)UIView *hot_post_view;
@property(nonatomic,strong)UIView *Function_view;
@property(nonatomic,strong)UIView *weather_view;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIScrollView *hot_spot_scrollView;
@property(nonatomic,strong)weatherModel *weather_model;
@end
