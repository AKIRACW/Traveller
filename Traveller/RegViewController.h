//
//  RegViewController.h
//  Traveller
//
//  Created by TY on 14-3-24.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtUserNmae;
@property (weak, nonatomic) IBOutlet UITextField *txtPass;
@property (weak, nonatomic) IBOutlet UIButton *btnReg;
- (IBAction)touchReg:(id)sender;

@end
