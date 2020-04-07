//
//  GoodsDetailsPatternCell.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodsDetailsPatternCell.h"
#import "GoodsDetailsSpecCell.h"

@interface GoodsDetailsPatternCell() <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation GoodsDetailsPatternCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (void)setCellData:(GoodSpecModel *)cellData {
    _cellData = cellData;
    self.nameLabel.text = cellData.patternName;
    self.dataArray = [cellData.normArray mutableCopy];
    [self.collectionView reloadData];
    self.collectionViewHeight.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height + 15;
    [self.collectionView layoutIfNeeded];
}

#pragma mark -colletionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailsSpecCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodsDetailsSpecCell" forIndexPath:indexPath];
    SpecItemModel *model = self.dataArray[indexPath.row];
    cell.cellData = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (SpecItemModel *model in self.dataArray) {
        model.isSelect = NO;
    }
    SpecItemModel *model = self.dataArray[indexPath.row];
    model.isSelect = YES;
    [collectionView reloadData];
    if (self.selectSpecBlock) {
        self.selectSpecBlock(indexPath.row);
    }
}

//设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SpecItemModel *model = self.dataArray[indexPath.row];
    CGSize size = [model.normName boundingRectWithSize:CGSizeMake(MAXFLOAT, 22) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0]} context:nil].size;
    return CGSizeMake(size.width + 28, 22);
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0;
}

//item每一列（或者每一行，如果是横向的，就是行，纵向的就是列）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}

#pragma mark -懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
