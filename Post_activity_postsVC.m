//
//  Post_activity_postsVC.m
//  TestWalker
//
//  Created by TY on 14-3-19.
//  Copyright (c) 2014年 Long. All rights reserved.
//

#import "Post_activity_postsVC.h"
#import "HKKTagWriteView.h"
#import "CMPopTipView.h"
#import "UserModel.h"
#import "SBJson.h"
@interface Post_activity_postsVC ()<UITextViewDelegate,HKKTagWriteViewDelegate>
{
    UITextView *_input_view;
    UIImageView *_img;
    UIView *_footComment;
    HKKTagWriteView *titleInputView;
    HKKTagWriteView *locationInputView;
}
@end

@implementation Post_activity_postsVC

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
    UIBarButtonItem *navLeftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(Post_activity_posts:)];
    self.navigationItem.rightBarButtonItem = navLeftItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"活动贴";
    [self init_nav_right_button];
    _img = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50,100, 100)];
    [_img setCenter:CGPointMake(100, 100+14*2)];
    
    _input_view = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _input_view.returnKeyType = UIReturnKeyDone;
    [_input_view setDelegate:self];
    [self.view addSubview:_input_view];
    //发帖 底部工具条
    _footComment = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-44.0f*2, self.view.bounds.size.width, 44.0f*2)];
    UIImageView *_background_footComment = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44.0f*2)];
    [_background_footComment setImage:[UIImage imageNamed:@"toolbar_bottom_bar.png"]];
    [_background_footComment setAlpha:0.4f];
    [_footComment addSubview:_background_footComment];
    [self.view addSubview:_footComment];
    //title标题信息
    titleInputView = [[HKKTagWriteView alloc]initWithFrame:CGRectMake(11, 0, 280, 37) Andplaceholder:@"写上标题吧"];
    [titleInputView setMaxTagLength:13];
    [titleInputView setDelegate:self];
    [_footComment addSubview:titleInputView];
    //location信息
    locationInputView = [[HKKTagWriteView alloc]initWithFrame:CGRectMake(11, 44, 280, 37) Andplaceholder:@"写上活动地点吧"];
    [locationInputView setMaxTagLength:13];
    [locationInputView setDelegate:self];
    [_footComment addSubview:locationInputView];
    //chat_bottom_up_nor.png
    UIButton *_btn_up = [[UIButton alloc]initWithFrame:CGRectMake(264, 3, 34, 34)];
    [_btn_up setBackgroundImage:[UIImage imageNamed:@"chat_bottom_up_nor.png"] forState:UIControlStateNormal];
    [_footComment addSubview:_btn_up];
   }

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITextView代理
//判断输入如果是回车键则退出键盘,首输入的字符
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        //retrun NO 是不进行回车换行
        return NO;
    }
    return YES;
}
//当文字改变的逻辑
- (void)textViewDidChange:(UITextView *)textView{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:textView.text];
    textView.attributedText = attrStr;
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    CGSize size = [_input_view.text sizeWithAttributes:dic];
    int length = size.height;
    int colomNumber = _input_view.contentSize.height/length;
    NSLog(@"%d",colomNumber);
    CGFloat origion_img_y = _img.center.y;
    if (colomNumber>0) {
        [UIView animateWithDuration:0.8f animations:^{
            [_img setCenter:CGPointMake(100, 100+length*colomNumber)];
        }];
    }  if(colomNumber == 43 && origion_img_y == 100+14*2){
        [_img setCenter:CGPointMake(100, 100+length*2)];
    }
    
}
- (void)viewWillAppear:(BOOL)animated
{
    //创建通知 键盘即将出现和关闭
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    self.tabBarController.tabBar.hidden = YES;

      [super viewWillAppear:YES];
}
#pragma mark  - 键盘即将显示和退出
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
          [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        [_input_view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-rect.size.height-_footComment.frame.size.height)];
        [_footComment setCenter:CGPointMake(rect.size.width/2, self.view.bounds.size.height - rect.size.height-_footComment.frame.size.height/2)];
    }];
}
- (void)keyBoardWillHide:(NSNotification *)note{
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
         [_footComment setFrame:CGRectMake(0, self.view.bounds.size.height-_footComment.frame.size.height, self.view.bounds.size.width, 44.0f*2)];
        [_input_view setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-_footComment.frame.size.height)];
    }];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

/*
-(void)getImg:(id)sender{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择一张图片吧" delegate:self  cancelButtonTitle:@"取消" destructiveButtonTitle:@"立即拍照上传" otherButtonTitles:@"从手机相册选取",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
    //    [actionSheet setDelegate:self];
    [self.view endEditing:YES];
    [actionSheet showInView:self.view];

    
}
#pragma mark - UIActionSheet协议
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex ==0)
    {          UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        [imgPicker setAllowsEditing:YES];
        [imgPicker setDelegate:self];
        [imgPicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imgPicker animated:YES completion:^{}];
        
    }
    if (buttonIndex ==1) {
        UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
        [imgPicker setAllowsEditing:YES];
        [imgPicker setDelegate:self];
        [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imgPicker animated:YES completion:^{}];
        
    }
    else
        return;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    [_img setImage:image];
    [_input_view addSubview:_img];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    return;
}
 */
