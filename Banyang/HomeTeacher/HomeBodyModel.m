
//
//  HomeBodyModel.m
//  Banyang
//
//  Created by LXJ on 15/1/30.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "HomeBodyModel.h"
#import "badgesModel.h"
#import "learnexpModel.h"
#import "major_titleModel.h"
#import "prizeModel.h"
#import "scoresModel.h"

@implementation HomeBodyModel

- (NSDictionary *)objectClassInArray
{
    return @{@"badges" : [badgesModel class],
             @"learnexp" : [learnexpModel class],
             @"major_title" : [major_titleModel class],
             @"prize" : [prizeModel class],
             @"scores" : [scoresModel class]
             };
}

- (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}
@end
