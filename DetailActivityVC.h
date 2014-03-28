//
//  DetailActivityVC.h
//  Traveller
//  活动贴的详细页面
//  Created by Ronaldinho on 14-3-23.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostsActivityModel.h"
#define MAIN_LABEL_Y_ORIGIN 0
#define IMAGEVIEW_Y_ORIGIN 15

@interface DetailActivityVC : UIViewController
@property (strong, nonatomic)  PostsActivityModel *posts_activity_model;
@property (strong, nonatomic)  UILabel *labelForTitle;
@property (strong, nonatomic)  UILabel *labelForLocation;
@property (strong, nonatomic)  UIImageView *User_headPhoto;
@property (strong, nonatomic)  UILabel *labelForNickname;
@property (strong, nonatomic)  UIButton *btnForJoin;
@property (strong, nonatomic)  UITextView *textviewForDetail;
@property (strong, nonatomic)  UIButton *doneBtn;
@property (assign,nonatomic) BOOL isJoin;
//上层背景图
@property (strong, nonatomic)  UIImageView *backgroundImageView;
//上一个的tableviewcell所在视图的位置信息
@property (readwrite, nonatomic) int yOrigin;

@end
