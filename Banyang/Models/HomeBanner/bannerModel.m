//
//  bannerModel.m
//  Banyang
//
//  Created by LXJ on 15/1/27.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "bannerModel.h"
#import "bodyModel.h"
#import "MJExtension.h"

@implementation bannerModel
- (NSDictionary *)objectClassInArray
{
    return @{@"body" : [bodyModel class]};
}

@end
