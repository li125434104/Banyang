//
//  CALayer+OCAdditions.m
//  Biquu
//
//  Created by Blue on 14-6-9.
//
//

#import "CALayer+OCAdditions.h"
#import "Ocarina.h"

@implementation CALayer (OCAdditions)


- (void)addBasicAnimationWithKeyPath:(NSString *)keyPath toValue:(id)toValue duration:(CGFloat)duration delegate:(id)delegate {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = [self valueForKeyPath:keyPath];
    animation.toValue = toValue;
    animation.duration = duration;
    animation.delegate = delegate;
    
    [self setValue:toValue forKeyPath:keyPath];
    [self addAnimation:animation forKey:nil];
}

- (void)addBoundingAnimationWithScales:(CGFloat *)scales duration:(CGFloat)duration delegate:(id)delegate {
    if (scales) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        animation.duration = duration;
        animation.delegate = delegate;
        
        NSMutableArray *values = [NSMutableArray array];
        for (; *scales >= 0; ++scales) {
            [values addObject:_CAT2V(CATransform3DMakeScale(*scales, *scales, 1))];
        }
        
        animation.values = values;
        [self addAnimation:animation forKey:nil];
    }
}

- (void)addRotatingAnimationWithClockwise:(BOOL)clockwise duration:(CGFloat)duration repeatCount:(CGFloat)repeatCount delegate:(id)delegate {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = duration;
    animation.repeatCount = repeatCount;
    animation.delegate = delegate;
    
    NSMutableArray *value = [NSMutableArray array];
    for (int degress = 0; degress <= 360; degress += 90) {
        int newDegress = degress;
        if (!clockwise)
            newDegress = 360 - degress;
        
        [value addObject:@((_D2R(newDegress)))];
    }
    
    animation.values = value;
    [self addAnimation:animation forKey:nil];
}

- (void)addRandomShakingAnimationWithMinDegree:(int)min maxDegree:(int)max repeatCount:(float)count {
    int degress = rand() % (max - min) + min;
    if (rand() % 2)
        degress = -degress;
    
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    shakeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    shakeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(_D2R(degress), 0, 0, 1)];
    shakeAnimation.duration = 0.07;
    shakeAnimation.repeatCount = count;
    shakeAnimation.autoreverses = YES;
    
    [self addAnimation:shakeAnimation forKey:nil];
}


- (void)addShadowWithOffset:(CGSize)offset {
    CGFloat radius = MAX(offset.width, offset.height);
    [self addShadowWithOffset:offset radius:radius color:nil];
}

- (void)addShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color {
    if (color) self.shadowColor = color.CGColor;
    self.shadowOffset = offset;
    self.shadowRadius = radius;
    self.shadowOpacity = 1;  //default is 0
    self.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

- (void)roundWithRadius:(CGFloat)radius {
    self.cornerRadius = radius;
    self.masksToBounds = YES;
}


- (UIImage *)renderedImageInRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
     
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
    //UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    //return [self renderedImageInPath:path];
}

- (UIImage *)renderedImageInPath:(UIBezierPath *)path {
    CGRect rect = path.bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    [path addClip];
    
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
