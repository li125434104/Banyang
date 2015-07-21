//
//  HomeDetailCollectionViewCell.h
//  Banyang
//
//  Created by LXJ on 15/1/28.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBodyModel.h"
#import "TagList.h"
@interface HomeDetailCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLable;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *collegeLabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *characteristicLabel;
@property (weak, nonatomic) IBOutlet TagList *tagListView;
@property (strong ,nonatomic)HomeBodyModel *model;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) TagList *tagList;
+ (CGFloat)cellHeightForModel:(HomeBodyModel *)model;

@end
