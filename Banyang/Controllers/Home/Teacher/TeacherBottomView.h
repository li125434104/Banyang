//
//  TeacherBottomView.h
//  Banyang
//
//  Created by LXJ on 15/2/7.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBodyModel.h"
@interface TeacherBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *IMButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;

@property (nonatomic, copy) void(^IMButtonBlock)(HomeBodyModel *model);
@property (nonatomic, copy) void(^payButtonBlock)(HomeBodyModel *model);

@property (strong ,nonatomic)HomeBodyModel *model;
-(void)setUIWithModel:(HomeBodyModel *)model;

@end
