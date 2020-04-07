//
//  OrderDetailsVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "OrderDetailsVC.h"
#import "OrderCell.h"
@interface OrderDetailsVC ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@end

@implementation OrderDetailsVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Order"];
}

- (void)initControl {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"订单详情";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
}

-(void)initData{
    if (kUseTestData) {
           self.tableData = [[NSMutableArray alloc] init];
           OrderModel *order = [[OrderModel alloc] initWithTest];
           [self.tableData addObject:order];
           [self.tableView reloadData];
    }
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    OrderModel *order = self.tableData[section];
    return order.goods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    OrderModel *order = self.tableData[indexPath.section];
    cell.cellData = order.goods[indexPath.row];
    return cell;
}
@end
