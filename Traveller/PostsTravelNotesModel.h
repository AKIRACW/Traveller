//
//  PostsTravelNotesModel.h
//  Traveller
//  游记,经验贴model
//  Created by TY on 14-3-26.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "PostsModel.h"

@interface PostsTravelNotesModel : PostsModel
//旅游城市
@property(nonatomic,strong) NSString *Posts_travel_notes_city;
//旅游图片
@property(nonatomic,strong) NSString *Posts_travel_notes_image;

@end
