//
//  PaySelectSalesVC.m
//  JMBaseProject
//
//  Created by ios on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "PaySelectSalesVC.h"

#import "PaySelectSalesCell.h"

#import "PaySelectSalesModel.h"

@interface PaySelectSalesVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) PaySelectSalesModel *selectModel;

@end

@implementation PaySelectSalesVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Pay"];
}

- (void)initControl {
    self.title = @"选择销售人员";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 56;
}

- (void)initData {
    self.dataArray = @[[[PaySelectSalesModel alloc] initWithTest], [[PaySelectSalesModel alloc] initWithTest], [[PaySelectSalesModel alloc] initWithTest], [[PaySelectSalesModel alloc] initWithTest], [[PaySelectSalesModel alloc] initWithTest]].mutableCopy;
    [self.tableView reloadData];
}

#pragma mark -tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaySelectSalesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaySelectSalesCell"];
    cell.cellData = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    for (PaySelectSalesModel *model in self.dataArray) {
        model.isSelect = NO;
    }
    PaySelectSalesModel *model = self.dataArray[indexPath.row];
    model.isSelect = YES;
    self.selectModel = model;
    [self.tableView reloadData];
}

#pragma mark -Action
- (IBAction)defineAction:(id)sender {
    //确定
    if (self.selectBlock) {
        self.selectBlock(self.selectModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
