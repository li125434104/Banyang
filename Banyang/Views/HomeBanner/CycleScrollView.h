//
//  CycleScrollView.h
//  Banyang
//
//  Created by LXJ on 15/1/27.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageControl.h"

@interface CycleScrollView : UIView <UIScrollViewDelegate>
{
    CGFloat scrollViewStartContentOffsetX;
}
@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;
@property (nonatomic , strong) MyPageControl *pageControl;



- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration;
@property (nonatomic, copy) NSInteger (^totalPagesCount)(void);
@property (nonatomic, copy) UIView *(^fetchContentViewAtIndex)(NSInteger pageIndex);
@property (nonatomic, copy) void(^tapActionBlock)(NSInteger pageIndex);
@end
