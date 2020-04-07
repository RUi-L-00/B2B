//
//  HomeVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "HomeVC.h"

#import "ContainerScroll.h"
#import "HomeTypeCell.h"
#import "HomeSearchVC.h"
@interface HomeVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet ContainerScroll *scrollView;
@property (weak, nonatomic) IBOutlet UIView *searchView;//搜索框
@property (weak, nonatomic) IBOutlet UIButton *integralButton;//积分
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewHeight;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (assign, nonatomic) BOOL canScroll;

@end

@implementation HomeVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Home"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (kUseTestData) {
        self.dataArray = @[[[CategoriesModel alloc] initWithTest], [[CategoriesModel alloc] initWithTest], [[CategoriesModel alloc] initWithTest], [[CategoriesModel alloc] initWithTest], [[CategoriesModel alloc] initWithTest]].mutableCopy;
        [self.collectionView reloadData];
    } else {
        [self requestClassificationData];
    }
}

- (void)initControl {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionViewHeight.constant = (kScreenWidth - 60) / 5 + 18 * 2;
    
    //searchView
    ViewBorderRadius(self.searchView, 10, 1, [UIColor colorWithHexString:@"#CCCCCC"]);
    
    //scrollView
    self.canScroll = YES;
    self.scrollView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptMsg:) name:@"superMove" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endRefresh) name:kHome_NotificationEndRefreshing object:nil];
    self.containerViewHeight.constant = kScreenHeight - XP_TabbarHeight - XP_StatusBarHeight;
    [self.scrollView xk_setNormalHeaderWithRefreshingBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kHome_NotificationStartRefreshing object:nil userInfo:nil];
    }];
}

- (void)initData {
    [[JMProjectManager sharedJMProjectManager] updateLoginUserInfoSuccessBlock:^{
        
    } failBlock:nil];
}

#pragma mark -navigation
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController {
    return NO;
}

#pragma mark -notification
-(void)acceptMsg:(NSNotification *)notification {
    self.canScroll = YES;
}

- (void)endRefresh {
    //结束刷新
    [self.scrollView xk_endRefreshing];
}



#pragma mark -scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = self.containerView.mj_y;
    if (scrollView.contentOffset.y >= height) {
        scrollView.contentOffset = CGPointMake(0, height);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"childMove" object:nil userInfo:nil];
        self.canScroll = NO;
    } else {
        if (scrollView.contentOffset.y > 0) {
            if (!self.canScroll) {
                scrollView.contentOffset = CGPointMake(0, height);
            }
        }
    }
}



#pragma mark -Action
- (IBAction)searchAction:(id)sender {
   HomeSearchVC  * homeSearchVC = [[HomeSearchVC alloc]initWithStoryboard];
    [self.navigationController pushViewController:homeSearchVC animated:YES];
}

#pragma mark -colletionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTypeCell" forIndexPath:indexPath];
    CategoriesModel *model = self.dataArray[indexPath.row];
    cell.cellData = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    if (index == self.dataArray.count - 1) {
        index = 0;
    }
    [self goClassificationVC:index];
}

//设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kScreenWidth - 50) / 5, (kScreenWidth - 50) / 5 + 25);
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 22.0;
}

//item每一列（或者每一行，如果是横向的，就是行，纵向的就是列）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5.0;
}

#pragma mark -跳转
- (void)goClassificationVC:(NSInteger)index {
    //跳转商品分类
    CategoriesVC *categoriesVC = [[CategoriesVC alloc] initWithStoryboard];
    categoriesVC.index = index;
    [self.navigationController pushViewController:categoriesVC animated:YES];
}

#pragma mark -网络请求
- (void)requestClassificationData {
    //请求商品分类
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kHome_UrlClassification parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            NSArray *dataArr = response.responseObject[@"data"];
            self.dataArray = [NSMutableArray array];
            for (NSDictionary *dic in dataArr) {
                CategoriesModel *model = [[CategoriesModel alloc] initWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            [self.collectionView reloadData];
        }
    }];
}

#pragma mark -懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
