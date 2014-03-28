//
//  ShopListCell.h
//  Traveller
//
//  Created by TY on 14-3-24.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
#import "BusinessModel.h"

@interface ShopListCell : UITableViewCell
@property (strong, nonatomic) EGOImageView *imgPhoto;
@property (strong, nonatomic) IBOutlet UILabel *lbName;
@property (strong, nonatomic) IBOutlet UILabel *lbAvg_price;
@property (strong, nonatomic) EGOImageView *imgRate;
@property (strong, nonatomic) IBOutlet UILabel *lbAddress;
@property (strong, nonatomic) IBOutlet UILabel *lbDistence;

- (void)setCellWithBusinessModel:(BusinessModel *)model;
@end
