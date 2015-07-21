//
//  MBProgressHUD+Add.h
//  Banyang
//
//  Created by LXJ on 15/1/26.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;

@end
