//
//  hotspotColloctionViewController.h
//  Traveller
//
//  Created by TY on 14-3-26.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hotspotCell.h"
#import "strategyViewController.h"
@interface hotspotColloctionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    NSMutableDictionary *dic_info;
}
@property(nonatomic,strong)UITableView *table;
@end
