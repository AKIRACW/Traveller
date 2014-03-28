//
//  weatherjson.h
//  Traveller
//
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "weatherModel.h"
@interface weatherjson : NSObject
+(weatherModel*)newWeatherWithString:(NSString*)newInfojson;
+(int)cityChangCityID:(NSString*)theCity;
@end
