//
//  ParallaxHeaderView.h
//  Banyang
//
//  Created by LXJ on 15/2/3.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParallaxHeaderView : UIView
@property (nonatomic, strong)UIImage *headerImage;
@property (strong, nonatomic)UIScrollView *imageScrollView;
@property (strong, nonatomic)UIImageView *imageView;
@property (strong, nonatomic)UIImageView *bluredImageView;
@property (strong, nonatomic)UIView *subView;

+ (id)parallaxHeaderViewWithImage:(UIImage *)image forSize:(CGSize)headerSize;
+ (id)parallaxHeaderViewWithSubView:(UIView *)subView;
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;

@end
