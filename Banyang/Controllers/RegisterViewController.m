//
//  RegisterViewController.m
//  Banyang
//
//  Created by LXJ on 15/1/22.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "RegisterViewController.h"
#import "NSString+OCAdditions.h"
#import <SMS_SDK/SMS_SDK.h>
@interface RegisterViewController ()
{
    NSTimer* _timer;

}

@end
static int count = 0;

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setConFigureUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

- (void)setNav {
    if ([_isPush isEqualToString:@"2"]) {
        self.title = @"忘记密码";
    } else {
        self.title = @"注册";
    }
}

- (void)setConFigureUI {
    if ([_isPush isEqualToString:@"2"]) {
        self.agreementLabel.hidden = YES;
    }
    [self.mobileNumberLabel setPartCornerType1:UIRectCornerTopLeft type2:UIRectCornerBottomLeft];
    [self.mobileNumberTextField setPartCornerType1:UIRectCornerBottomRight type2:UIRectCornerTopRight];
    [self.sendButton setPartCornerType1:UIRectCornerTopLeft type2:UIRectCornerBottomLeft];
    [self.sendMessageTextField setPartCornerType1:UIRectCornerBottomRight type2:UIRectCornerTopRight];
    [self.passportTextfield roundWithCornerRadius:10];
    
    [self.agreementLabel setPartColerStr:@"《榜样用户协议》" withColor:COLOR_RGB(255,0,0)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextDidChange:)
                                                 name:UITextFieldTextDidChangeNotification object:nil];
}

- (IBAction)backButtonClick:(UIButton *)sender {
    if ([_isPush isEqualToString:@"1"] || [_isPush isEqualToString:@"2"]) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}
- (IBAction)nextButtonClick:(UIButton *)sender {
    if (self.sendMessageTextField.text.length != 4) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证码不正确哦" message:@"请重新输入" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [SMS_SDK commitVerifyCode:self.sendMessageTextField.text result:^(enum SMS_ResponseState state) {
            if (1==state) {
                NSLog(@"验证成功");
            } else if(0==state) {
                NSLog(@"验证失败");
            }
        }];

    }
}

#pragma mark TextField Notification
- (void)textFieldTextDidChange:(NSNotification *)notification {
    NSString *str = self.mobileNumberTextField.text;
    NSLog(@"%@",str);
    if ([str isValidMobileNumber]) {
        self.sendButton.enabled = YES;
        self.sendButton.backgroundColor = [UIColor redColor];
    }
}
//获取验证码
- (IBAction)sendButtonClick:(UIButton *)sender {
    [SMS_SDK getVerifyCodeByPhoneNumber:self.mobileNumberTextField.text AndZone:@"86" result:^(enum SMS_GetVerifyCodeResponseState state) {
        
        if (1==state) {
            NSLog(@"block 获取验证码成功");
            [MBProgressHUD showMessag:@"验证码已发送，请注意查收" toView:self.view];
            
            self.sendButton.enabled = NO;
            NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
            _timer = timer;
        }
        else if(0==state)
        {
            NSLog(@"block 获取验证码失败");
            NSString* str=[NSString stringWithFormat:NSLocalizedString(@"codesenderrormsg", nil)];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        else if (SMS_ResponseStateMaxVerifyCode==state)
        {
            NSString* str=[NSString stringWithFormat:NSLocalizedString(@"maxcodemsg", nil)];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"maxcode", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
        else if(SMS_ResponseStateGetVerifyCodeTooOften==state)
        {
            NSString* str=[NSString stringWithFormat:NSLocalizedString(@"codetoooftenmsg", nil)];
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"notice", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"sure", nil) otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
//更新倒计时
- (void)updateTime {
    count++;
    if (count>60) {
        [_timer invalidate];
        return;
    }
    [self.sendButton setTitle:[NSString stringWithFormat:@"%i后重新发送",60-count] forState:UIControlStateNormal];
    LOG_INT(count);
    if (count==60) {
        [self.sendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.sendButton.enabled = YES;
        [_timer invalidate];
        count=0;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
