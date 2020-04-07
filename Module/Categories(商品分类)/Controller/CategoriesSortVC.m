//
//  CategoriesSortVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "CategoriesSortVC.h"

#import "CategoriesSortCell.h"

@interface CategoriesSortVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation CategoriesSortVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Categories"];
}

- (void)initControl {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 45.0;
}

- (void)initData {
    if (kUseTestData) {
        self.dataArray = @[[[CategoriesModel alloc] initWithTest], [[CategoriesModel alloc] initWithTest], [[CategoriesModel alloc] initWithTest], [[CategoriesModel alloc] initWithTest], [[CategoriesModel alloc] initWithTest]].mutableCopy;
        CategoriesModel *model = self.dataArray[self.index];
        model.isSelect = YES;
        [self.tableView reloadData];
        if (self.changeGroupBlock) {
            CategoriesModel *model = self.dataArray[self.index];
            self.changeGroupBlock(model);
        }
    } else {
        [self requestType];
    }
}

#pragma mark -tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoriesSortCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoriesSortCell"];
    CategoriesModel *model = self.dataArray[indexPath.row];
    cell.cellData = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (CategoriesModel *model in self.dataArray) {
        model.isSelect = NO;
    }
    CategoriesModel *model = self.dataArray[indexPath.row];
    model.isSelect = YES;
    [self.tableView reloadData];
    if (self.changeGroupBlock) {
        CategoriesModel *model = self.dataArray[indexPath.row];
        self.changeGroupBlock(model);
    }
}

#pragma mark -网络请求
- (void)requestType {
    //请求商品分类
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kCategories_UrlCategories parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            NSArray *dataArr = response.responseObject[@"data"];
            for (NSDictionary *dic in dataArr) {
                CategoriesModel *model = [[CategoriesModel alloc] initWithCategoryListDic:dic];
                [self.dataArray addObject:model];
            }
            if (self.index >= self.dataArray.count) {
                self.index = 0;
            }
            CategoriesModel *model = self.dataArray[self.index];
            model.isSelect = YES;
            [self.tableView reloadData];
            if (self.changeGroupBlock) {
                self.changeGroupBlock(model);
            }
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
