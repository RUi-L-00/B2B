//
//  NoticeVC.m
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "NoticeVC.h"
#import "NoticeDetailsVC.h"

#import "NoticeSystemCell.h"
#import "NoticeGiftRedemptionCell.h"

#import "NoticeModel.h"

@interface NoticeVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) JMRefreshTool *refreshTool;

@end

@implementation NoticeVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Notice"];
}

- (void)initControl {
    self.title = @"消息";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 68;
    
    //refreshTool
    self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
        NSMutableArray *array = [NSMutableArray array];
        NSDictionary *dataDic = responseData[@"data"];
        for (NSDictionary *dic in dataDic[@"list"]) {
            NoticeModel *model = [[NoticeModel alloc] initWithDictionary:dic];
            [array addObject:model];
        }
        if (self.refreshTool.isAddData) {
            //上拉加载
            [self.dataArray addObjectsFromArray:array.copy];
        } else {
            //下拉刷新
            self.dataArray = array;
        }
        [self.tableView reloadData];
        return array;
    }];
    self.refreshTool.requestParams = [JMCommonMethod baseRequestParams];
    self.refreshTool.requestUrl = kNotice_UrlNoticePage;
}

- (void)initData {
    if (kUseTestData) {
        self.dataArray = @[[[NoticeModel alloc] initWithTest], [[NoticeModel alloc] initWithTest], [[NoticeModel alloc] initWithTest], [[NoticeModel alloc] initWithTest], [[NoticeModel alloc] initWithTest], [[NoticeModel alloc] initWithTest]].mutableCopy;
    } else {
        [self.tableView.mj_header beginRefreshing];
    }
}

- (UIImage *)jmNavigationBarLeftButtonImage:(UIButton *)leftButton navigationBar:(JMNavigationBar *)navigationBar {
    return nil;
}

#pragma mark -tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeModel *model = self.dataArray[indexPath.row];
    if (model.isSystem) {
        NoticeSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeSystemCell"];
        cell.cellData = self.dataArray[indexPath.row];
        return cell;
    } else {
        NoticeGiftRedemptionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeGiftRedemptionCell"];
        cell.cellData = self.dataArray[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeModel *model = self.dataArray[indexPath.row];
    if (model.isSystem) {
        NoticeDetailsVC *vc = [[NoticeDetailsVC alloc] initWithStoryboard];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        GiftVC *vc = [[GiftVC alloc] initWithStoryboard];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -跳转

#pragma mark -懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
