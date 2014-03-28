//
//  hotspotCell.m
//  Traveller
//
//  Created by apple on 14-3-27.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "hotspotCell.h"

@implementation hotspotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lblinfo=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 20)];
        self.lblinfo.font=[UIFont systemFontOfSize:12];
        [self.lblinfo setTextAlignment:NSTextAlignmentCenter];
        
        [self.contentView addSubview:self.lblinfo];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
