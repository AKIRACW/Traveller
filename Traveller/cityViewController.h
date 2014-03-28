//
//  cityViewController.h
//  Traveller
//
//  Created by TY on 14-3-24.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaintableCell.h"
#import "SBJson.h"
#import "strategyViewController.h"
@interface cityViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    UIButton *strategy_btn;
    UIButton *introduction_btn;
    NSMutableDictionary *_citydic;
    NSMutableArray *_infoArray;
    NSMutableArray *_ViewArray;
    NSMutableArray *_strategy_arr;
    NSMutableArray *_strategy_view_arr;
    
    int _thepage;
}
@property(nonatomic,strong)UITableView *table;
-(void)getcityInfo:(NSMutableDictionary*)thedic;
@end
