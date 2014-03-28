//
//  DetailActivityVC.m
//  Traveller
//
//  Created by Ronaldinho on 14-3-23.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "DetailActivityVC.h"
#import "PostsActivityModel.h"
#import "UserModel.h"
#import "CMPopTipView.h"
@interface DetailActivityVC ()<CMPopTipViewDelegate>{
    CMPopTipView *popview;
}

@end

@implementation DetailActivityVC
@synthesize posts_activity_model;
@synthesize yOrigin;
@synthesize isJoin;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
       self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
//初始化设置控件
-(void)initComment{
    self.labelForTitle = [[UILabel alloc]init];
    self.labelForLocation = [[UILabel alloc]init];
    self.labelForNickname = [[UILabel alloc]init];
    self.User_headPhoto = [[UIImageView alloc]init];
    self.btnForJoin = [[UIButton alloc]init];
    self.doneBtn = [[UIButton alloc]init];
    self.textviewForDetail = [[UITextView alloc]init];
    self.backgroundImageView = [[UIImageView alloc]init];
    [self.backgroundImageView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
    [self.backgroundImageView setBackgroundColor:[UIColor lightGrayColor]];
    [self.doneBtn setFrame:CGRectMake(10, 20, 73, 44)];
    [self.User_headPhoto setFrame:CGRectMake(110, 50, 100, 100)];
    [self.labelForTitle setFrame:CGRectMake(35, 180, 180, 50)];
    self.labelForTitle.font = [UIFont systemFontOfSize:20.0f];
    self.labelForTitle.numberOfLines = 1;
    self.labelForTitle.adjustsFontSizeToFitWidth = YES;
    self.labelForTitle.textColor = [UIColor blackColor];
    self.labelForTitle.textAlignment = NSTextAlignmentCenter;
    [self.labelForLocation setFrame:CGRectMake(35, 250, 180, 30)];
    self.labelForLocation.font = [UIFont systemFontOfSize:15.0f];
    self.labelForLocation.numberOfLines = 1;
    self.labelForLocation.adjustsFontSizeToFitWidth = YES;
    self.labelForLocation.textColor = [UIColor blackColor];
    self.labelForLocation.textAlignment = NSTextAlignmentCenter;
    self.labelForNickname.font = [UIFont italicSystemFontOfSize:10.0f];
    self.labelForNickname.adjustsFontSizeToFitWidth = YES;
    self.labelForNickname.textColor = [UIColor blackColor];
    self.labelForNickname.textAlignment = NSTextAlignmentCenter;

    [self.textviewForDetail setFrame:CGRectMake(0, 298, self.view.bounds.size.width, 270)];
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.labelForTitle];
    [self.view addSubview:self.labelForLocation];
    [self.view addSubview:self.labelForNickname];
    [self.view addSubview:self.User_headPhoto];
    [self.view addSubview:self.btnForJoin];
    [self.view addSubview:self.doneBtn];
    [self.view addSubview:self.textviewForDetail];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initComment];
     //设置信息
    self.labelForTitle.text = posts_activity_model.Posts_title;
    self.labelForLocation.text = posts_activity_model.Posts_location;
    self.labelForNickname.text = posts_activity_model.User_nickname;
    [self.User_headPhoto setImage:[UIImage imageNamed:posts_activity_model.User_headphoto]];
    [self.btnForJoin setBackgroundImage:[UIImage imageNamed:@"bookmark_no"] forState:UIControlStateNormal];
    [self.btnForJoin setBackgroundImage:[UIImage imageNamed:@"bookmark_yes"] forState:UIControlStateSelected];
    if (isJoin) {
        self.btnForJoin.selected = YES;
    }
    [self.btnForJoin addTarget:self action:@selector(Click_to_join:) forControlEvents:UIControlEventTouchUpInside];
    [self.doneBtn addTarget:self action:@selector(doneBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.doneBtn setTitle:@"DONE" forState:UIControlStateNormal];
    self.doneBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.doneBtn.titleLabel.textColor = [UIColor grayColor];
    self.textviewForDetail.text = posts_activity_model.Posts_content;
    self.textviewForDetail.editable = NO;
    self.textviewForDetail.font = [UIFont italicSystemFontOfSize:15.0f];
    [self animateOnEntry];
 
}
//动态进入逻辑
- (void)animateOnEntry
{
    //初始化控件位置
    self.backgroundImageView.alpha = 0;
    self.backgroundImageView.frame = CGRectMake(0, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.view.frame.size.width, self.labelForTitle.frame.size.height + self.labelForLocation.frame.size.height);
    self.labelForTitle.frame = CGRectMake(70, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.labelForTitle.frame.size.width, self.labelForTitle.frame.size.height);
    self.labelForLocation.frame = CGRectMake(70, self.labelForTitle.frame.origin.y + self.labelForTitle.frame.size.height, self.labelForLocation.frame.size.width, self.labelForLocation.frame.size.height);
    [self.btnForJoin setFrame:CGRectMake(258, self.labelForTitle.frame.origin.y+self.labelForTitle.frame.size.height, 30, 30)];
    self.User_headPhoto.frame = CGRectMake(10, self.yOrigin + IMAGEVIEW_Y_ORIGIN, 50, 50);
    self.doneBtn.frame = CGRectMake(self.doneBtn.frame.origin.x, 0-self.doneBtn.frame.size.height-20, self.doneBtn.frame.size.width, self.doneBtn.frame.size.height);
    [self.labelForNickname setFrame:CGRectMake(258, self.labelForTitle.frame.origin.y, 58, 30)];
    self.textviewForDetail.alpha = 0;
    self.textviewForDetail.frame = CGRectMake(self.textviewForDetail.frame.origin.x, self.textviewForDetail.frame.size.height + self.view.frame.size.height, self.textviewForDetail.frame.size.width, self.textviewForDetail.frame.size.height);
    //应用动画进入界面
    [UIView animateWithDuration:0.4f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void)
     {
         self.User_headPhoto.frame = CGRectMake(110, 50, self.User_headPhoto.frame.size.width * 2, self.User_headPhoto.frame.size.height * 2);

         self.labelForTitle.frame = CGRectMake(75, 180, self.labelForTitle.frame.size.width, self.labelForTitle.frame.size.height);
         self.labelForLocation.frame = CGRectMake(75, 250, self.labelForLocation.frame.size.width, self.labelForLocation.frame.size.height);
         [self.labelForNickname setFrame:CGRectMake(self.User_headPhoto.frame.origin.x+20, self.User_headPhoto.frame.origin.y-30, 58, 30)];
         [self.btnForJoin setFrame:CGRectMake(30, self.labelForTitle.frame.origin.y+10, 30, 30)];

         self.doneBtn.frame = CGRectMake(self.doneBtn.frame.origin.x, 20, self.doneBtn.frame.size.width, self.doneBtn.frame.size.height);
         self.backgroundImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
         self.backgroundImageView.alpha = 1;
         self.textviewForDetail.frame = CGRectMake(self.textviewForDetail.frame.origin.x, self.view.frame.size.height - self.textviewForDetail.frame.size.height, self.textviewForDetail.frame.size.width, self.textviewForDetail.frame.size.height);
         self.textviewForDetail.alpha = 1;
         NSLog(@"width %f height %f",self.User_headPhoto.frame.size.width,self.User_headPhoto.frame.size.height);
         if (!isJoin) {
             popview = [[CMPopTipView alloc]initWithMessage:@"点击加入吧"];
             [popview presentPointingAtView:self.btnForJoin inView:self.view animated:YES];
             [popview setDelegate:self];
             [popview autoDismissAnimated:YES atTimeInterval:2.0];
             popview.backgroundColor = [UIColor darkGrayColor];
             popview.textColor = [UIColor whiteColor];
         }
     }
                     completion:NULL];

}
//退出逻辑
- (void)doneBtnPressed:(id)sender
{
    //animation on EXIT FROM CURRENT VIEW
    [UIView animateWithDuration:0.4f animations:^
     {
         self.backgroundImageView.frame = CGRectMake(0, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.view.frame.size.width, self.labelForTitle.frame.size.height + self.labelForLocation.frame.size.height);
         self.labelForTitle.frame = CGRectMake(70, self.yOrigin + MAIN_LABEL_Y_ORIGIN, self.labelForTitle.frame.size.width, self.labelForTitle.frame.size.height);
         self.labelForLocation.frame = CGRectMake(70, self.labelForTitle.frame.origin.y + self.labelForTitle.frame.size.height, self.labelForLocation.frame.size.width, self.labelForLocation.frame.size.height);
         [self.labelForNickname setFrame:CGRectMake(258, self.labelForTitle.frame.origin.y, 58, 30)];
         self.User_headPhoto.frame = CGRectMake(10, self.yOrigin + IMAGEVIEW_Y_ORIGIN, CGRectGetWidth(self.User_headPhoto.frame) / 2, CGRectGetHeight(self.User_headPhoto.frame) / 2);
         [self.btnForJoin setFrame:CGRectMake(258, self.labelForTitle.frame.origin.y+self.labelForTitle.frame.size.height, 30, 30)];
         self.doneBtn.frame = CGRectMake(self.doneBtn.frame.origin.x, 0-self.doneBtn.frame.size.height-20, self.doneBtn.frame.size.width, self.doneBtn.frame.size.height);
         self.textviewForDetail.frame = CGRectMake(self.textviewForDetail.frame.origin.x, self.textviewForDetail.frame.size.height + self.view.frame.size.height, self.textviewForDetail.frame.size.width, self.textviewForDetail.frame.size.height);
         self.textviewForDetail.alpha = 0;
         self.backgroundImageView.alpha = 0;
         
     }
                     completion:^(BOOL finished)
     {
         [self.navigationController popViewControllerAnimated:NO];
     }
     ];
}
//加入的逻辑
-(void)Click_to_join:(UIButton *)sender{
    if (sender.selected) {
        sender.selected = NO;
        UserModel *user = [UserModel sharedUserModel];
        for (PostsActivityModel *temp_post_activity_model in user.User_activity_list) {
            if (posts_activity_model.Posts_id == temp_post_activity_model.Posts_id) {
                [user.User_activity_list removeObject:temp_post_activity_model];
                break;
            }
        }
    }else{        UserModel *user = [UserModel sharedUserModel];
        [user.User_activity_list addObject:posts_activity_model];
        sender.selected = YES;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}
//cmpopview代理方法
- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView{
    popview = nil;
}

@end
