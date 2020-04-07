//
//  AddressSelectVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressSelectVC.h"
#import "AddressAddOrEditVC.h"

#import "AddressSelectCell.h"

@interface AddressSelectVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) AddressModel *selectAddress;

@end

@implementation AddressSelectVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Address"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestAddressList];
}

- (void)initControl {
    self.title = @"选择地址";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
}

#pragma mark -tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressSelectCell"];
    cell.cellData = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectAddress = self.dataArray[indexPath.row];
    if (self.selectAddressBlock) {
        self.selectAddressBlock(self.selectAddress);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -网络请求
- (void)requestAddressList {
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kAddress_UrlAddressList parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSArray *dataArray = response.responseObject[@"data"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for(NSDictionary *dic in dataArray){
                AddressModel *model = [[AddressModel alloc] initWithDictionary:dic];
                [array addObject:model];
            }
            self.dataArray = array;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Actions
- (IBAction)addAddressAction:(id)sender {
    //添加
    [self goAddAddressVC];
}

#pragma mark - 跳转
-(void)goAddAddressVC{
    AddressAddOrEditVC *addressAddOrEditVC = [[AddressAddOrEditVC alloc] initWithStoryboard];
    BOOL isDefault = NO;
    if(self.dataArray.count == 0){
        isDefault = YES;
    }
    addressAddOrEditVC.isDefaultAdd = isDefault;
    [self.navigationController pushViewController:addressAddOrEditVC animated:YES];
}

#pragma mark -懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
