//
//  AddresssVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressVC.h"
#import "AddressAddOrEditVC.h"

#import "AddressManageCell.h"

@interface AddressVC () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableData;

@end

@implementation AddressVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Address"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(requestAddressList) name:kAddress_NotificationUpdataList object:nil];
}

-(void)initControl{
    self.title = @"选择地址";
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 130;
}

-(void)initData{
    [self requestAddressList];
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressManageCell"];
    AddressModel *model = self.tableData[indexPath.row];
    cell.cellData = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressModel *address = self.tableData[indexPath.row];
    [self requestAddressSetDefault:address];

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Actions
- (IBAction)addAddressAction:(id)sender {
    //添加
    [self goAddAddressVC];
}

#pragma mark - 跳转
-(void)goAddAddressVC{
    //跳转添加地址VC
    AddressAddOrEditVC *addAddressVC = [[AddressAddOrEditVC alloc] initWithStoryboard];
    BOOL isDefault = NO;
    if(self.tableData.count == 0){
        isDefault = YES;
    }
    addAddressVC.isDefaultAdd = isDefault;
    [self.navigationController pushViewController:addAddressVC animated:YES];
}

#pragma mark - 网络
-(void)requestAddressList{
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
            self.tableData = array;
            [self.tableView reloadData];
        }
    }];
}

-(void)requestAddressSetDefault:(AddressModel *)address{
    //把地址设置为默认地址
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:address.addressId key:@"id"];
    [params setJsonValue:@"1" key:@"isChoice"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kAddress_UrlEditAddress parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            [self requestAddressList];
        }
    }];
}

@end
