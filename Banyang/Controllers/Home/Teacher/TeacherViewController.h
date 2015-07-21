//
//  TeacherViewController.h
//  Banyang
//
//  Created by LXJ on 15/2/2.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeBodyModel.h"
#import "TeacherHeaderView.h"
#import "TeacherBottomView.h"

@interface TeacherViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)TeacherHeaderView *headerInfoView;
@property (nonatomic,strong)TeacherBottomView *bottomView;
@property (nonatomic,strong)HomeBodyModel *homeModel;


@end
