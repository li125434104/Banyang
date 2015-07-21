//
//  RegisterViewController.h
//  Banyang
//
//  Created by LXJ on 15/1/22.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *mobileNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *sendMessageTextField;
@property (weak, nonatomic) IBOutlet UITextField *passportTextfield;
@property (weak, nonatomic) IBOutlet UILabel *agreementLabel;
@property (strong, nonatomic) NSString *isPush;
@end
