//
//  DetailTravelNoteVC.m
//  Traveller
//
//  Created by TY on 14-3-27.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "DetailTravelNoteVC.h"

@interface DetailTravelNoteVC ()
{   //接收内容容器
    UIWebView *content_view;
}
@end

@implementation DetailTravelNoteVC
@synthesize posts_travel_notes_model;
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
    [self setTitle:posts_travel_notes_model.Posts_title];
    content_view = [[UIWebView alloc]initWithFrame:self.view.frame];
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    //baseURL是基于读取本地资源的位置
    [content_view loadHTMLString:posts_travel_notes_model.Posts_content baseURL:baseURL];
    content_view.scalesPageToFit = YES;
    
    [self.view addSubview:content_view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
