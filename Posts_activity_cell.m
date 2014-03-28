//
//  Posts_activity_cell.m
//  Traveller
//
//  Created by Ronaldinho on 14-3-22.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "Posts_activity_cell.h"

@implementation Posts_activity_cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //头像
        self.User_headPhoto = [[UIImageView alloc]init];
        [self.User_headPhoto setFrame:CGRectMake(10, 15, 50, 50)];
        //标题
        self.labelForTitle = [[UILabel alloc]init];
        [self.labelForTitle setFrame:CGRectMake(70, 0, 180, 50)];
        self.labelForTitle.font = [UIFont systemFontOfSize:20.0f];
        self.labelForTitle.numberOfLines = 1;
        self.labelForTitle.adjustsFontSizeToFitWidth = YES;
        self.labelForTitle.textColor = [UIColor blackColor];
        self.labelForTitle.textAlignment = NSTextAlignmentCenter;
        //活动地点
        self.labelForLocation = [[UILabel alloc]init];
        [self.labelForLocation setFrame:CGRectMake(70, self.labelForTitle.frame.size.height, 180, 30)];
        self.labelForLocation.font = [UIFont systemFontOfSize:15.0f];
        self.labelForLocation.textColor = [UIColor blackColor];
        self.labelForLocation.textAlignment = NSTextAlignmentCenter;
        //发帖人
        self.labelForNickname = [[UILabel alloc]init];
        [self.labelForNickname setFrame:CGRectMake(258, 0, 58, 30)];
        self.labelForNickname.font = [UIFont italicSystemFontOfSize:10.0f];
        self.labelForNickname.adjustsFontSizeToFitWidth = YES;
        self.labelForNickname.textColor = [UIColor blackColor];
        self.labelForNickname.textAlignment = NSTextAlignmentCenter;
        //参加按钮
        self.btnForJoin = [[UIButton alloc]init];
        [self.btnForJoin setFrame:CGRectMake(258, self.labelForTitle.frame.size.height, 30, 30)];
        //按钮的正常和选中状态
        [self.btnForJoin setBackgroundImage:[UIImage imageNamed:@"bookmark_no"] forState:UIControlStateNormal];
        [self.btnForJoin setBackgroundImage:[UIImage imageNamed:@"bookmark_yes"] forState:UIControlStateSelected];
        //添加进cell内容视图
        [self addSubview:self.User_headPhoto];
        [self addSubview:self.labelForTitle];
        [self addSubview:self.labelForLocation];
        [self addSubview:self.labelForNickname];
        [self addSubview:self.btnForJoin];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setUserPhoto:(NSString *)ThePhotoName{
    [self.User_headPhoto setImage:[UIImage imageNamed:ThePhotoName]];
}
-(void)setTitle:(NSString *)TheTitle{
    [self.labelForTitle setText:TheTitle];
}
-(void)setLocation:(NSString *)TheLocation{
    [self.labelForLocation setText:TheLocation];
}
-(void)setNickName:(NSString *)TheNickName{
    [self.labelForNickname setText:TheNickName];
}
@end
