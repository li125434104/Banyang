//
//  UILabel+OCAdditions.h
//  Biquu
//
//  Created by Blue on 14-6-9.
//

#import <UIKit/UIKit.h>

@interface UILabel (OCAdditions)

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font;

//- (CGSize)sizeWithText:(NSString *)text constrainedToWidth:(BOOL)flag;

- (void)setText:(NSString *)text followbyViews:(NSArray *)views padding:(CGFloat)padding maxTotalWidth:(CGFloat)maxWidth;

- (void)setPartColerStr:(NSString *)rangeStr withColor:(UIColor *)color;
@end
