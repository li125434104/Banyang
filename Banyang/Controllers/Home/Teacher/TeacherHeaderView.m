//
//  TeacherHeaderView.m
//  Banyang
//
//  Created by LXJ on 15/2/4.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "TeacherHeaderView.h"
#import "UIButton+WebCache.h"
#import "portrait.h"
@implementation TeacherHeaderView

//- (id)initWithFrame:(CGRect)frame {
//    self = [super init];
//    if (self) {
//        [self initsize];
//    }
//    return self;
//}

//- (id)initWithCoder:(NSCoder *)aDecoder {
//    self = [super init];
//    if (self) {
//        [self initsize];
//    }
//    return self;
//}

-(void)setUIWithModel:(HomeBodyModel *)model {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.portritButton roundToCircle];
    [self.portritButton sd_setBackgroundImageWithURL:[NSURL URLWithString:((portrait *)model.portrait).thumbnail] forState:UIControlStateNormal];
    
    self.scrollLabel.text = [NSString stringWithFormat:@"%@ %@ %@ %@",model.characteristic,model.province,model.school,model.teachexp];
    //self.scrollLabel.text = @"This text may be clipped, but now it will be scrolled. This text will be scrolled even after device rotation.";
    self.scrollLabel.textColor = [UIColor whiteColor];
    self.scrollLabel.labelSpacing = 30; // distance between start and end labels
    self.scrollLabel.pauseInterval = 1.7; // seconds of pause before scrolling starts again
    self.scrollLabel.scrollSpeed = 30; // pixels per second
    self.scrollLabel.textAlignment = NSTextAlignmentLeft; // centers text when no auto-scrolling is applied
    self.scrollLabel.fadeLength = 12.f;
    self.scrollLabel.font = [UIFont systemFontOfSize:13];
    self.scrollLabel.scrollDirection = CBAutoScrollDirectionLeft;
    [self.scrollLabel observeApplicationNotifications];

    self.loveImageView = [self rotate360DegreeWithImageView:self.loveImageView];
}

- (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView {
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         CATransform3DMakeRotation(M_PI/2, 0.0, 1.0, 0.0) ];
    animation.duration = 1.5;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    animation.removedOnCompletion = YES;
    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [imageView.image drawInRect:imageRrect];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [imageView.layer addAnimation:animation forKey:nil ];
    return imageView;
}
@end
