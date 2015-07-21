//
//  HomeBodyModel.h
//  Banyang
//
//  Created by LXJ on 15/1/30.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class portrait;

@interface HomeBodyModel : NSObject
@property (nonatomic,copy) NSString *announcement;
@property (nonatomic,copy) NSString *background;
@property (nonatomic,strong) NSArray *badges;
@property (nonatomic,copy) NSString *characteristic;
@property (nonatomic,assign) NSNumber *comment_count;
@property (nonatomic,assign) NSNumber *comment_scores_sum;
@property (nonatomic) BOOL course_available;
@property (nonatomic,copy) NSString *department;
@property (nonatomic,assign) NSNumber *full;
@property (nonatomic,copy) NSString *hobby;
@property (nonatomic,assign) NSNumber *ID;
@property (nonatomic,copy) NSString *info;
@property (nonatomic,strong) NSArray *learnexp;
@property (nonatomic,assign) NSNumber *liberal_arts;
@property (nonatomic,assign) NSNumber *like_count;
@property (nonatomic,strong) NSArray *major_title;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSNumber *online_status;
@property (nonatomic,strong) portrait *portrait;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,strong) NSArray *prize;
@property (nonatomic,copy) NSString *province;
@property (nonatomic,copy) NSString *school;
@property (nonatomic,assign) NSNumber *science;
@property (nonatomic,strong) NSArray *scores;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *sub_account_sid;
@property (nonatomic,copy) NSString *teachexp;
@property (nonatomic,assign) NSNumber *view_count;
@property (nonatomic,copy) NSString *voip_account;


@end
