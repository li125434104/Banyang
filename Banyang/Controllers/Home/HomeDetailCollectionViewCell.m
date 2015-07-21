//
//  HomeDetailCollectionViewCell.m
//  Banyang
//
//  Created by LXJ on 15/1/28.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "HomeDetailCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "portrait.h"
#import "major_titleModel.h"
#import "TagList.h"
@implementation HomeDetailCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setConfigureUI];
}

- (void)setConfigureUI {
    [self.portraitImageView roundWithCornerRadius:5];
    [self.firstLable roundWithCornerRadius:2];
    [self.secondLabel roundWithCornerRadius:2];
    [self.thirdLabel roundWithCornerRadius:2];
}

- (void)setModel:(HomeBodyModel *)model {
    _model = model;
    _array = model.badges;
    self.nameLabel.text = model.name;
    self.characteristicLabel.text = model.characteristic;
    self.schoolLabel.text = model.school;
    self.collegeLabel.text = model.department;
    self.provinceLabel.text = model.province;
    [self.portraitImageView sd_setImageWithURL:STR_URL(((portrait *)model.portrait).thumbnail)];
    
    [self hideMarkLabel];
    for (int i = 0; i < model.major_title.count; i++) {
        if (i==0) {
            self.firstLable.text = [self getMarkContent:((major_titleModel *)model.major_title[i]).subject];
        } else if (i==1) {
            self.secondLabel.text = [self getMarkContent:((major_titleModel *)model.major_title[i]).subject];
        } else {
            self.thirdLabel.text = [self getMarkContent:((major_titleModel *)model.major_title[i]).subject];
        }
    }
    
    //TagList *tagListView = [[TagList alloc]initWithFrame:CGRectMake(75, 90, SCREEN_WIDTH-85, 0)];
    [_tagListView setTags:_array];
    CGSize size = _tagListView.fittedSize;
    _tagListView.size = size;
    _tagListView.backgroundColor = [UIColor redColor];
    NSLog(@"%f",size.height);
    //[self addSubview:tagListView];
}

- (void)hideMarkLabel {
    switch (_model.major_title.count) {
        case 0:
        {
            self.firstLable.hidden = YES;
            self.secondLabel.hidden = YES;
            self.thirdLabel.hidden = YES;
        }
            break;
        case 1:
        {
            self.secondLabel.hidden = YES;
            self.thirdLabel.hidden = YES;
        }
            break;
        case 2:
        {
            self.thirdLabel.hidden = YES;
        }
        default:
            break;
    }
}

- (NSString *)getMarkContent:(NSString *)subject {
    return [subject substringToIndex:1];
}

+ (CGFloat)cellHeightForModel:(HomeBodyModel *)model{
    NSArray *array = model.badges;
    TagList *tagListView = [[TagList alloc]initWithFrame:CGRectMake(75, 90, SCREEN_WIDTH-85, 0)];
    [tagListView setTags:array];
    CGSize size = tagListView.fittedSize;
    return size.height;
}

@end
