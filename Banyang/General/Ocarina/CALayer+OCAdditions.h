//
//  CALayer+OCAdditions.h
//  Biquu
//
//  Created by Blue on 14-6-9.
//
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>

@interface CALayer (OCAdditions)

- (void)roundWithRadius:(CGFloat)radius;  //mutual exclusive with shadow
- (void)addShadowWithOffset:(CGSize)offset;
- (void)addShadowWithOffset:(CGSize)offset radius:(CGFloat)radius color:(UIColor *)color;

- (UIImage *)renderedImageInRect:(CGRect)rect;
- (UIImage *)renderedImageInPath:(UIBezierPath *)path;

@end
