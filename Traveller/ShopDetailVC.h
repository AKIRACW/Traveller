//
//  ShopDetailVC.h
//  Traveller
//
//  Created by TY on 14-3-25.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessModel.h"
#import "EGOImageView.h"

@interface ShopDetailVC : UIViewController
@property(nonatomic,strong)BusinessModel *shop;
@property(nonatomic,strong)EGOImageView *imgPhoto;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UIWebView *webShop;

@end
