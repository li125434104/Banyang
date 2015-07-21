//
//  HomeViewController.h
//  Banyang
//
//  Created by LXJ on 15/1/27.
//  Copyright (c) 2015年 LDFS. All rights reserved.
//

#import "BaseViewController.h"
#import "CycleScrollView.h"
@interface HomeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *imageUrlArrays;
@property (strong, nonatomic) NSMutableArray *teacherArrays;

@property (strong, nonatomic) CycleScrollView *bannerScrollView;
@property (assign) CGSize size;

@property (strong, nonatomic) NSArray *hahaArray;
@end
