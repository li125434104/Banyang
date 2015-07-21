//
//  TeacherBottomView.m
//  Banyang
//
//  Created by LXJ on 15/2/7.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "TeacherBottomView.h"

@implementation TeacherBottomView



-(void)setUIWithModel:(HomeBodyModel *)model {
    self.model = model;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.IMButton roundWithCornerRadius:5];
    [self.payButton roundWithCornerRadius:5];
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元/10分钟",model.price];
}
- (IBAction)IMButtonClick:(UIButton *)sender {
    if (self.IMButtonBlock) {
        self.IMButtonBlock(self.model);
    }
}
- (IBAction)payButtonClick:(UIButton *)sender {
    if (self.payButtonBlock) {
        self.payButtonBlock(self.model);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
