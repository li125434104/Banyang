//
//  TagList.h
//  Banyang
//
//  Created by LXJ on 15/2/1.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagList : UIView
{
    UIView      *view;
    NSArray     *textArray;
    CGSize      sizeFit;
    UIColor     *lblBackgroundColor;
}
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) NSArray *textArray;
- (void)setLabelBackgroundColor:(UIColor *)color;
- (void)setTags:(NSArray *)array;
- (void)display;
- (CGSize)fittedSize;
@end
