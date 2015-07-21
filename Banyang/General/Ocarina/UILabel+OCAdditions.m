//
//  UILabel+OCAdditions.m
//  Biquu
//
//  Created by Blue on 14-6-9.
//

#import "UILabel+OCAdditions.h"
#import "Ocarina.h"

@implementation UILabel (OCAdditions)

+ (UILabel *)labelWithText:(NSString *)text font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
    label.text = text;
    [label sizeToFit];
    return label;
}

//- (CGSize)sizeWithText:(NSString *)text constrainedToWidth:(BOOL)flag {
//    if (!flag) {
//        return [text sizeWithFont:self.font];
//    } else {
//        CGSize size = CGSizeMake(self.width, MAXFLOAT);
//        return [text sizeWithFont:self.font constrainedToSize:size lineBreakMode:self.lineBreakMode];
//    }
//}

- (void)setText:(NSString *)text followbyViews:(NSArray *)views padding:(CGFloat)padding maxTotalWidth:(CGFloat)maxWidth {
    self.text = text;
    [self widthToFit];
    
    CGFloat followedWidth = 0;
    for (UIView *view in views) {
        followedWidth += padding + view.width;
    }
    
    CGFloat textWidth = self.width;
    maxWidth = maxWidth > 0?maxWidth : MAXFLOAT;
    
    if (textWidth + followedWidth > maxWidth) {
        textWidth = maxWidth - followedWidth;
    }
    
    self.width = textWidth;
    CGFloat xOffset = self.maxX;
    
    for (UIView *view in views) {
        xOffset += padding;
        view.x = xOffset;
        xOffset += view.width;
    }
}

- (void)setPartColerStr:(NSString *)rangeStr withColor:(UIColor *)color{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc]initWithString:self.text];
    NSRange range = [self.text rangeOfString:rangeStr];
    [attri addAttribute:NSForegroundColorAttributeName value:color range:range];
    [self setAttributedText:attri];
}


@end
