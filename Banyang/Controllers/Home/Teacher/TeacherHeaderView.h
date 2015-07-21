//
//  TeacherHeaderView.h
//  Banyang
//
//  Created by LXJ on 15/2/4.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBodyModel.h"
#import "CBAutoScrollLabel.h"
@interface TeacherHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *portritButton;
@property (weak, nonatomic) IBOutlet CBAutoScrollLabel *scrollLabel;
@property (weak, nonatomic) IBOutlet UIImageView *loveImageView;
@property (strong,nonatomic)HomeBodyModel *homeBodyModel;
-(void)setUIWithModel:(HomeBodyModel *)model;
@end
