//
//  ParallaxHeaderView.m
//  Banyang
//
//  Created by LXJ on 15/2/3.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "ParallaxHeaderView.h"
#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
//static CGFloat kParallaxDeltaFactor = 0.5f;
//static CGFloat kMaxTitleAlphaOffset = 100.0f;
//static CGFloat kLabelPaddingDist = 8.0f;
@implementation ParallaxHeaderView

+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
{
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, headerSize.width, headerSize.height)];
    headerView.backgroundColor = [UIColor yellowColor];
    headerView.headerImage = image;
    [headerView initialSetupForDefaultHeader];
    return headerView;
    
}

+ (id)parallaxHeaderViewWithSubView:(UIView *)subView
{
    ParallaxHeaderView *headerView = [[ParallaxHeaderView alloc] initWithFrame:CGRectMake(0, 0, subView.frame.size.width, subView.frame.size.height)];
    [headerView initialSetupForCustomSubView:subView];

    return headerView;
}

- (void)initialSetupForDefaultHeader
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.imageScrollView = scrollView;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:scrollView.bounds];
    imageView.backgroundColor = [UIColor redColor];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = self.headerImage;
    self.imageView = imageView;
    [self.imageScrollView addSubview:imageView];
    [self addSubview:self.imageScrollView];
}

- (void)initialSetupForCustomSubView:(UIView *)subView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.imageScrollView = scrollView;
    self.subView = subView;
    subView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.imageScrollView addSubview:subView];
    
    [self addSubview:self.imageScrollView];
}


- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset
{
//    CGRect frame = self.imageScrollView.frame;
    
    if (offset.y > 0)
    {
        //        frame.origin.y = MAX(offset.y *kParallaxDeltaFactor, 0);
        //        self.imageScrollView.frame = frame;
        //        self.bluredImageView.alpha =   1 / kDefaultHeaderFrame.size.height * offset.y * 2;
        //        self.clipsToBounds = YES;
    }
    else
    {
        CGFloat delta = 0.0f;
        CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        delta = fabs(MIN(0.0f, offset.y));
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.imageScrollView.frame = rect;
        self.clipsToBounds = NO;
    }
}

@end
