//
//  MineViewController.m
//  Banyang
//
//  Created by LXJ on 15/1/21.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout =  UIRectEdgeNone;
    [self setConfigureUI];
    
}

- (void)setConfigureUI {
    self.registerButton.layer.cornerRadius = 10;
    self.checkinButton.layer.cornerRadius = 10;
}
- (IBAction)registerButtonClick:(UIButton *)sender {
    NSLog(@"register");
    
}
- (IBAction)checkinButtonClick:(UIButton *)sender {
    NSLog(@"checkin");
    
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
