//
//  User.h
//  Traveller
//  用户类
//  Created by Ronaldinho on 14-3-21.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface UserModel : NSObject
//用户ID
@property(nonatomic,assign)int User_id;
//用户昵称
@property(nonatomic,strong)NSString *User_nickname;
//用户头像
@property(nonatomic,strong)NSString *User_headphoto;
//用户参与的活动
@property(nonatomic,strong)NSMutableArray *User_activity_list;
//用户位置
@property(nonatomic,assign)float USER_Latitude;//纬度
@property(nonatomic,assign)float USER_Longtitude;//经度
//用户所在城市
@property(nonatomic,strong)NSString *USER_City;


+(id)sharedUserModel;


@end
