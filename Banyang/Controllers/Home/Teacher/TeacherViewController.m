//
//  TeacherViewController.m
//  Banyang
//
//  Created by LXJ on 15/2/2.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "TeacherViewController.h"
#import "UIImageView+WebCache.h"
#import "portrait.h"
#import "ParallaxHeaderView.h"
#import "OCTypes.h"
#import "TeacherViewTableViewCell.h"
#import "UITableView+Wave.h"
#import "PayViewController.h"
#define CREATE_WEAK_SELF    __weak typeof(self) weakSelf = self

@interface TeacherViewController ()<UINavigationBarDelegate,UINavigationControllerDelegate>
{
    CGFloat lastPosition;
}

@property (nonatomic ,strong)UIVisualEffectView *visualEffectView;
@end

@implementation TeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.extendedLayoutIncludesOpaqueBars = YES;
    [self setNav];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:((portrait *)self.homeModel.portrait).origin]];
    
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _visualEffectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 264);
    [imageView addSubview:_visualEffectView];
    
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithSubView:imageView];
    [self.tableView setTableHeaderView:headerView];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TeacherHeaderView" owner:self options:nil];
    self.headerInfoView = [nib objectAtIndex:0];
    self.headerInfoView.frame = CGRectMake(0, _visualEffectView.frame.size.height-50, SCREEN_WIDTH, 50);
    [self.headerInfoView setUIWithModel:self.homeModel];
    [self.view addSubview:self.headerInfoView];
    
    TeacherBottomView *bottomView = LOAD_NIB(@"TeacherBottomView");
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-49, 320*IOS_SCALE, 49);
    [bottomView setUIWithModel:self.homeModel];
    bottomView.IMButtonBlock = ^(HomeBodyModel *model) {
        LOG(model.price);
        
    };
    bottomView.payButtonBlock = ^(HomeBodyModel *model) {
        self.hidesBottomBarWhenPushed = YES;
        PayViewController *VC = [[self storyboard] instantiateViewControllerWithIdentifier:@"PayViewController"];
        VC.model = self.homeModel;
        [self.navigationController pushViewController:VC animated:YES];
    };
    [self.view addSubview:bottomView];
    
    [self.tableView reloadDataAnimateWithWave:RightToLeftWaveAnimation];

}

- (void)viewDidLayoutSubviews
{
}

- (void)setNav {
    self.title = self.homeModel.name;
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
//    ((UIView *)[self.navigationController.navigationBar.subviews objectAtIndex:0]).alpha = 0;
}

- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    ((UIView *)[self.navigationController.navigationBar.subviews objectAtIndex:0]).alpha = 0;
}


- (void)viewWillDisappear:(BOOL)animated  {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    ((UIView *)[self.navigationController.navigationBar.subviews objectAtIndex:0]).alpha = 1;
}

#pragma mark tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeacherViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TeacherViewTableViewCell"];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TeacherViewTableViewCell" owner:self options:nil] lastObject];

    }
    if (indexPath.row==0) {
        [cell setLabelText:indexPath.row withArray:self.homeModel.learnexp];
    } else {
        [cell setLabelText:indexPath.row withArray:self.homeModel.scores];
    }
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    label.text = @"第一行";
    label.backgroundColor = [UIColor grayColor];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return [TeacherViewTableViewCell tableViewForHeight:indexPath.row withArray:self.homeModel.learnexp]+30;
    }else if (indexPath.row==1) {
        return [TeacherViewTableViewCell tableViewForHeight:indexPath.row withArray:self.homeModel.scores]+30;
    } else {
        return 50;
    }
    //return 100;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        // pass the current offset of the UITableView so that the ParallaxHeaderView layouts the subViews.
        [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
        if (scrollView.contentOffset.y < -64) {
            _visualEffectView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 264+ (- scrollView.contentOffset.y));

        }
        _headerInfoView.frame = CGRectMake(0, 200-50+ (-scrollView.contentOffset.y), SCREEN_WIDTH, 50);
        ((UIView *)[self.navigationController.navigationBar.subviews objectAtIndex:0]).alpha = (64 + (scrollView.contentOffset.y)) / 200.0f;
        
        
        //判断上下
//        CGFloat currentPostion = scrollView.contentOffset.y;
//        if (currentPostion - lastPosition > 0) {
//            NSLog(@"ScrollDown up");
//            self.bottomView.hidden = NO;
//        }
//        else
//        {
//            self.bottomView.hidden = YES;
//            NSLog(@"ScrollDown now");
//        }
//        lastPosition = currentPostion;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if (translation.y>0) {
        [UIView animateWithDuration:0.5f animations:^{
            self.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
        }];
    }else if(translation.y<0){
        [UIView animateWithDuration:0.5f animations:^{
            self.bottomView.frame = CGRectMake(0, SCREEN_HEIGHT+49, SCREEN_WIDTH, 49);
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
