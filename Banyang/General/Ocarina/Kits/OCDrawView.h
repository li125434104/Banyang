//
//  OCControlView.h
//  Biquu
//
//  Created by Blue on 14-6-9.
//
//

#import <UIKit/UIKit.h>

typedef enum {
    OCTouchStateBegan,
    OCTouchStateMoved,
    OCTouchStateEnded,
    OCTouchStateCancelled
} OCTouchState;


@interface OCTouchView : UIView

@property (nonatomic, copy) void(^touchesBlock)(NSSet *touches, UIEvent *event, OCTouchState state);

@end


@interface OCDrawView : OCTouchView

@property (nonatomic, copy) void(^drawBlock)(CGContextRef context, CGRect rect);

@end
