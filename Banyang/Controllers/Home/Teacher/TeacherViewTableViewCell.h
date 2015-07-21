//
//  TeacherViewTableViewCell.h
//  Banyang
//
//  Created by LXJ on 15/2/5.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBodyModel.h"
@interface TeacherViewTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cycleView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (strong, nonatomic)NSArray *labelArray;
@property (strong, nonatomic)HomeBodyModel *model;
@property (strong, nonatomic)NSString *str;

@property (strong, nonatomic)NSMutableArray *pointArray;

+ (CGFloat)tableViewForHeight:(NSInteger)indexNum withArray:(NSArray *)array;
- (void)setLabelText:(NSInteger)indexNum withArray:(NSArray *)array;
@end
