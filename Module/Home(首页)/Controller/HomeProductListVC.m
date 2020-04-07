//
//  HomeProductListVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "HomeProductListVC.h"

#import "HomeProductCell.h"

@interface HomeProductListVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) JMRefreshTool *refreshTool;
@property (nonatomic, assign) BOOL canScroll;

@end

@implementation HomeProductListVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Home"];
}

- (void)initControl {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"childMove" object:nil];
    //其中一个TAB离开顶部的时候，如果其他几个偏移量不为0的时候，要把他们都置为0
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"superMove" object:nil];
    //开始刷新
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRefreshing) name:kHome_NotificationStartRefreshing object:nil];
    
    //refreshTool
    self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.collectionView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
        NSMutableArray *array = [NSMutableArray array];
        NSDictionary *dataDic = responseData[@"data"];
        for (NSDictionary *dic in dataDic[@"list"]) {
            GoodModel *model = [[GoodModel alloc] initWithHomeListDic:dic];
            [array addObject:model];
        }
        if (self.refreshTool.isAddData) {
            //上拉加载
            [self.dataArray addObjectsFromArray:array.copy];
        } else {
            //下拉刷新
            self.dataArray = array;
            [[NSNotificationCenter defaultCenter] postNotificationName:kHome_NotificationEndRefreshing object:nil userInfo:nil];
        }
        [self.collectionView reloadData];
        return array;
    }];
    self.refreshTool.requestParams = [NSMutableDictionary dictionary];
    self.refreshTool.requestParams[@"sessionId"] = [JMProjectManager sharedJMProjectManager].loginUser.sessionId;
    switch (self.type) {
        case 0: {
            self.refreshTool.requestUrl = kHome_UrlRecommendGoodsPage;
            break;
        }
            
        
        case 1: {
            self.refreshTool.requestUrl = kHome_UrlHotGoodsPage;
            break;
        }
            
        
        case 2: {
            self.refreshTool.requestUrl = kHome_UrlNewGoodsPage;
            break;
        }
            
        default:
            self.refreshTool.requestUrl = kHome_UrlRecommendGoodsPage;
            break;
    }
}

- (void)initData {
    if (kUseTestData) {
        self.dataArray = @[[[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest]].mutableCopy;
    } else {
        [self.collectionView.mj_header beginRefreshing];
    }
}

#pragma mark -notification
- (void)startRefreshing {
    //开始刷新
    [self.collectionView.mj_header beginRefreshing];
}

#pragma mark -colletionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProductCell" forIndexPath:indexPath];
    GoodModel *model = self.dataArray[indexPath.row];
    cell.cellData = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodModel *model = self.dataArray[indexPath.row];
    GoodsDetailsVC *goodsDetailsVC = [[GoodsDetailsVC alloc] initWithStoryboard];
    goodsDetailsVC.goodId = model.goodId;
    [self.navigationController pushViewController:goodsDetailsVC animated:YES];
}

//设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake((kScreenWidth - 24.5) / 2 - 0.5, (kScreenWidth - 24.5) / 2 + 100);
    return size;
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}

//item每一列（或者每一行，如果是横向的，就是行，纵向的就是列）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4.5;
}

#pragma mark -notification
-(void)acceptMsg:(NSNotification *)notification {
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:@"childMove"]) {
        self.canScroll = YES;
    }else if([notificationName isEqualToString:@"superMove"]){
        self.collectionView.contentOffset = CGPointZero;
        self.canScroll = NO;
    }
}

#pragma mark -scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScroll) {
        [scrollView setContentOffset:CGPointZero];
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"superMove" object:nil userInfo:nil];
    }
}

#pragma mark -懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
