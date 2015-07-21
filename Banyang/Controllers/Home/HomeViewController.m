//
//  HomeViewController.m
//  Banyang
//
//  Created by LXJ on 15/1/27.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "HomeViewController.h"
#import "GeneralRequestApi.h"
#import "bannerModel.h"
#import "bodyModel.h"
#import "UIImageView+WebCache.h"
#import "HomeCollectionHeaderView.h"
#import "HomeCollectionFooterView.h"
#import "HomeDetailCollectionViewCell.h"
#import "YTKBatchRequest.h"
#import "HomeTeacherModel.h"
#import "HomeBodyModel.h"
#import "badgesModel.h"
#import "TeacherViewController.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageUrlArrays = [NSMutableArray array];
    self.teacherArrays = [NSMutableArray array];
    [self bannerRequest];
    [self setConfigureUI];
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = NO;

}

- (void)viewDidLayoutSubviews {
    self.hidesBottomBarWhenPushed = NO;
}

- (void)bannerRequest {
    GeneralRequestApi *api = [[GeneralRequestApi alloc]initWithUrlStr:@"info/banners"];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        bannerModel *model = [bannerModel objectWithKeyValues:request.responseJSONObject];
        for (bodyModel *bodyModel in model.body) {
            [self.imageUrlArrays addObject:bodyModel.image];
        }
        [self setBannerScrollView];
        //[self.collectionView reloadData];
    } failure:^(YTKBaseRequest *request) {
        [MBProgressHUD showMessag:@"网络错误" toView:self.view];
    }];
    
    GeneralRequestApi *api2 = [[GeneralRequestApi alloc]initWithUrlStr:@"teachers/recommendation?count=20"];
    [api2 startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        HomeTeacherModel *model = [HomeTeacherModel objectWithKeyValues:request.responseJSONObject];
        for (HomeBodyModel *bodyModel in model.body) {
            [self.teacherArrays addObject:bodyModel];
        }
        [self.collectionView reloadData];
    } failure:^(YTKBaseRequest *request) {
        [MBProgressHUD showMessag:@"网络错误" toView:self.view];
    }];
}

- (void)setConfigureUI {
    UINib *nib = [UINib nibWithNibName:@"HomeDetailCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"ReuseIdentifier"];
//    [self.collectionView registerClass:[HomeCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
}

- (void)setBannerScrollView {
    NSMutableArray *viewsArray = [@[] mutableCopy];
    self.bannerScrollView = [[CycleScrollView alloc]initWithFrame:RECTMAKE(0, 0, SCREEN_WIDTH, 120) animationDuration:self.imageUrlArrays.count];
    for (int i = 0; i < self.imageUrlArrays.count; ++i) {
        UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:RECTMAKE(0, 0, SCREEN_WIDTH, 120)];
        [bannerImageView sd_setImageWithURL:STR_URL(self.imageUrlArrays[i])];
        [viewsArray addObject:bannerImageView];
    }
    self.bannerScrollView.totalPagesCount = ^NSInteger(void){
        return viewsArray.count;
    };

    self.bannerScrollView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex) {
        return viewsArray[pageIndex];
    };
    self.bannerScrollView.tapActionBlock = ^(NSInteger pageIndex) {
        NSLog(@"%ld",(long)pageIndex);
    };
    [self.collectionView addSubview:self.bannerScrollView];
}

#pragma mark collectionView DataSource and Delegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeDetailCollectionViewCell *cell = (HomeDetailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ReuseIdentifier" forIndexPath:indexPath];
    HomeBodyModel *model = self.teacherArrays[indexPath.row];
    cell.model = model;
    return cell;
}

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.teacherArrays.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView * reusableview = nil ;
    
    if ( kind == UICollectionElementKindSectionHeader ) {
        HomeCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        [headerView.firstView roundToCircle];
        [headerView.secondView roundToCircle];
        [headerView.thirdView roundToCircle];
        [headerView.forthView roundToCircle];
        reusableview = headerView;
    }

    
    if ( kind == UICollectionElementKindSectionFooter ) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@ "FooterView" forIndexPath:indexPath] ;
        
        reusableview = footerview;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeBodyModel *model = _teacherArrays[indexPath.row];
    return CGSizeMake(320*IOS_SCALE, 90+[HomeDetailCollectionViewCell cellHeightForModel:model]);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TeacherViewController *teacher = [[self storyboard] instantiateViewControllerWithIdentifier:@"TeacherViewController"];
    self.hidesBottomBarWhenPushed = YES;
    HomeBodyModel *model = self.teacherArrays[indexPath.row];
    teacher.homeModel = model;
    [self.navigationController pushViewController:teacher animated:YES];
}

- (IBAction)titleViewPressed:(UITapGestureRecognizer *)sender {
    NSLog(@"%ld",(long)sender.view.tag);
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
