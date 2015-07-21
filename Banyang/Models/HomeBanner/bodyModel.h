//
//  bodyModel.h
//  Banyang
//
//  Created by LXJ on 15/1/27.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface bodyModel : NSObject
@property (nonatomic,copy) NSString *action;
@property (nonatomic,copy) NSString *created_at;
@property (nonatomic,copy) NSString *data;
@property (nonatomic,copy) NSString *expired_at;
@property (nonatomic,assign) NSNumber *ID;
@property (nonatomic,copy) NSString *image;

@end
