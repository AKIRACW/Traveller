//
//  SelectVc.m
//  Traveller
//  
//  Created by TY on 14-3-21.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "SelectVc.h"
#import "iCarousel.h"
#import "Post_activity_postsVC.h"
#import "Post_travel_note_postsVC.h"
@interface SelectVc ()<iCarouselDataSource, iCarouselDelegate>
{
    iCarousel *_icarousel;
}
@end

@implementation SelectVc

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
	// Do any additional setup after loading the view.
    self.title = @"帖子类型";
    _icarousel = [[iCarousel alloc]init];
    [_icarousel setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [_icarousel setBackgroundColor:[UIColor grayColor]];
    _icarousel.type = iCarouselTypeCoverFlow;
    [_icarousel setDelegate:self];
    [_icarousel setDataSource:self];
    [self.view addSubview:_icarousel];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - iCarousel数据源
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //generate 100 buttons
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return 2;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	UIButton *button = (UIButton *)view;
	if (button == nil)
	{
		//no button available to recycle, so create new one
		UIImage *image = [UIImage imageNamed:@"icarousel_page.png"];
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[button setBackgroundImage:image forState:UIControlStateNormal];
		button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
	
	//set button label
    if (index==0) {
        [button setTitle:[NSString stringWithFormat:@"活动贴"] forState:UIControlStateNormal];
    }else if(index == 1){
        [button setTitle:[NSString stringWithFormat:@"经验贴"] forState:UIControlStateNormal];
    }
	return button;
}

#pragma mark - Button tap event

- (void)buttonTapped:(UIButton *)sender
{
    if ([sender.titleLabel.text isEqualToString:@"活动贴"]) {
        Post_activity_postsVC *_post_activityVC = [[Post_activity_postsVC alloc]init];
        [self.navigationController pushViewController:_post_activityVC animated:YES];
    }else{
        Post_travel_note_postsVC *_post_travel_noteVC = [[Post_travel_note_postsVC alloc]init];
        
        [self.navigationController pushViewController:_post_travel_noteVC animated:YES];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
@end