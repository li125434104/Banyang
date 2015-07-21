//
//  LoginViewController.h
//  Banyang
//
//  Created by LXJ on 15/1/25.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *passportTextField;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassportButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end
