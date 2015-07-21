//
//  Definitions.h
//  Biquu
//
//  Created by Blue on 14-6-9.
//  Copyright (c) 2014年 Biquu. All rights reserved.
//

#import "OCTypes.h"
#import "Ocarina.h"

//@"http://app_test.biquu.com/"
#define SERVER_URL          @"http://app.bangyoung.com:4084/"
//#define SERVER_URL          @"http://app_test.biquu.com/"
//#define SERVER_URL          @"http://192.168.1.105/"

#define SECURE_SERVER_URL   @""
#define CDN_BASE_URL        @""
#define BQ_URL             @""
#define APP_URL             @""
#define APP_ID              @""

#define CDN_ICON_URLSTR(s)  [NSString stringWithFormat:@"%@icon/%@", CDN_BASE_URL, s]
#define CDN_ICON_URL(s)     [NSURL URLWithString:CDN_ICON_URLSTR(s)]

#define ITEMS_VERSION_KEY   @"ItemsVersionKey"

#define BACKGROUND_COLOR    [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage.png"]]
#define REGISTER_BACKGROUND_COLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
#define SPLASH_BACKGROUND_COLOR [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]]

#define keywindow [UIApplication sharedApplication].keyWindow

#define PLACEHOLDER_IMAGE   [UIImage imageNamed:@"PlaceHolderImage.png"]

#define RESOURCES_DIR       @"Resources"

#define VC_TRANSITION_DURATION      0.4

#pragma mark- 自定义View的边缘弧度
#define ROUND_RADIUS                0
#define AVATAR_ROUND_RADIUS         12

//#define NORMAL_COLOR_ALPHA          0.6
#define NORMAL_COLOR_ALPHA          0.5
#define BAR_COLOR_ALPHA             0.85
#define MASK_VIEW_ALPHA             0.6

#define VC_BORDER_PADDING           7
#define VC_BOTTOM_PADDING           5
#define CELL_GAP_LENGTH             6
#define DEFAULT_ROUND_VIEW_HEIGHT   38

#define FAKE_CELL_BEGIN_TAG         950
#define FAKE_CELL_END_TAG           999
#define FAVORITE_CONSTELLATION_TAG  1000
#define FAVORITE_SEX_TAG 1020

#define TITILE_BAR_COLOR            COLOR_RGBA(4, 157, 239, 1)
#define CHAT_BAR_COLOR              COLOR_RGBA(229, 227, 235, 1)

#define GRAY_BG_HIGHLIGHTED_COLOR   COLOR_RGB(160, 160, 170)
#define DEFAULT_THEME_COLOR         COLOR_RGB(33, 8, 47)
//#define DEFAULT_THEME_COLOR         COLOR_RGB(222, 224, 226)
#define GREEN_BUTTON_COLOR          COLOR_RGB(164, 210, 163)
#define YELLOW_BG_COLOR             COLOR_RGB(241, 181, 61)
#define NORMAL_BADGE_COLOR          COLOR_RGB(231, 41, 48)
#define NORMAL_MARK_COLOR           COLOR_RGBA(255, 255, 255,0);
#define FIRSTMENU_COLOR             COLOR_RGBA(255, 255, 255, 0.6)
#define SECONDMENU_COLOR            COLOR_RGBA(165, 211, 164, 0.7)
#define THIRDMENU_COLOR             COLOR_RGBA(61, 59, 165, 0.5)
#define FIRSTMENU_ALPHA             0.6
#define SECONDMENU_ALPHA            0.7
#define THIRDMENU_ALPHA             0.5

#define ENERGY_GRID_COUNT           10

#define AVATAR_SIZE                 CGSizeMake(640, 640)

#define SHOW_PROFILE_SEGUE  @"ShowProfileVCSegue"
#define SHOW_INFOR_SEGUE    @"ShowInforVCSegue"
#define SHOW_PK_SEGUE       @"ShowPKVCSegue"

#define QINIUBUCKETNAME     @"weixingzuo"

#define KICKOUT_NOTIFICATION    @"KickoutNotification"
#define ADD_FRIEND_NOTIFICATION @"AddFriendNotification"

