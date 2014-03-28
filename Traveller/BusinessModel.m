//
//  BusinessModel.m
//  Traveller
//
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "BusinessModel.h"

@implementation BusinessModel
+ (BusinessModel *)setDetailWithDic:(NSDictionary *)dic{
    BusinessModel *business = [[BusinessModel alloc] init];
    business.business_id = [[dic objectForKey:@"business_id"] intValue];
    business.name = [dic objectForKey:@"name"];
    business.branch_name = [dic objectForKey:@"branch_name"];
    business.address = [dic objectForKey:@"address"];
    business.telephone = [dic objectForKey:@"telephone"];
    business.city = [dic objectForKey:@"city"];
    business.regions = [dic objectForKey:@"regions"];
    business.categories = [dic objectForKey:@"categories"];
    business.latitude = [[dic objectForKey:@"latitude"] floatValue];
    business.longitude = [[dic objectForKey:@"longitude"] floatValue];
    business.avg_rating = [[dic objectForKey:@"avg_rating"] floatValue];
    business.rating_img_url = [dic objectForKey:@"rating_img_url"];
    business.rating_s_img_url = [dic objectForKey:@"rating_s_img_url"];
    business.product_grade = [[dic objectForKey:@"product_grade"] intValue];
    business.decoration_grade = [[dic objectForKey:@"decoration_grade"] intValue];
    business.service_grade = [[dic objectForKey:@"service_grade"] intValue];
    business.product_score = [[dic objectForKey:@"product_score"] floatValue];
    business.decoration_score = [[dic objectForKey:@"decoration_score"] floatValue];
    business.service_score = [[dic objectForKey:@"service_score"] floatValue];
    business.avg_price = [[dic objectForKey:@"avg_price"] intValue];
    business.review_count = [[dic objectForKey:@"review_count"] intValue];
    business.distance = [[dic objectForKey:@"distance"] intValue];
    business.business_url = [dic objectForKey:@"business_url"];
    business.photo_url = [dic objectForKey:@"photo_url"];
    business.s_photo_url = [dic objectForKey:@"s_photo_url"];
    business.has_coupon = [[dic objectForKey:@"has_coupon"] intValue];
    business.coupon_id = [[dic objectForKey:@"coupon_id"] intValue];
    business.coupon_description = [dic objectForKey:@"coupon_description"];
    business.coupon_url = [dic objectForKey:@"coupon_url"];
    business.has_deal = [[dic objectForKey:@"has_deal"] intValue];
    business.deal_count = [[dic objectForKey:@"deal_count"] intValue];
    business.deals = [dic objectForKey:@"deals"];
    business.has_online_reservation = [[dic objectForKey:@"has_online_reservation"] intValue];
    business.online_reservation_url = [dic objectForKey:@"online_reservation_url"];
    return business;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[NSNumber numberWithInt:self.business_id] forKey:@"bussiness_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.branch_name forKey:@"branch_name"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:self.telephone forKey:@"telephone"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.regions forKey:@"regions"];
    [aCoder encodeObject:self.categories forKey:@"categories"];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.latitude] forKey:@"latitude"];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.longitude] forKey:@"longitude"];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.avg_rating] forKey:@"avg_rating"];
    [aCoder encodeObject:self.rating_img_url forKey:@"rating_img_url"];
    [aCoder encodeObject:self.rating_s_img_url forKey:@"rating_s_img_url"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.product_grade] forKey:@"product_grade"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.decoration_grade] forKey:@"decoration_grade"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.service_grade] forKey:@"service_grade"];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.product_score] forKey:@"product_score"];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.decoration_score] forKey:@"decoration_score"];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.service_score] forKey:@"service_score"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.avg_price] forKey:@"avg_price"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.review_count] forKey:@"review_count"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.distance] forKey:@"distance"];
    [aCoder encodeObject:self.business_url forKey:@"business_url"];
    [aCoder encodeObject:self.photo_url forKey:@"photo_url"];
    [aCoder encodeObject:self.s_photo_url forKey:@"s_photo_url"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.has_coupon] forKey:@"has_coupon"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.coupon_id] forKey:@"coupon_id"];
    [aCoder encodeObject:self.coupon_description forKey:@"coupon_description"];
    [aCoder encodeObject:self.coupon_url forKey:@"coupon_url"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.has_deal] forKey:@"has_deal"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.deal_count] forKey:@"deal_count"];
    [aCoder encodeObject:self.deals forKey:@"deals"];
    [aCoder encodeObject:[NSNumber numberWithInt:self.has_online_reservation] forKey:@"has_online_reservation"];
    [aCoder encodeObject:self.online_reservation_url forKey:@"online_reservation_url"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self.business_id = [[aDecoder decodeObjectForKey:@"business_id"] intValue];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.branch_name = [aDecoder decodeObjectForKey:@"branch_name"];
    self.address = [aDecoder decodeObjectForKey:@"address"];
    self.telephone = [aDecoder decodeObjectForKey:@"telephone"];
    self.city = [aDecoder decodeObjectForKey:@"city"];
    self.regions = [aDecoder decodeObjectForKey:@"regions"];
    self.categories = [aDecoder decodeObjectForKey:@"categories"];
    self.latitude = [[aDecoder decodeObjectForKey:@"latitude"] floatValue];
    self.longitude = [[aDecoder decodeObjectForKey:@"longitude"] floatValue];
    self.avg_rating = [[aDecoder decodeObjectForKey:@"avg_rating"] floatValue];
    self.rating_img_url = [aDecoder decodeObjectForKey:@"rating_img_url"];
    self.rating_s_img_url = [aDecoder decodeObjectForKey:@"rating_s_img_url"];
    self.product_grade = [[aDecoder decodeObjectForKey:@"product_grade"] intValue];
    self.decoration_grade = [[aDecoder decodeObjectForKey:@"decoration_grade"] intValue];
    self.service_grade = [[aDecoder decodeObjectForKey:@"service_grade"] intValue];
    self.product_score = [[aDecoder decodeObjectForKey:@"product_score"] floatValue];
    self.decoration_score = [[aDecoder decodeObjectForKey:@"decoration_score"] floatValue];
    self.service_score = [[aDecoder decodeObjectForKey:@"service_score"] floatValue];
    self.avg_price = [[aDecoder decodeObjectForKey:@"avg_price"] intValue];
    self.review_count = [[aDecoder decodeObjectForKey:@"review_count"] intValue];
    self.distance = [[aDecoder decodeObjectForKey:@"distance"] intValue];
    self.business_url = [aDecoder decodeObjectForKey:@"business_url"];
    self.photo_url = [aDecoder decodeObjectForKey:@"photo_url"];
    self.s_photo_url = [aDecoder decodeObjectForKey:@"s_photo_url"];
    self.has_coupon = [[aDecoder decodeObjectForKey:@"has_coupon"] intValue];
    self.coupon_id = [[aDecoder decodeObjectForKey:@"coupon_id"] intValue];
    self.coupon_description = [aDecoder decodeObjectForKey:@"coupon_description"];
    self.coupon_url = [aDecoder decodeObjectForKey:@"coupon_url"];
    self.has_deal = [[aDecoder decodeObjectForKey:@"has_deal"] intValue];
    self.deal_count = [[aDecoder decodeObjectForKey:@"deal_count"] intValue];
    self.deals = [aDecoder decodeObjectForKey:@"deals"];
    self.has_online_reservation = [[aDecoder decodeObjectForKey:@"has_online_reservation"] intValue];
    self.online_reservation_url = [aDecoder decodeObjectForKey:@"online_reservation_url"];
    
    return self;
}
@end
