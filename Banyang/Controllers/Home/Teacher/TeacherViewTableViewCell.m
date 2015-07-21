//
//  TeacherViewTableViewCell.m
//  Banyang
//
//  Created by LXJ on 15/2/5.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "TeacherViewTableViewCell.h"
#import "learnexpModel.h"
#import "scoresModel.h"
#import "ShapeView.h"
static CFTimeInterval const kDuration = 2.0;

@implementation TeacherViewTableViewCell

- (void)awakeFromNib {
    [self setConfigureUI];
}

- (void)setConfigureUI {
    [self.cycleView roundToCircle];
   

}

- (void)showLinesAnimationBegin
{
    //添加path的UIView
    ShapeView  *pathShapeView = [[ShapeView alloc] init];
    pathShapeView.backgroundColor = [UIColor clearColor];
    pathShapeView.opaque = NO;
    pathShapeView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:pathShapeView];
    
    //设置线条的颜色
    UIColor *pathColor = nil;
   
    pathColor = [UIColor blueColor];
    
    pathShapeView.shapeLayer.fillColor = nil;
    pathShapeView.shapeLayer.strokeColor = pathColor.CGColor;
    
    //创建动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.delegate = self;
    animation.duration = kDuration;
    [pathShapeView.shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [self updatePathsWithPathShapeView:pathShapeView];
}

- (void)updatePathsWithPathShapeView:(ShapeView *)pathShapeView
{
    if ([self.pointArray count] >= 2) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        [path moveToPoint:[[self.pointArray firstObject] CGPointValue]];
        
        //设置路径的颜色和动画
        //CGPoint point = [[self.curPoints firstObject] CGPointValue];
        //[path appendPath:[UIBezierPath bezierPathWithArcCenter:point radius:kPointDiameter / 2.0 startAngle:0.0 endAngle:2 * M_PI clockwise:YES]];
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, [self.pointArray count] - 1)];
        [self.pointArray enumerateObjectsAtIndexes:indexSet
                                          options:0
                                       usingBlock:^(NSValue *pointValue, NSUInteger idx, BOOL *stop) {
                                           [path addLineToPoint:[pointValue CGPointValue]];
                                           //[path appendPath:[UIBezierPath bezierPathWithArcCenter:[pointValue CGPointValue] radius:kPointDiameter / 2.0 startAngle:0.0 endAngle:2 * M_PI clockwise:YES]];
                                           
                                       }];
        path.usesEvenOddFillRule = YES;
        pathShapeView.shapeLayer.path = path.CGPath;
    }
    else {
        pathShapeView.shapeLayer.path = nil;
    }
}



- (void)layoutSubviews {
    
}

- (void)setLabelText:(NSInteger)indexNum withArray:(NSArray *)array{
    if (indexNum==0) {
        for (int i = 0 ; i < array.count; i++) {
            if (i==0) {
                _str =[NSString stringWithFormat:@"%@~%@:%@",((learnexpModel*)array[i]).begin,((learnexpModel*)array[i]).end,((learnexpModel*)array[i]).exp];
            } else {
                _str = [NSString stringWithFormat:@"%@\n%@~%@:%@",_str,((learnexpModel*)array[i]).begin,((learnexpModel*)array[i]).end,((learnexpModel*)array[i]).exp];
            }
        }
    } else if (indexNum==1) {
        for (int i = 0 ; i < array.count; i++) {
            if (i==0) {
                _str =[NSString stringWithFormat:@"%@,%@:%@",((scoresModel*)array[i]).time,((scoresModel*)array[i]).exam,((scoresModel*)array[i]).grade];
            } else {
                _str = [NSString stringWithFormat:@"%@\n%@~%@:%@",_str,((scoresModel*)array[i]).time,((scoresModel*)array[i]).exam,((scoresModel*)array[i]).grade];
            }
        }
    }
    self.infoLabel.text = _str;
}

+ (CGFloat)tableViewForHeight:(NSInteger)indexNum withArray:(NSArray *)array {
    NSString *strH;
    if (indexNum==0) {
        for (int i = 0 ; i < array.count; i++) {
            if (i==0) {
                strH =[NSString stringWithFormat:@"%@~%@:%@",((learnexpModel*)array[i]).begin,((learnexpModel*)array[i]).end,((learnexpModel*)array[i]).exp];
            } else {
                strH = [NSString stringWithFormat:@"%@\n%@~%@:%@",strH,((learnexpModel*)array[i]).begin,((learnexpModel*)array[i]).end,((learnexpModel*)array[i]).exp];
            }
        }
    } else if (indexNum==1) {
        for (int i = 0 ; i < array.count; i++) {
            if (i==0) {
                strH =[NSString stringWithFormat:@"%@,%@:%@",((scoresModel*)array[i]).time,((scoresModel*)array[i]).exam,((scoresModel*)array[i]).grade];
            } else {
                strH = [NSString stringWithFormat:@"%@\n%@~%@:%@",strH,((scoresModel*)array[i]).time,((scoresModel*)array[i]).exam,((scoresModel*)array[i]).grade];
            }
        }
    }
    CGRect frame = [strH boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-128,0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    return frame.size.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)drawRect:(CGRect)rect {
    self.pointArray = [NSMutableArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(74, 0)],[NSValue valueWithCGPoint:CGPointMake(74, self.frame.size.height)], nil];
    [self showLinesAnimationBegin];//显示线条动画
}

@end
