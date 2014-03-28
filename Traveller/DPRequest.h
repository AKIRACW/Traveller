//
//  DPRequest.h
//  Traveller
//
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SBJson.h"
#import "BusinessModel.h"
#import "UserModel.h"

@interface DPRequest : NSObject
@property(nonatomic, strong)NSString *url;
@property(nonatomic, strong)NSDictionary *params;

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params;

+ (NSArray *)getBusinessListByUser:(UserModel *)user andCategory:(NSString *)category andRadius:(int)radius andSort:(int)sort andPage:(int)page;
+ (NSArray *)getBusinessListByRadius:(int)radius andSort:(int)sort andlatitude:(float)lat andLongtitude:(float)lng andPage:(int)page;

//根据关键词搜索
+ (NSArray *)getBusinessListByKeyword:(NSString *)keyword andCity:(NSString *)city;
@end
