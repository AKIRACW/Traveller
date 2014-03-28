//
//  weatherjson.m
//  Traveller
//
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "weatherjson.h"
#import "SBJson.h"

@implementation weatherjson
+(weatherModel*)newWeatherWithString:(NSString*)newInfojson{
    NSMutableDictionary *dicjson=[newInfojson JSONValue];
    NSMutableDictionary *dicWeather=[dicjson objectForKey:@"weatherinfo"];
    weatherModel *model=[[weatherModel alloc] init];
    model.city=[dicWeather objectForKey:@"city"];
    model.city_en=[dicWeather objectForKey:@"cityid"];
    model.date_y=[dicWeather objectForKey:@"ptime"];
    model.week=[dicWeather objectForKey:@"week"];
    model.temp=[dicWeather objectForKey:@"temp1"];
    model.weather=[dicWeather objectForKey:@"weather"];
    NSLog(@"%@",model.city);
    return model;
}

+(int)cityChangCityID:(NSString*)theCity{
    if ([theCity isEqual:@"重庆"]) {
            return 101040100;
    }else if([theCity isEqual:@"北京"]){
        return 101010100;
    }else if([theCity isEqual:@"上海"]){
    return 101020100;
    }else if([theCity isEqual:@"济南"]){
        return 101120101;
    }else{
        return 101040100;
    }
}
@end
