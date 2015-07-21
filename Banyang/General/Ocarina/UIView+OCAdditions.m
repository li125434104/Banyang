//
//  UIView+OCAdditions.m
//  Biquu
//
//  Created by Blue on 14-6-9.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+OCAdditions.h"
#import "CALayer+OCAdditions.h"
#import "OCDrawView.h"
#import "OCTypes.h"


void recursiveEnumerateAllSubviewsForView(UIView *view, OCViewBlock block) {
    for (UIView *sv in view.subviews) {
        block(sv);
        recursiveEnumerateAllSubviewsForView(sv, block);
    }
}


@implementation UIView (OCAdditions)


+ (UIView *)roundsShadowViewWithImage:(UIImage *)image
                               radius:(CGFloat)radius
                         shadowOffset:(CGSize)offset {
    CGFloat blur = MAX(offset.width, offset.height) * 2;
    return [self roundsShadowViewWithImage:image radius:radius shadowOffset:offset shadowBlur:blur shadowColor:[UIColor blackColor]];
}

+ (UIView *)roundsShadowViewWithImage:(UIImage *)image
                               radius:(CGFloat)radius
                         shadowOffset:(CGSize)offset
                           shadowBlur:(CGFloat)blur
                          shadowColor:(UIColor *)color {
    CGRect frame = (CGRect){CGPointZero, image.size};
    CGSize paddingSize = CGSizeMake(offset.width + blur, offset.height + blur);
    
    frame.size.width += fabsf(paddingSize.width);
    frame.size.height += fabsf(paddingSize.height);
    
    OCDrawView *view = [[OCDrawView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    
    view.drawBlock = ^(CGContextRef context, CGRect rect) {
        CGPoint imageOffset = CGPointMake((frame.size.width - image.size.width) / 2,
                                          (frame.size.height - image.size.height) / 2);
        imageOffset.x -= paddingSize.width / 2;
        imageOffset.y -= paddingSize.height / 2;
        
        CGRect clipRect = (CGRect){imageOffset, image.size};
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:clipRect cornerRadius:radius];
        
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, offset, blur, color.CGColor);
        
        [color setFill];
        [path fill];
        
        CGContextRestoreGState(context);
        
        [path addClip];
        [image drawAtPoint:imageOffset];
    };
    return view;
}

+ (UIView *)tiledViewWithImage:(UIImage *)image {
    OCDrawView *view = [[OCDrawView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    view.drawBlock = ^(CGContextRef context, CGRect rect) {
        [image drawAsPatternInRect:rect];
    };
    return view;
}

+ (UIView *)stretchableViewWithImage:(UIImage *)image {
    return [self stretchableViewWithImage:image centerRect:CGRectMake(0, 0, 1, 1)];
}

+ (UIView *)stretchableViewWithImage:(UIImage *)image centerRect:(CGRect)rect {
    UIView *view = [[UIView alloc] init];
    [view fillContentsWithStretchableImage:image centerRect:rect];
    return view;
}

- (void)alignHorizontalCenterForSubviews:(NSArray *)subviews padding:(CGFloat)padding {
    if (subviews.count) {
        CGFloat totalWidth = padding * (subviews.count - 1);
        for (UIView *v in subviews)
            totalWidth += v.width;
        
        CGFloat x = (self.width - totalWidth) / 2;
        for (UIView *v in subviews) {
            v.x = x;
            x += v.width + padding;
        }
    }
}

- (void)alignSubviewsHorizontalCenterWithPadding:(CGFloat)padding {
    if (self.subviews.count) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (UIView *sv in self.subviews) {
            if (!CGRectEqualToRect(sv.frame, self.bounds)) {
                [array addObject:sv];
            }
        }
        
        if (array.count) {
            [array sortUsingComparator:^NSComparisonResult(UIView *obj1, UIView *obj2) {
                if (obj1.x < obj2.x)
                    return NSOrderedAscending;
                else if (obj1.x > obj2.x)
                    return NSOrderedDescending;
                else
                    return NSOrderedSame;
            }];
            
            [self alignHorizontalCenterForSubviews:array padding:padding];
        }
    }
}

- (UITapGestureRecognizer *)addTapGestureWithTarget:(id)target action:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:action];
    [self addGestureRecognizer:tap];
    return tap;
}


- (void)fillContentsWithStretchableImage:(UIImage *)image centerRect:(CGRect)rect {
    self.layer.contents = (id)image.CGImage;
    self.layer.contentsScale = image.scale;
    self.layer.contentsCenter = rect;
    self.backgroundColor = [UIColor clearColor];
}

