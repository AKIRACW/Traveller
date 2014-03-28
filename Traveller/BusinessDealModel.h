//
//  BusinessDealModel.h
//  Traveller
//  团购类
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "BusinessModel.h"

@interface BusinessDealModel : BusinessModel
@property(nonatomic,strong)NSString *deal_id;   //团购单ID
@property(nonatomic,strong)NSString *description;   //团购描述
@property(nonatomic,strong)NSString *deal_url; //团购Web页面链接，适用于网页应用
@property(nonatomic,strong)NSString *deal_h5_url; //团购HTML5页面链接，适用于移动应用和联网车载应用
@end
