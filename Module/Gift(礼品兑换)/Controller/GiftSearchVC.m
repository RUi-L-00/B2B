//
//  GiftSearchVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "GiftSearchVC.h"
#import "GiftCell.h"
#import "GiftDetailsVC.h"
@interface GiftSearchVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) NSMutableArray *collectionData;
@end

@implementation GiftSearchVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Gift"];
}

- (void)initControl {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.view.backgroundColor = [UIColor whiteColor];
    ViewBorderRadius(self.searchView, 5, 1, [UIColor colorWithHexString:@"#CCCCCC"]);
}


-(void)initData{
    self.collectionData = [NSMutableArray array];
}

#pragma mark - Action

- (IBAction)searchAction:(id)sender {
    [self.collectionData addObject:@"123"];
    [self.collectionData addObject:@"123"];
    [self.collectionData addObject:@"123"];
    [self.collectionData addObject:@"123"];
    [self.collectionData addObject:@"123"];
    [self.collectionData addObject:@"123"];
    [self.collectionData addObject:@"123"];
    [self.collectionView reloadData];
}

#pragma mark -navigation
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController {
    return NO;
}

#pragma mark -colletionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GiftCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GiftCell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GiftDetailsVC * giftDetailsVC = [[GiftDetailsVC alloc]initWithStoryboard];
    [self.navigationController pushViewController:giftDetailsVC animated:YES];
}

//设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth - 25) / 2, ((kScreenWidth - 25) / 2)/175 * 259);
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 22.0;
}

//item每一列（或者每一行，如果是横向的，就是行，纵向的就是列）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}

- (IBAction)popAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
