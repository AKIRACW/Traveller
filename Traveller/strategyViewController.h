//
//  strategyViewController.h
//  Traveller
//
//  Created by TY on 14-3-27.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaintableCell.h"
@interface strategyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *dic_info;
    NSMutableArray *strategy_view_arr;
}
@property(nonatomic,strong)UITableView *table;
-(void)getstrategyinfo:(NSDictionary*)thedic;
@end
