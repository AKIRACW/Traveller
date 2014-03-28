//
//  PostsViewController.m
//  Traveller
//
//  Created by TY on 14-3-21.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "PostsViewController.h"
#import "Post_activity_postsVC.h"
#import "SBJson.h"
#import "iCarousel.h"
#import "SelectVc.h"
#import "Posts_activity_cell.h"
#import "PostsActivityModel.h"
#import "UserModel.h"
#import "DetailActivityVC.h"
#import "iCarousel.h"
#import "PostsTravelNotesModel.h"
#import "DetailTravelNoteVC.h"
@interface PostsViewController ()<UITableViewDelegate,UITableViewDataSource,iCarouselDataSource,iCarouselDelegate>
{
    UISegmentedControl *_segment_posts_type;
    //顶部菜单弹出视图
    UIView *pop_menu_view;
    iCarousel *icarousel;
    //icarousel背景图
    UIImageView *icarousel_bg;
    //icarousel标题栏
    UILabel *icarousel_title;
    //icarousel帖子数量指示
    UIPageControl *icarousel_pageControl;
    //当前icarousel的button标示值
    NSInteger current_icarousel_button_tag;
}
@end

@implementation PostsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//导航栏右键
-(void)init_nav_right_button{
    UIBarButtonItem *navLeftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(Post_posts:)];
    self.navigationItem.rightBarButtonItem = navLeftItem;
    
}
-(void)init_Posts_tableview{
    _Posts_tableview = [[UITableView alloc]init];
    [_Posts_tableview setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [_Posts_tableview setDelegate:self];
    [_Posts_tableview setDataSource:self];
    [self.view addSubview:_Posts_tableview];
    _segment_posts_type = [[UISegmentedControl alloc]init];
    [_segment_posts_type setFrame:CGRectMake(0, 0, 180, 30)];
    [_segment_posts_type insertSegmentWithTitle:@"活动贴" atIndex:0 animated:NO];
    [_segment_posts_type insertSegmentWithTitle:@"经验贴" atIndex:1 animated:NO];
    _segment_posts_type.backgroundColor = [UIColor clearColor];
    _segment_posts_type.selectedSegmentIndex = 0;
    [_segment_posts_type addTarget:self action:@selector(Change_to_type:) forControlEvents:UIControlEventValueChanged];
//    _Posts_tableview.tableHeaderView=_segment_posts_type;
}
-(void)set_icarousel_view{
    //configure carousel
    icarousel = [[iCarousel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:icarousel];
    [icarousel setCenter:CGPointMake(self.view.center.x+self.view.bounds.size.width*2, icarousel.center.y)];
    [icarousel setBackgroundColor:[UIColor clearColor]];
    icarousel.type = iCarouselTypeCylinder;
    icarousel.scrollSpeed = 0.5f;
//    icarousel.viewpointOffset = CGSizeMake(0, -137.08609);
//    icarousel.contentOffset = CGSizeMake(0, -83.44371);
    [icarousel setDelegate:self];
    [icarousel setDataSource:self];
    icarousel_bg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
//    [icarousel addSubview:icarousel_bg];
    icarousel_title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
    icarousel_title.numberOfLines = 1;
    icarousel_title.font = [UIFont italicSystemFontOfSize:17.0f];
    icarousel_title.textAlignment = NSTextAlignmentCenter;
    icarousel_title.adjustsFontSizeToFitWidth = YES;
    [icarousel_title setCenter:CGPointMake(self.view.center.x, self.view.center.y-150.0f)];
    [icarousel addSubview:icarousel_title];
    //pageControl
    icarousel_pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0,0,10,20)];
    icarousel_pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    icarousel_pageControl.pageIndicatorTintColor = [UIColor grayColor];
//   一定要注意对应的容器的数据啊 血的教训 +  _ + ||
//    icarousel_pageControl.numberOfPages = self.Posts_data.count;
    icarousel_pageControl.numberOfPages = self.Posts_travel_note_data.count;
    [icarousel_pageControl setCenter:CGPointMake(self.view.center.x, icarousel_title.center.y-30.0f)];
    [icarousel addSubview:icarousel_pageControl];

    
}
//加载本地帖子数据
-(void)LoadLocationDataForPosts{
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"Temp_posts_activity_data" ofType:@"plist"];
    NSMutableDictionary *plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    self.Posts_data = [plistDict objectForKey:@"Data"];
}
//加载一个临时UserModel测试一下
-(void)initUser{
    UserModel *user = [UserModel sharedUserModel];
    user.User_id = 13;
    user.User_nickname = @"文热大陆";
    user.User_headphoto = @"user_1.jpeg";
    PostsActivityModel *activity_1 = [[PostsActivityModel alloc]init];
    [activity_1 setPosts_id:1000];
    PostsActivityModel *activity_2 = [[PostsActivityModel alloc]init];
    [activity_2 setPosts_id:1001];
    PostsActivityModel *activity_3 = [[PostsActivityModel alloc]init];
    [activity_3 setPosts_id:1005];
    NSMutableArray *user_activity_list = [[NSMutableArray alloc]init];
    [user_activity_list addObject:activity_1];
//    [user_activity_list addObject:activity_2];
//    [user_activity_list addObject:activity_3];
    [user setUser_activity_list:user_activity_list];
}
//设置顶部切换菜单
-(void)setNavigation_title_menu_view{
    
    UIView *nav_title = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    UILabel *nav_title_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [nav_title_label setText:@"帖子"];
    nav_title_label.font = [UIFont italicSystemFontOfSize:18.0f];
    nav_title_label.numberOfLines = 1;
    nav_title_label.adjustsFontSizeToFitWidth = YES;
    nav_title_label.textColor = [UIColor blackColor];
    [nav_title_label setBackgroundColor:[UIColor clearColor]];
    UIButton *btn_nav_title = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [btn_nav_title setBackgroundColor:[UIColor clearColor]];
    [btn_nav_title addTarget:self action:@selector(Click_nav_menu:) forControlEvents:UIControlEventTouchUpInside];
    [nav_title addSubview:nav_title_label];
    [nav_title addSubview:btn_nav_title];
    [self.navigationItem setTitleView:nav_title];
    pop_menu_view = [[UIView alloc]initWithFrame:CGRectMake(0,0, 207, 60)];
    UIImageView *pop_menu_view_bg= [[UIImageView alloc]initWithFrame:pop_menu_view.frame];
    [pop_menu_view_bg setImage:[[UIImage imageNamed:@"popover_background"]stretchableImageWithLeftCapWidth:10 topCapHeight:30 ]];
    [pop_menu_view addSubview:pop_menu_view_bg];
    [_segment_posts_type setCenter:CGPointMake(pop_menu_view_bg.center.x, pop_menu_view_bg.center.y)];
    [pop_menu_view addSubview:_segment_posts_type];
    
    [pop_menu_view setCenter:CGPointMake(160, 60+30)];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.Posts_data = [[NSMutableArray alloc]init];
    self.Posts_travel_note_data = [[NSMutableArray alloc]init];
    
    [self init_nav_right_button];
    //    [self LoadLocationDataForPosts];
    self.Posts_data = [self loadUserJsonDataForLocation];
    self.Posts_travel_note_data = [self loadPostsTravelNoteData];
    [self initUser];
    [self init_Posts_tableview];
    [self setNavigation_title_menu_view];
    [self set_icarousel_view];
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Segement值改变
-(void)Change_to_type:(UISegmentedControl *)sender{
    switch (sender.selectedSegmentIndex) {
        case 0:{

            [UIView animateWithDuration:0.5f animations:^{
                [_Posts_tableview setCenter:CGPointMake(self.view.center.x, self.view.center.y) ];
                [icarousel setCenter:CGPointMake(self.view.center.x+self.view.bounds.size.width*2, self.view.center.y)];
                
            }];
            [self pop_menu_view_remove_animation];

        }
            break;
        case 1:{
            [UIView animateWithDuration:0.5f animations:^{
                [_Posts_tableview setCenter:CGPointMake(_Posts_tableview.center.x-self.view.bounds.size.width, self.view.center.y) ];
                [icarousel setCenter:CGPointMake(self.view.center.x, self.view.center.y)];

            }];
            [self pop_menu_view_remove_animation];
     }
            break;
            
            
        default:
            break;
    }
}
#pragma mark - tableview数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Posts_data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSString *ListViewCellId = @"Posts_activity_cell";
    Posts_activity_cell *cell = [_Posts_tableview dequeueReusableCellWithIdentifier:ListViewCellId];
    if (cell == nil) {
        cell = [[Posts_activity_cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ListViewCellId];
    }
    PostsActivityModel *posts_model = [[PostsActivityModel alloc]init];
    NSDictionary *dic = [self.Posts_data objectAtIndex:row];
    NSNumber *num_posts_id =[dic objectForKey:@"Posts_id"];
    posts_model.Posts_id = num_posts_id.intValue;
    NSNumber *num_posts_type = [dic objectForKey:@"Posts_type"];
    posts_model.Posts_type = num_posts_type.intValue;
    posts_model.User_headphoto = [dic objectForKey:@"User_headphoto"];
    posts_model.User_nickname = [dic objectForKey:@"User_nickname"];
    posts_model.Posts_title = [dic objectForKey:@"Posts_title"];
    posts_model.Posts_content = [dic objectForKey:@"Posts_content"];
    posts_model.Posts_location = [dic objectForKey:@"Posts_location"];
    [cell setUserPhoto:posts_model.User_headphoto];
    [cell setTitle:posts_model.Posts_title];
    [cell setNickName:posts_model.User_nickname];
    [cell setLocation:posts_model.Posts_location];
    UserModel *temp_user = [UserModel sharedUserModel];
    if (!temp_user.User_activity_list.count) {
        cell.btnForJoin.selected = NO;
    }else{
    for (PostsModel *temp_posts_model in temp_user.User_activity_list) {
        if (posts_model.Posts_id == temp_posts_model.Posts_id) {
            cell.btnForJoin.selected = YES;
            break;
        }else{
            cell.btnForJoin.selected = NO;
        }
    }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0f;
}
-(void)Post_posts:(UIBarButtonItem *)sender{
     SelectVc *post_activityVC = [[SelectVc alloc]init];
    [self.navigationController pushViewController:post_activityVC animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CGRect cellFrameInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect cellFrameInSuperview = [tableView convertRect:cellFrameInTableView toView:[tableView superview]];
    DetailActivityVC *detailViewController = [[DetailActivityVC alloc]init];
    NSMutableDictionary* dict = [self.Posts_data objectAtIndex:indexPath.row];
    //
    PostsActivityModel *posts_model = [[PostsActivityModel alloc]init];
    NSNumber *num_posts_id =[dict objectForKey:@"Posts_id"];
    posts_model.Posts_id = num_posts_id.intValue;
    NSNumber *num_posts_type = [dict objectForKey:@"Posts_type"];
    posts_model.Posts_type = num_posts_type.intValue;
    posts_model.User_headphoto = [dict objectForKey:@"User_headphoto"];
    posts_model.User_nickname = [dict objectForKey:@"User_nickname"];
    posts_model.Posts_title = [dict objectForKey:@"Posts_title"];
    posts_model.Posts_content = [dict objectForKey:@"Posts_content"];
    posts_model.Posts_location = [dict objectForKey:@"Posts_location"];
    UserModel *user_model = [UserModel sharedUserModel];
    for (PostsModel *temp_post_model in user_model.User_activity_list) {
        if (posts_model.Posts_id == temp_post_model.Posts_id) {
            detailViewController.isJoin = YES;
            break;
        }else{            detailViewController.isJoin = NO;
        }
    }
    detailViewController.posts_activity_model = posts_model;
    detailViewController.yOrigin = cellFrameInSuperview.origin.y;

    [self.navigationController pushViewController:detailViewController animated:NO];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - iCarousel 数据源

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.Posts_travel_note_data.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UIButton *button = (UIButton *)view;
	if (button == nil)
	{
		//no button available to recycle, so create new one
		UIImage *image = [UIImage imageNamed:@"icarousel_page.png"];
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(0.0f, 0.0f, 200, 200);
		[button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
		[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
    PostsTravelNotesModel *posts_travel_note_model = [[PostsTravelNotesModel alloc]init];
    NSDictionary *dic = [self.Posts_travel_note_data objectAtIndex:index];
    NSNumber *num_posts_id =[dic objectForKey:@"Posts_id"];
    posts_travel_note_model.Posts_id = num_posts_id.intValue;
    NSNumber *num_posts_type = [dic objectForKey:@"Posts_type"];
    posts_travel_note_model.Posts_type = num_posts_type.intValue;
    posts_travel_note_model.User_headphoto = [dic objectForKey:@"User_headphoto"];
    posts_travel_note_model.User_nickname = [dic objectForKey:@"User_nickname"];
    posts_travel_note_model.Posts_title = [dic objectForKey:@"Posts_title"];
    posts_travel_note_model.Posts_content = [dic objectForKey:@"Posts_content"];
    posts_travel_note_model.Posts_travel_notes_city = [dic objectForKey:@"Posts_travel_notes_city"];
    posts_travel_note_model.Posts_travel_notes_image = [dic objectForKey:@"Posts_travel_notes_image"];
    [button setBackgroundImage:[UIImage imageNamed:posts_travel_note_model.Posts_travel_notes_image] forState:UIControlStateNormal];

    return button;
}

- (CGFloat)carousel:(iCarousel *)_carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        default:
        {
            return value;
        }
    }
}
#pragma mark - icarousel代理方法
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    CGFloat  current =   carousel.scrollOffset;
    NSLog(@"%f",current);
    int current_int = (int)current;
    current_icarousel_button_tag = current_int;
    PostsTravelNotesModel *posts_travel_note_model = [[PostsTravelNotesModel alloc]init];
    NSDictionary *dic = [self.Posts_travel_note_data objectAtIndex:current_int];
    NSNumber *num_posts_id =[dic objectForKey:@"Posts_id"];
    posts_travel_note_model.Posts_id = num_posts_id.intValue;
    NSNumber *num_posts_type = [dic objectForKey:@"Posts_type"];
    posts_travel_note_model.Posts_type = num_posts_type.intValue;
    posts_travel_note_model.User_headphoto = [dic objectForKey:@"User_headphoto"];
    posts_travel_note_model.User_nickname = [dic objectForKey:@"User_nickname"];
    posts_travel_note_model.Posts_title = [dic objectForKey:@"Posts_title"];
    posts_travel_note_model.Posts_content = [dic objectForKey:@"Posts_content"];
    posts_travel_note_model.Posts_travel_notes_city = [dic objectForKey:@"Posts_travel_notes_city"];
    posts_travel_note_model.Posts_travel_notes_image = [dic objectForKey:@"Posts_travel_notes_image"];
//    [icarousel setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:posts_travel_note_model.User_headphoto]]];
    icarousel_title.text = posts_travel_note_model.Posts_title;
    icarousel_pageControl.currentPage = current_int;
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%d",index);
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    [_Posts_tableview reloadData];
}
-(NSMutableArray *)loadUserJsonDataForLocation{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                       , NSUserDomainMask
                                                       , YES);
    NSLog(@"Get document path: %@",[paths objectAtIndex:0]);
    NSString *fileName=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"posts_json.json"];

   NSString *str= [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [str JSONValue];
    NSMutableArray *user_arr = [dic objectForKey:@"data"];
    return user_arr;
}
//读取本地的PostsTravelNoteData
-(NSMutableArray *)loadPostsTravelNoteData{
    /*读取外部文件的时候
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                       , NSUserDomainMask
                                                       , YES);
    NSLog(@"Get document path: %@",[paths objectAtIndex:0]);
    NSString *fileName=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"posts_travel_note_data.json"];
    
    NSString *str= [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [str JSONValue];
    NSMutableArray *user_arr = [dic objectForKey:@"data"];
    return user_arr;
   */
    
    
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"posts_travel_note_data" ofType:@"json"];
    NSString *str= [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [str JSONValue];
    NSMutableArray *user_arr = [dic objectForKey:@"data"];
    return user_arr;

    
}
-(void)pop_menu_view_remove_animation{
    CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    [pop_menu_view setAlpha:0.0f];
    [pop_menu_view.layer addAnimation:animation forKey:@"DropDown"];
    [pop_menu_view performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
}
-(void)Click_nav_menu:(id)sender{
    if (pop_menu_view.superview == self.navigationController.view) {
        [self pop_menu_view_remove_animation];
    }else{

     CATransition *animation = [CATransition  animation];
    animation.delegate = self;
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromBottom;
    [pop_menu_view setAlpha:1.0f];
    [pop_menu_view.layer addAnimation:animation forKey:@"DropDown"];
    //[_timePicker performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
     [self.navigationController.view addSubview:pop_menu_view];
    }
}
-(void)buttonTapped:(UIButton *)sender{
    PostsTravelNotesModel *posts_travel_note_model = [[PostsTravelNotesModel alloc]init];
    NSDictionary *dic = [self.Posts_travel_note_data objectAtIndex:current_icarousel_button_tag];
    NSNumber *num_posts_id =[dic objectForKey:@"Posts_id"];
    posts_travel_note_model.Posts_id = num_posts_id.intValue;
    NSNumber *num_posts_type = [dic objectForKey:@"Posts_type"];
    posts_travel_note_model.Posts_type = num_posts_type.intValue;
    posts_travel_note_model.User_headphoto = [dic objectForKey:@"User_headphoto"];
    posts_travel_note_model.User_nickname = [dic objectForKey:@"User_nickname"];
    posts_travel_note_model.Posts_title = [dic objectForKey:@"Posts_title"];
    posts_travel_note_model.Posts_content = [dic objectForKey:@"Posts_content"];
    posts_travel_note_model.Posts_travel_notes_city = [dic objectForKey:@"Posts_travel_notes_city"];
    posts_travel_note_model.Posts_travel_notes_image = [dic objectForKey:@"Posts_travel_notes_image"];
    DetailTravelNoteVC *detail_travel_note_vc = [[DetailTravelNoteVC alloc]init];
    [detail_travel_note_vc setPosts_travel_notes_model:posts_travel_note_model];
    [self.navigationController pushViewController:detail_travel_note_vc animated:YES];

}
@end
