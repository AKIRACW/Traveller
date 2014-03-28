//
//  ShopListCell.m
//  Traveller
//
//  Created by TY on 14-3-24.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "ShopListCell.h"

@implementation ShopListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setCellWithBusinessModel:(BusinessModel *)model{
    self.imgPhoto = [[EGOImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    self.imgRate = [[EGOImageView alloc] initWithFrame:CGRectMake(98, 29, 117, 22)];
    [self addSubview:self.imgPhoto];
    [self addSubview:self.imgRate];

    self.lbName.text = model.name;
    self.lbAvg_price.text = [NSString stringWithFormat:@"人均：%d元",model.avg_price];
    self.lbAddress.text = model.address;
    self.lbDistence.text = [NSString stringWithFormat:@"距离：%dm",model.distance];
<<<<<<< HEAD
    self.imgPhoto.placeholderImage = [UIImage imageNamed:@"placeholder"];
    self.imgRate.placeholderImage = [UIImage imageNamed:@"placeholder"];
    [self.imgPhoto setImageURL:[NSURL URLWithString:model.photo_url]];
    [self.imgRate setImageURL:[NSURL URLWithString:model.rating_img_url]];
=======
    NSURL *urlPhoto = [NSURL URLWithString:model.photo_url];
    NSURL *urlRate = [NSURL URLWithString:model.rating_img_url];
    self.imgPhoto.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlPhoto]];
    self.imgRate.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlRate]];
>>>>>>> FETCH_HEAD
}
@end
