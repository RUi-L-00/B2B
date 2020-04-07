//
//  CategoriesSecondaryVC.m
//  JMBaseProject
//
//  Created by ios on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "CategoriesSecondaryVC.h"
#import "CategoriesGoodListVC.h"

#import "CategoriesSecondaryCell.h"

#import "CategoriesSecondaryModel.h"

@interface CategoriesSecondaryVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) JMRefreshTool *refreshTool;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation CategoriesSecondaryVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Categories"];
}

- (void)initControl {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)initData {
    if (kUseTestData) {
        self.dataArray = @[[[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest]].mutableCopy;
        [self.collectionView reloadData];
    }
}

#pragma mark -Public
- (void)changeParentGroup:(CategoriesModel *)model {
    if (kUseTestData) {
        self.dataArray = @[[[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest]].mutableCopy;
        [self.collectionView reloadData];
    } else {
        [self requestList:model];
    }
}

#pragma mark -colletionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoriesSecondaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoriesSecondaryCell" forIndexPath:indexPath];
    cell.cellData = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoriesGoodListVC *vc = [[CategoriesGoodListVC alloc] initWithStoryboard];
    vc.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

//设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((collectionView.width - 40) / 3, (self.view.width - 40) / 3 + 40);
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

//item每一列（或者每一行，如果是横向的，就是行，纵向的就是列）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

#pragma mark -网络请求
- (void)requestList:(CategoriesModel *)model {
    if (kUseTestData) {
        self.dataArray = @[[[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest], [[CategoriesSecondaryModel alloc] initWithTest]].mutableCopy;
        [self.collectionView reloadData];
    } else {
        self.dataArray = model.childArray;
        [self.collectionView reloadData];
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
