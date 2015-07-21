//
//  PayViewController.h
//  Banyang
//
//  Created by LXJ on 15/2/9.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeBodyModel.h"
@interface PayViewController : BaseViewController
@property (nonatomic,strong)HomeBodyModel *model;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
@end
