//
//  SettingVC.h
//  Traveller
//
//  Created by TY on 14-3-19.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingVC : UIViewController<UINavigationBarDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *AccountLbl;
@property (strong, nonatomic) IBOutlet UILabel *ShareLbl;
@property (strong, nonatomic) IBOutlet UILabel *FeedbackLbl;
@property (strong, nonatomic) IBOutlet UILabel *ClearImgCache ;

@end
