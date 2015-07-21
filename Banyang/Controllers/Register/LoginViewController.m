//
//  LoginViewController.m
//  Banyang
//
//  Created by LXJ on 15/1/25.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setConfigureUI];
}

- (IBAction)backButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setConfigureUI {
    [self.logoImageView roundToCircle];
    [self.mobileNumberTextField roundWithCornerRadius:10];
    [self.passportTextField roundWithCornerRadius:10];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"pushToRegister"]) {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"1" forKey:@"isPush"];
    }
    if ([segue.identifier isEqualToString:@"forgetPassport"]) {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"2" forKey:@"isPush"];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
