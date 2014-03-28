//
//  Posts_activity_cell.h
//  Traveller
//
//  Created by Ronaldinho on 14-3-22.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Posts_activity_cell : UITableViewCell
@property (strong, nonatomic)  UILabel *labelForTitle;
@property (strong, nonatomic)  UILabel *labelForLocation;
@property (strong, nonatomic)  UIImageView *User_headPhoto;
@property (strong, nonatomic)  UILabel *labelForNickname;
@property (strong, nonatomic)  UIButton *btnForJoin;
-(void)setUserPhoto:(NSString *)ThePhotoName;
-(void)setTitle:(NSString *)TheTitle;
-(void)setLocation:(NSString *)TheLocation;
-(void)setNickName:(NSString *)TheNickName;
@end
