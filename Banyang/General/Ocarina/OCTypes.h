//
//  OCTypes.h
//  Biquu
//
//  Created by Blue on 14-6-9.
//


typedef void (^OCSimpleBlock)();
typedef void (^OCBoolBlock)(BOOL success);
typedef void (^OCIntBlock)(int result);
typedef void (^OCErrorBlock)(NSError *error);
typedef void (^OCRequestBlock)(id result, NSError *error);
typedef void (^OCViewBlock)(UIView *view);
typedef void (^OCObjectBlock)(id object);


#ifdef __OPTIMIZE__
#define NSLog(...) {}
#define OCLog(format...)
#else
#define OCLog(format...) OCLogPrivate(format)
#endif


#define	ARC4RANDOM_MAX      0x100000000

#define RANDOM()            arc4random()
#define RANDOM2(from, to)   (arc4random() % ((to) - (from)) + (from))
#define RANDOM_F()          (arc4random() / (double)ARC4RANDOM_MAX)
#define RANDOM_F2(from, to) (oc_random_f() * ((to) - (from)) + (from))
#define RANDOM_POINT(mw,mh) CGPointMake(RANDOM2(0, mw), RANDOM2(0, mh))

#define STR_RANGE(string)   NSMakeRange(0, string.length)
#define STR_URL(s)          [NSURL URLWithString:s]

#define LOG(obj)            NSLog(@"%s: %@", #obj, obj)
#define LOG_INT(n)          NSLog(@"%s: %d", #n, n)
#define LOG_FLOAT(f)        NSLog(@"%s: %f", #f, f)
#define LOG_POINT(p)        NSLog(@"%s: %@", #p, NSStringFromCGPoint(p))
#define LOG_SIZE(s)         NSLog(@"%s: %@", #s, NSStringFromCGSize(s))
#define LOG_RECT(r)         NSLog(@"%s: %@", #r, NSStringFromCGRect(r))
#define LOG_RANGE(r)        NSLog(@"%s: %@", #r, NSStringFromRange(r))
#define LOG_STR(s)          NSLog(@"%@", s)

#define POINT_VALUE(point)  [NSValue valueWithCGPoint:point]
#define POINT_VALUE2(x, y)  [NSValue valueWithCGPoint:CGPointMake(x, y)]
#define RECT_VALUE(rect)    [NSValue valueWithCGRect:rect]
#define SIZE_VALUE(size)    [NSValue valueWithCGSize:size]
#define SIZE_VALUE2(w, h)   [NSValue valueWithCGSize:CGSizeMake(w, h)]

#define INT_STR(n)          [NSString stringWithFormat:@"%d", n]
#define FLOAT_STR(f)        [NSString stringWithFormat:@"%f", f]
#define DOUBLE_STR(lf)      [NSString stringWithFormat:@"%lf", lf]

#define NON_NIL_STRING(s)   (s? s: @"")

#define _P2V(p)             [NSValue valueWithCGPoint:p]
#define _S2V(s)             [NSValue valueWithCGSize:s]
#define _R2V(r)             [NSValue valueWithCGRect:r]
#define _RA2V(r)            [NSValue valueWithRange:r]
#define _CGA2V(t)           [NSValue valueWithCGAffineTransform:t]
#define _CAT2V(t)           [NSValue valueWithCATransform3D:t]

#define _D2R(d)             (d * M_PI / 180.0)
#define _R2D(r)             (r * 180 / M_PI)

#define _LS(s)              NSLocalizedString(s, nil)
#define _URL(string)        [NSURL URLWithString:string]
#define _null               [NSNull null]

#define CREATE_WEAK_SELF    __weak typeof(self) weakSelf = self


//Color
#define COLOR_RGBA(r, g, b, a)  [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:a]
#define COLOR_RGB(r, g, b)      COLOR_RGBA(r, g, b, 1)


//Geo
#define POINT_ADD(p1, p2)       CGPointMake(p1.x + p2.x, p1.y + p2.y)
#define POINT_ADD2(p, px, py)     CGPointMake(p.x + px, p.y + py)
#define POINT_DISTANCE(p1, p2)  sqrtf((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y))

#define RECT_MIN_POINT(r)       CGPointMake(CGRectGetMinX(r), CGRectGetMinY(r))
#define RECT_MID_POINT(r)       CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r))
#define RECT_MAX_POINT(r)       CGPointMake(CGRectGetMaxX(r), CGRectGetMaxY(r))

#define RECTMAKE(x,y,w,h)        CGRectMake((x),(y),(w),(h))

// 自适应宽度和高度
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT           ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.height-20)

//Info
#define APP_VERSION             [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]
#define APP_VERSION_SHORT       [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APP_BUNDLE_NAME         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]
#define SYSTEM_VERSION          [[[UIDevice currentDevice] systemVersion] floatValue]
#define SCREEN_SCALE            [[UIScreen mainScreen] scale]

#define DEVICE_IDIOM            [[UIDevice currentDevice] userInterfaceIdiom]

#define DEFAULT_WINDOW          [[[UIApplication sharedApplication] delegate] window]

#define IS_PHONE_DEVICE         (DEVICE_IDIOM == UIUserInterfaceIdiomPad)
#define IS_PAD_DEVICE           (DEVICE_IDIOM == UIUserInterfaceIdiomPhone)
#define IS_4INCH_DEVICE         ([[UIScreen mainScreen] bounds].size.height > 480)
#define IS_IOS7_AND_NEWER       (SYSTEM_VERSION >= 7.0)
#define IOS_SCALE  ([[UIScreen mainScreen] bounds].size.width / 320)


// version check
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:       NSNumericSearch] != NSOrderedDescending)



#define IS_WIFI_AVAILABLE       ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] == ReachableViaWiFi)
#define IS_WWAN_AVAILABLE       ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == ReachableViaWWAN)
#define IS_NETWORK_AVAILABLE    (IS_WIFI_AVAILABLE || IS_WWAN_AVAILABLE)


#define LOAD_NIB(name)          [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil] lastObject]
#define NOTIFICATION_CENTER     [NSNotificationCenter defaultCenter]

//Dispatch
#define MAIN_DISPATCH_QUEUE     dispatch_get_main_queue()
#define DEFAULT_DISPATCH_QUEUE  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define DISPATCH_AFTER_TIME(n)  dispatch_time(DISPATCH_TIME_NOW, n * NSEC_PER_SEC)


//Autoresizing
#define FILL_MASK               (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)
#define FIX_CENTER_MASK         (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin)


#define BoundsWithSize(size)    (CGRect){CGPointZero, size}
#define BoundsMake(w, h)        (CGRect){CGPointZero, w, h}


#define IgnorePerformWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


void OCLogPrivate(NSString *format, ...);


