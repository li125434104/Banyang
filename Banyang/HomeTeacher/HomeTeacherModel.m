//
//  HomeTeacherModel.m
//  Banyang
//
//  Created by LXJ on 15/1/30.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "HomeTeacherModel.h"
#import "HomeBodyModel.h"
@implementation HomeTeacherModel
- (NSDictionary *)objectClassInArray
{
    return @{@"body" : [HomeBodyModel class]};
}


@end
