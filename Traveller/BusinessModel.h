//
//  BusinessModel.h
//  Traveller
//  商户类
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessModel : NSObject
@property(nonatomic,assign)int business_id; //商户ID
@property(nonatomic,strong)NSString *name;  //商户名
@property(nonatomic,strong)NSString *branch_name;   //分店名
@property(nonatomic,strong)NSString *address;   //地址
@property(nonatomic,strong)NSString *telephone; //带区号的电话
@property(nonatomic,strong)NSString *city;  //所在城市
@property(nonatomic,strong)NSArray *regions;    //所在区域信息列表，如[徐汇区，徐家汇]
@property(nonatomic,strong)NSArray *categories; //所属分类信息列表，如[宁波菜，婚宴酒店]
@property(nonatomic,assign)float latitude;    //纬度坐标
@property(nonatomic,assign)float longitude;   //经度坐标
@property(nonatomic,assign)float avg_rating;  //星级评分，5.0代表五星，4.5代表四星半，依此类推
@property(nonatomic,strong)NSString *rating_img_url;    //星级图片链接
@property(nonatomic,strong)NSString *rating_s_img_url;  //小尺寸星级图片链接
@property(nonatomic,assign)int product_grade;   //产品/食品口味评价，1:一般，2:尚可，3:好，4:很好，5:非常好
@property(nonatomic,assign)int decoration_grade;    //环境评价，1:一般，2:尚可，3:好，4:很好，5:非常好
@property(nonatomic,assign)int service_grade;   //服务评价，1:一般，2:尚可，3:好，4:很好，5:非常好
@property(nonatomic,assign)float product_score;   //产品/食品口味评价单项分，精确到小数点后一位（十分制）
@property(nonatomic,assign)float decoration_score;    //环境评价单项分，精确到小数点后一位（十分制）
@property(nonatomic,assign)float service_score;   //服务评价单项分，精确到小数点后一位（十分制）
@property(nonatomic,assign)int avg_price;   //人均价格，单位:元，若没有人均，返回-1
@property(nonatomic,assign)int review_count;    //点评数量
@property(nonatomic,assign)int distance;    //商户与参数坐标的距离，单位为米，如不传入经纬度坐标，结果为-1
@property(nonatomic,strong)NSString *business_url;  //商户页面链接
@property(nonatomic,strong)NSString *photo_url; //照片链接，照片最大尺寸700×700
@property(nonatomic,strong)NSString *s_photo_url;   //小尺寸照片链接，照片最大尺寸278×200
@property(nonatomic,assign)int has_coupon;  //是否有优惠券，0:没有，1:有
@property(nonatomic,assign)int coupon_id;   //优惠券ID
@property(nonatomic,strong)NSString *coupon_description;    //优惠券描述
@property(nonatomic,strong)NSString *coupon_url;    //优惠券页面链接
@property(nonatomic,assign)int has_deal;    //是否有团购，0:没有，1:有
@property(nonatomic,assign)int deal_count;  //商户当前在线团购数量
@property(nonatomic,strong)NSArray *deals;  //团购列表
@property(nonatomic,assign)int has_online_reservation;  //是否有在线预订，0:没有，1:有
@property(nonatomic,strong)NSString *online_reservation_url;    //在线预订页面链接，目前仅返回HTML5站点链接

+ (BusinessModel *)setDetailWithDic:(NSDictionary *)dic;
@end
