//
//  HomeCollectionHeaderView.h
//  Banyang
//
//  Created by LXJ on 15/1/29.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycleScrollView.h"
@interface HomeCollectionHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIView *firstView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIView *thirdView;
@property (weak, nonatomic) IBOutlet UIView *forthView;
@property (weak, nonatomic) IBOutlet CycleScrollView *bannerScrollView;

@end
