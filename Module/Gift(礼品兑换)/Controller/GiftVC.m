//
//  GiftVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "GiftVC.h"
#import "GiftCell.h"
#import "GiftSearchVC.h"
#import "GiftDetailsVC.h"
@interface GiftVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (strong, nonatomic) NSMutableArray * collectionData;
@property (nonatomic, strong) JMRefreshTool * refreshTool;
@end

@implementation GiftVC

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
    [self requestPage];
}




#pragma mark -navigation
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController {
    return NO;
}

#pragma mark - Action

- (IBAction)searchAciton:(id)sender {
    GiftSearchVC * giftSearchVC = [[GiftSearchVC alloc]initWithStoryboard];
    [self.navigationController pushViewController:giftSearchVC animated:YES];
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
    return CGSizeMake((kScreenWidth - 25) / 2 - 0.5, (kScreenWidth - 25) / 2 + 100);
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//item每一列（或者每一行，如果是横向的，就是行，纵向的就是列）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}


#pragma mark - 请求
-(void)requestPage{
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.collectionView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSDictionary *dataDic = responseData[@"data"];
            NSDictionary * dicPage = dataDic[@"page"];
            NSArray *listArray = dicPage[@"list"];
            for(NSDictionary *dic in listArray){
                
            }
            if([weakself.refreshTool isAddData] == YES){
                [weakself.collectionData addObjectsFromArray:array];
            }else{
                weakself.collectionData = array;
            }
            [weakself.collectionView reloadData];
            return array;
        }];
//        if ([JMProjectManager sharedJMProjectManager].loginUser) {
//            self.refreshTool.requestUrl = kGift_UrlPageByAccount;
//        }else{
             self.refreshTool.requestUrl = kGift_UrlPage;
//        }
    
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        self.refreshTool.requestParams = params;
    }
    [self.collectionView.mj_header beginRefreshing];
    
}
@end
