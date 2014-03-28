//
//  PostsComment.h
//  Traveller
//  评论Model
//  Created by Ronaldinho on 14-3-27.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "UserModel.h"

@interface PostsComment : UserModel
//评论内容
@property(nonatomic,strong) NSString *Posts_comment_content;
//发布时间
@property(nonatomic,strong) NSString *Posts_comment_published;

@end
