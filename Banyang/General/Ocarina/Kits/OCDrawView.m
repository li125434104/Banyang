//
//  OCControlView.m
//  Biquu
//
//  Created by Blue on 14-6-9.
//
//

#import "OCDrawView.h"

@implementation OCTouchView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchesBlock)
        self.touchesBlock(touches, event, OCTouchStateBegan);
    else
        [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchesBlock)
        self.touchesBlock(touches, event, OCTouchStateMoved);
    else
        [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchesBlock)
        self.touchesBlock(touches, event, OCTouchStateEnded);
    else
        [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.touchesBlock)
        self.touchesBlock(touches, event, OCTouchStateCancelled);
    else
        [super touchesCancelled:touches withEvent:event];
}

@end


@implementation OCDrawView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.drawBlock)
        self.drawBlock(context, rect);
}

@end
