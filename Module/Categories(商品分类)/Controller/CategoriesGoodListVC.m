//
//  CategoriesGoodListVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "CategoriesGoodListVC.h"

#import "HomeProductCell.h"

#import "CategoriesSecondaryModel.h"

@interface CategoriesGoodListVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) JMRefreshTool *refreshTool;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation CategoriesGoodListVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Categories"];
}

- (void)initControl {
    self.title = self.model.categoriesSecondaryName;
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    //refreshTool
    self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.collectionView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
        NSMutableArray *array = [NSMutableArray array];
        NSDictionary *dataDic = responseData[@"data"];
        for (NSDictionary *dic in dataDic[@"list"]) {
            GoodModel *model = [[GoodModel alloc] initWithCategoriesGoodListDic:dic];
            [array addObject:model];
        }
        if (self.refreshTool.isAddData) {
            //上拉加载
            [self.dataArray addObjectsFromArray:array.copy];
        } else {
            //下拉刷新
            self.dataArray = array;
        }
        [self.collectionView reloadData];
        return array;
    }];
    self.refreshTool.requestParams = [NSMutableDictionary dictionary];
    self.refreshTool.requestParams[@"sessionId"] = [JMProjectManager sharedJMProjectManager].loginUser.sessionId;
    self.refreshTool.requestParams[@"labelId"] = self.model.categoriesSecondaryId;
    self.refreshTool.requestUrl = kCategories_UrlGoodsList;
}

- (void)initData {
    if (kUseTestData) {
        self.dataArray = @[[[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest]].mutableCopy;
        [self.collectionView reloadData];
    } else {
        [self.collectionView.mj_header beginRefreshing];
    }
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

#pragma mark -网络请求


#pragma mark -懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
