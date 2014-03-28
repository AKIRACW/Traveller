//
//  User.m
//  Traveller
//
//  Created by Ronaldinho on 14-3-21.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
@synthesize User_id;
@synthesize User_nickname;
@synthesize User_headphoto;
@synthesize User_activity_list;

static UserModel *userModel_one;
+(id)sharedUserModel{
    if (!userModel_one) {
        userModel_one = [[UserModel alloc]init];
        userModel_one.User_activity_list = [[NSMutableArray alloc]init];
    }
    return userModel_one;
}



-(void)encodeWithCoder:(NSCoder *)aCoder{
	NSString *strUser_id=[NSString stringWithFormat:@"%d",User_id];
    [aCoder encodeObject:strUser_id forKey:@"User_id"];
    [aCoder encodeObject:User_nickname forKey:@"User_nickname"];
    [aCoder encodeObject:User_headphoto forKey:@"User_headphoto"];
    [aCoder encodeObject:User_activity_list forKey:@"User_activity_list"];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    NSString *strUser_id=[aDecoder decodeObjectForKey:@"User_id"];
	User_id=[strUser_id intValue];
    User_nickname=[aDecoder decodeObjectForKey:@"User_nickname"];
    User_headphoto=[aDecoder decodeObjectForKey:@"User_headphoto"];
    User_activity_list=[aDecoder decodeObjectForKey:@"User_activity_list"];
    return self;
}
@end
