//
//  PayViewController.m
//  Banyang
//
//  Created by LXJ on 15/2/9.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "PayViewController.h"
#import "QFShareEngine.h"
@interface PayViewController ()

@end

@implementation PayViewController
{
    NSString * productDescription;
    NSString * productName;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"支付宝付款";

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setConfigureUI];
}

- (void)setConfigureUI {
    self.infoLabel.text = [NSString stringWithFormat:@"状元一对一:%@元",self.model.price];
    productDescription = self.infoLabel.text;
    productName = self.infoLabel.text;
    [self.payButton roundWithCornerRadius:5];
}
- (IBAction)payButtonClick:(UIButton *)sender {
    NSMutableDictionary * info = [[NSMutableDictionary alloc] init];
    NSString * totalMoney = @"0.01";
    
    [info setObject:totalMoney forKey:kTotalAmount];//qian
    [info setObject:productDescription forKey:kProductDescription];//产品描述
    [info setObject:productName forKey:kProductName];//产品名称
    
    [QFShareEngine paymentWithInfo:info type:ShareTypeAliPay result:^(ShareType type, ShareStatus status, NSError *error, NSData *data, BOOL end) {
        
        NSLog(@"%d",end);
        //yes成功
        //no
        
        NSLog(@"error is %@", error);
    }];
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