- (UIImage *)renderedImage {
    return [self renderedImageInRect:self.bounds];
}

- (UIImage *)renderedImageInRect:(CGRect)rect {
    return [self.layer renderedImageInRect:rect];
}

- (UIImage *)renderedImageInPath:(UIBezierPath *)path {
    return [self.layer renderedImageInPath:path];
}

- (void)roundWithCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)roundToCircle {
    [self roundWithCornerRadius:self.height / 2];
}

- (UIView *)deepCopy {
    NSData *viewData = [NSKeyedArchiver archivedDataWithRootObject:self];
    return [NSKeyedUnarchiver unarchiveObjectWithData:viewData];
}


- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)xx {
    CGRect rect = self.frame;
    rect.origin.x = xx;
    self.frame = rect;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)yy {
    CGRect rect = self.frame;
    rect.origin.y = yy;
    self.frame = rect;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)w {
    CGRect rect = self.frame;
    rect.size.width = w;
    self.frame = rect;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)h {
    CGRect rect = self.frame;
    rect.size.height = h;
    self.frame = rect;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)o {
    CGRect rect = self.frame;
    rect.origin = o;
    self.frame = rect;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)s {
    CGRect rect = self.frame;
    rect.size = s;
    self.frame = rect;
}

- (CGSize)boundsSize {
    return self.bounds.size;
}

- (void)setBoundsSize:(CGSize)boundsSize {
    CGRect rect = self.bounds;
    rect.size = boundsSize;
    self.bounds = rect;
}

- (CGFloat)boundsWidth {
    return self.bounds.size.width;
}

- (void)setBoundsWidth:(CGFloat)boundsWidth {
    CGRect rect = self.bounds;
    rect.size.width = boundsWidth;
    self.bounds = rect;
}

- (CGFloat)boundsHeight {
    return self.bounds.size.height;
}

- (void)setBoundsHeight:(CGFloat)boundsHeight {
    CGRect rect = self.bounds;
    rect.size.height = boundsHeight;
    self.bounds = rect;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)x {
    self.center = CGPointMake(x, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)y {
    self.center = CGPointMake(self.center.x, y);
}

- (CGPoint)middlePoint {
    CGRect rect = self.bounds;
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}

- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}


- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX {
    self.x = maxX - self.width;
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY {
    self.y = maxY - self.height;
}


- (void)widthToFit {
    [self widthToFitWithPadding:0 minWidth:0];
}

- (void)widthToFitWithPadding:(CGFloat)padding minWidth:(CGFloat)minWidth {
    CGFloat height = self.height;
    [self sizeToFit];
    self.size = CGSizeMake(MAX(self.width + padding * 2, minWidth), height);
}

- (void)heightToFit {
    [self heightToFitWithPadding:0 minHeight:0];
}

- (void)heightToFitWithPadding:(CGFloat)padding minHeight:(CGFloat)minHeight {
    CGFloat width = self.width;
    [self sizeToFit];
    self.size = CGSizeMake(width, MAX(self.height + padding * 2, minHeight));
}


- (void)recursiveEnumerateAllSubviews:(OCViewBlock)block {
    recursiveEnumerateAllSubviewsForView(self, block);
}


- (void)allSubviewsHidden:(BOOL)hidden {
    for (UIView *sv in self.subviews)
        sv.hidden = hidden;
}

- (void)removeAllSubviews {
    BOOL isScrollView  = [self isKindOfClass:[UIScrollView class]];
    
    for (UIView *sv in self.subviews) {
        if (isScrollView &&
            [sv isKindOfClass:[UIImageView class]] &&
            CGSizeEqualToSize(sv.size, CGSizeMake(7, 7))) //ScrollIndicator
            continue;
        
        [sv removeFromSuperview];
    }
}

- (void)removeAllSubviewsWithClass:(Class)class {
    for (UIView *sv in self.subviews) {
        if ([sv isKindOfClass:class])
            [sv removeFromSuperview];
    }
}

- (UIView *)viewWithClass:(Class)c {
    for (UIView *sv in self.subviews) {
        if ([sv isKindOfClass:c])
            return sv;
    }
    return nil;
}


- (void)startDissolveTransition:(CGFloat)duration {
    [UIView transitionWithView:self duration:duration options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:nil];
}

//设置部分圆角
- (void)setPartCornerType1:(NSInteger)type1 type2:(NSInteger)type2{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:type1 | type2 cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}



@end
