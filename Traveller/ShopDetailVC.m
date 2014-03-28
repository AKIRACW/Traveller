//
//  ShopDetailVC.m
//  Traveller
//
//  Created by TY on 14-3-25.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "ShopDetailVC.h"

@interface ShopDetailVC ()

@end

@implementation ShopDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = self.shop.name;
    //返回按钮
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelShopDetail)];
    self.navigationItem.leftBarButtonItem = left;
    
    //收藏按钮
    UIButton *btnCollection = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btnCollection addTarget:self action:@selector(collectShop:) forControlEvents:UIControlEventTouchUpInside];
    [btnCollection setBackgroundImage:[UIImage imageNamed:@"bookmark_no"] forState:UIControlStateNormal];
    [btnCollection setBackgroundImage:[UIImage imageNamed:@"bookmark_yes"] forState:UIControlStateSelected];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:btnCollection];
    self.navigationItem.rightBarButtonItem = right;
    //
    [self initSubViews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)cancelShopDetail{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)collectShop:(id)sender{
    UIButton *btn = sender;
    
    if (btn.isSelected) {
        NSLog(@"cllection");

        
    }else{
        NSLog(@"uncllection");
        
    }
}

- (void)initSubViews{
    self.lbName = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, self.view.bounds.size.width-20, 30)];
    self.lbName.text = self.shop.name;
    self.lbName.textAlignment = NSTextAlignmentCenter;
    //[self.view addSubview:self.lbName];
    
    self.imgPhoto = [[EGOImageView alloc] initWithFrame:CGRectMake(10, 114, 100, 100)];
    self.imgPhoto.placeholderImage = [UIImage imageNamed:@"placeholder"];
    self.imgPhoto.imageURL = [NSURL URLWithString:self.shop.photo_url];
    //[self.view addSubview:self.imgPhoto];
    
    self.webShop = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.shop.business_url]];
    [self.webShop loadRequest:request];
    [self.view addSubview:self.webShop];
    
}
@end
