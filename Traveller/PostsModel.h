//
//  PostsModel.h
//  Traveller
//  帖子model
//  Created by Ronaldinho on 14-3-21.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "UserModel.h"

@interface PostsModel : UserModel
//帖子id
@property(nonatomic,assign)int Posts_id;
//帖子类型(0 - 活动贴 1 - 经验贴)
@property(nonatomic,assign)int Posts_type;
//帖子标题
@property(nonatomic,strong)NSString *Posts_title;
//帖子内容
@property(nonatomic,strong)NSString *Posts_content;

@end