-(void)Post_activity_posts:(id)sender{
    if (!_post_activity_model) {
        _post_activity_model = [[PostsActivityModel alloc]init];
    }
    NSString *post_temp_id =[self setTimeInt:0 setTimeFormat:@"yyMMddHHmmss" setTimeZome:nil];
    _post_activity_model.Posts_type = 0;
    _post_activity_model.Posts_content = _input_view.text;
    _post_activity_model.Posts_title = titleInputView.text;
    _post_activity_model.Posts_location = locationInputView.text;
    _post_activity_model.Posts_id = post_temp_id.intValue;
    UserModel *current_user = [UserModel sharedUserModel];
    _post_activity_model.User_id = current_user.User_id;
    _post_activity_model.User_nickname = current_user.User_nickname;
    _post_activity_model.User_headphoto = current_user.User_headphoto;
    _post_activity_model.User_activity_list = current_user.User_activity_list;
    NSMutableDictionary *post_dict = [[NSMutableDictionary alloc]init];
    /*
     "User_id": 10,
     "User_nickname": "神来之笔",
     "User_headphoto": "user_10.jpeg",
     "latitude":20,
     "longitude":20,
     "Posts_id":1009,
     "Posts_type":0,
     "Posts_title":"大世界",
     "Posts_content":"是观音桥,大世纪",
     "Posts_location":"观音桥",
     "User_activity_list":
     */
      [post_dict setValue:_post_activity_model.User_nickname forKey:@"User_nickname"];
    [post_dict setValue:_post_activity_model.User_headphoto forKey:@"User_headphoto"];
    [post_dict setValue:[NSNumber numberWithInt:20]  forKey:@"latitude"];
    [post_dict setValue:[NSNumber numberWithInt:20]  forKey:@"longitude"];
    [post_dict setValue:[NSNumber numberWithInt:_post_activity_model.User_id]  forKey:@"User_id"];

    [post_dict setValue:[NSNumber numberWithInt:_post_activity_model.Posts_id]  forKey:@"Posts_id"];
    [post_dict setValue:[NSNumber numberWithInt:_post_activity_model.Posts_type]  forKey:@"Posts_type"];
    [post_dict setValue:_post_activity_model.Posts_title forKey:@"Posts_title"];
    [post_dict setValue:_post_activity_model.Posts_content forKey:@"Posts_content"];
    [post_dict setValue:_post_activity_model.Posts_location forKey:@"Posts_location"];
    [post_dict setValue:@"haha" forKey:@"User_activity_list"];
    
    //获取沙盒Document文件夹路径(项目里的资源没有权限更改,只有在外面读写了 + _+ || )
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                       , NSUserDomainMask
                                                       , YES);
    NSString *fileName=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"posts_json.json"];
    NSString *post_json_str = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:Nil];
    NSDictionary *orgion_dic = [post_json_str JSONValue];
    NSMutableArray *user_arr = [orgion_dic objectForKey:@"data"];
    [user_arr addObject:post_dict];
    NSMutableDictionary *update_json = [[NSMutableDictionary alloc]init];
    /*
     {"errorNum":10000,"errorMsg":"success","data":
     */
    [update_json setValue:[NSNumber numberWithInt:10000] forKey:@"errorNum"];
    [update_json setValue:@"success" forKey:@"errorMsg"];
    [update_json setValue:user_arr forKey:@"data"];
    NSString *update_json_str = [update_json JSONRepresentation];

    NSData *contentData=[update_json_str dataUsingEncoding:NSUTF8StringEncoding];
//    BOOL isok = [contentData writeToFile:fileName atomically:YES];
    [contentData writeToFile:fileName atomically:YES];
}
//时间戳
-(NSString *)setTimeInt:(NSTimeInterval)timeSeconds setTimeFormat:(NSString *)timeFormatStr setTimeZome:(NSString *)timeZoneStr
{
    NSString *date_string;
    NSDate *time_str;
    if( timeSeconds>0){
        time_str =[NSDate dateWithTimeIntervalSince1970:timeSeconds];
    }else{
        time_str=[[NSDate alloc] init];
    }
    if( timeFormatStr==nil){
        date_string =[NSString stringWithFormat:@"%ld",(long)[time_str timeIntervalSince1970]];
    }else{
        NSDateFormatter *date_format_str =[[NSDateFormatter alloc] init];
        [date_format_str setDateFormat:timeFormatStr];
        if( timeZoneStr!=nil){
            [date_format_str setTimeZone:[NSTimeZone timeZoneWithName:timeZoneStr]];
        }
        date_string =[date_format_str stringFromDate:time_str];
    }
    return date_string;
}
- (void)tagWriteViewDidEndEditing:(HKKTagWriteView *)view{
    if (view == titleInputView) {
        [locationInputView.inputView becomeFirstResponder];
    }
    if (view == locationInputView) {
        [locationInputView.inputView resignFirstResponder];
    }
}
@end