#pragma mark- 设置属性用宏

#define SET_STRING_PROPERTY_WITH_KEY(p, d, k)   p = [d stringValueForKey:k]? [d stringValueForKey:k]: p
#define SET_INT_PROPERTY_WITH_KEY(p, d, k)      p = [d objectForKey:k]? [d intValueForKey:k]: p
#define SET_FLOAT_PROPERTY_WITH_KEY(p, d, k)    p = [d objectForKey:k]? [d floatValueForKey:k]: p
#define SET_DOUBLE_PROPERTY_WITH_KEY(p, d, k)   p = [d objectForKey:k]? [d doubleValueForKey:k]: p
#define SET_BOOL_PROPERTY_WITH_KEY(p, d, k)     p = [d objectForKey:k]? [d boolValueForKey:k]: p

#pragma mark- 枚举类型定义
typedef enum {
    kProfileTypeFront = 1,
    kProfileTypeSide
} WXZProfileType;

typedef enum {
    kGenderUnknown = 0,
    kGenderMale = 1,
    kGenderFemale
} WXZGender;

typedef enum {
    kItemTagHead = 1,
    kItemTagBody,
    kItemTagLeftHand,
    kItemTagRightHand,
    kItemTagLeftLeg,
    kItemTagRightLeg,
    kItemTagHairs = 7,
    kItemTagHairBack,
    kItemTagEyes,
    kItemTagUpperGarments = 10,
    kItemTagLowerGarments,
    kItemTagSuites,
    kItemTagHeadWear = 17
} WXZItemTag;

typedef enum {
    kItemTypeClothes = 1,
    kItemTypeTools,
    kItemTypeSkills,
    kItemTypeGoods
} WXZItemType;

typedef enum {
    kSharePlatformSina = 1,
    kSharePlatformQZone,
    kSharePlatformRenRen,
    kSharePlatformDouban,
    kSharePlatformTXWeibo,
    kSharePlatformWeixin,
    kSharePlatformMail,
    kSharePlatformSMS,
    kSharePlatformQQ,
    kSharePlatformWeixinPengyou
} WXZSharePlatform;



typedef enum {
    kLoginStateUnlogined = 0,
    kLoginStateLogined = 2,
} WXZLoginState;


typedef enum {
    kBindStateUnbind = 1,
    kBindStateBinded
} WXZBindState;

typedef enum {
    kPKResultWin,
    kPKResultLose,
    kPKResultDraw
} WXZPKResult;

typedef enum {
    kCoinTypePlanet = 1,
    kCoinTypeStar
} WXZCoinType;



typedef enum {
    kFriendStateOutsider = 0,
    kFriendStateNotFriend,
    kFriendStateFriend,
    kFriendStateInviting = 100
} WXZFriendState;



/*
 0  双方不是好友
 1  我加对方 对方没加我
 2  对方加我 我没加对方
 3  双方都加对方为好友
 -1 站外用户
 */
typedef enum {
    kRelationStateStranger,
    kRelationStateIFollowHim,
    KRelationStateHeFollowMe,
    kRelationStateBothFollowed,
    kRelationStateSelf = -1
} WXZRelationState;


typedef enum {
    kErrorCodeSucceeded = 0,
    kErrorCodeKickout = 13,
    kErrorCodeForbidden = 14,
    
    kErrorCodeASI = 900900,
    kErrorCodeDefault,
    kErrorCodeWrongResonse,
    kErrorCodeNetworkDisconnected
} WXZErrorCode;

typedef enum {
    kPushTypeNewFriend = 1,
    kPushTypeNewBulletin,
} kPushType;

typedef enum {
    kRequestTypeNull,
    kRequestTypeRefresh,
    kRequestTypeAppend,
    kRequestTypeUpdate,
    kRequestTypeFirstTime
} WXZRequestType;

typedef enum {
    kRequestMethodGet,
    kRequestMethodPost
} WXZRequestMethod;

typedef enum {
    kList,
    kGrid
} WXZFriendListType;

