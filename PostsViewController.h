//
//  PostsViewController.h
//  Traveller
//  帖子
//  Created by TY on 14-3-21.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostsViewController : UIViewController
@property(nonatomic,strong) NSMutableArray *Posts_data;
@property(nonatomic,strong) UITableView *Posts_tableview;
@property(nonatomic,strong) NSMutableArray *Posts_travel_note_data;

@end
