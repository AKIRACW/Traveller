//
//  DPRequest.m
//  Traveller
//
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "DPRequest.h"
#import <CommonCrypto/CommonDigest.h>
@implementation DPRequest
+ (NSDictionary *)parseQueryString:(NSString *)query {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:6];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    
    for (NSString *pair in pairs) {
        NSArray *elements = [pair componentsSeparatedByString:@"="];
		
		if ([elements count] <= 1) {
			return nil;
		}
		
        NSString *key = [[elements objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *val = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [dict setObject:val forKey:key];
    }
    return dict;
}

+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params
{
	NSURL* parsedURL = [NSURL URLWithString:[baseURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithDictionary:[self parseQueryString:[parsedURL query]]];
	if (params) {
		[paramsDic setValuesForKeysWithDictionary:params];
	}
	
	NSMutableString *signString = [NSMutableString stringWithString:DPAppKey];
	NSMutableString *paramsString = [NSMutableString stringWithFormat:@"appkey=%@", DPAppKey];
	NSArray *sortedKeys = [[paramsDic allKeys] sortedArrayUsingSelector: @selector(compare:)];
	for (NSString *key in sortedKeys) {
		[signString appendFormat:@"%@%@", key, [paramsDic objectForKey:key]];
		[paramsString appendFormat:@"&%@=%@", key, [paramsDic objectForKey:key]];
	}
	[signString appendString:DPAppSecret];
	unsigned char digest[CC_SHA1_DIGEST_LENGTH];
	NSData *stringBytes = [signString dataUsingEncoding: NSUTF8StringEncoding];
	if (CC_SHA1([stringBytes bytes], [stringBytes length], digest)) {
		/* SHA-1 hash has been calculated and stored in 'digest'. */
		NSMutableString *digestString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
		for (int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
			unsigned char aChar = digest[i];
			[digestString appendFormat:@"%02X", aChar];
		}
		[paramsString appendFormat:@"&sign=%@", [digestString uppercaseString]];
		return [NSString stringWithFormat:@"%@://%@%@?%@", [parsedURL scheme], [parsedURL host], [parsedURL path], [paramsString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	} else {
		return nil;
	}
}

+ (NSArray *)getBusinessListByUser:(UserModel *)user andCategory:(NSString *)category andRadius:(int)radius andSort:(int)sort andPage:(int)page{
    
    NSMutableArray *arrBusiness = [[NSMutableArray alloc] init];
    NSString *strParam = [NSString stringWithFormat:@"category=%@&city=%@&latitude=%f&longitude=%f&sort=%d&limit=5&offset_type=1&out_offset_type=1&platform=2&page=%d&radius=%d",category,user.USER_City,user.USER_Latitude,user.USER_Longtitude,sort,page,radius];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?%@",DPRequestUrl,DPRequestFindShops,strParam];
    NSURL *url = [NSURL URLWithString:[DPRequest serializeURL:strUrl params:nil]];
    
    NSString *strContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [strContent JSONValue];
    NSArray *arrJsonData = [dic objectForKey:@"businesses"];
    for (int i=0; i<arrJsonData.count; i++) {
        NSDictionary *dicBusiness = arrJsonData[i];
        BusinessModel *temp = [BusinessModel setDetailWithDic:dicBusiness];
        [arrBusiness addObject:temp];
    }
    return arrBusiness;
}
+ (NSArray *)getBusinessListByRadius:(int)radius andSort:(int)sort andlatitude:(float)lat andLongtitude:(float)lng andPage:(int)page{
    NSMutableArray *arrBusiness = [[NSMutableArray alloc] init];
    NSString *strParam = [NSString stringWithFormat:@"latitude=%f&longitude=%f&sort=%d&limit=5&offset_type=1&out_offset_type=1&platform=2&page=%d&radius=%d",lat,lng,sort,page,radius];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?%@",DPRequestUrl,DPRequestFindShops,strParam];
    NSURL *url = [NSURL URLWithString:[DPRequest serializeURL:strUrl params:nil]];
    
    NSString *strContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [strContent JSONValue];
    NSArray *arrJsonData = [dic objectForKey:@"businesses"];
    for (int i=0; i<arrJsonData.count; i++) {
        NSDictionary *dicBusiness = arrJsonData[i];
        BusinessModel *temp = [BusinessModel setDetailWithDic:dicBusiness];
        [arrBusiness addObject:temp];
    }
    return arrBusiness;
}

//根据关键词搜索
+ (NSArray *)getBusinessListByKeyword:(NSString *)keyword andCity:(NSString *)city{
    NSMutableArray *arrBusiness = [[NSMutableArray alloc] init];
    NSString *strParam = [NSString stringWithFormat:@"keyword=%@&city=%@",keyword,city];
    NSString *strUrl = [NSString stringWithFormat:@"%@%@?%@",DPRequestUrl,DPRequestFindShops,strParam];
    NSURL *url = [NSURL URLWithString:[DPRequest serializeURL:strUrl params:nil]];
    
    NSString *strContent = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [strContent JSONValue];
    NSArray *arrJsonData = [dic objectForKey:@"businesses"];
    for (int i=0; i<arrJsonData.count; i++) {
        NSDictionary *dicBusiness = arrJsonData[i];
        BusinessModel *temp = [BusinessModel setDetailWithDic:dicBusiness];
        [arrBusiness addObject:temp];
    }
    return arrBusiness;
}
@end
