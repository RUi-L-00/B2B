//
//  OrderListVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderListVC.h"

#import "OrderCell.h"

@interface OrderListVC () <UITableViewDataSource, UITableViewDelegate, OrderCellDelegate>

@property (weak, nonatomic) IBOutlet UIView *noDataView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) JMRefreshTool *refreshTool;

@end

@implementation OrderListVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Order"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (kUseTestData == NO) {
        [self requestOrderList];
    }
}

- (void)initControl {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的订单";
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    UINib *header = [UINib nibWithNibName:@"OrderHeaderView" bundle:nil];
    [self.tableView registerNib:header forHeaderFooterViewReuseIdentifier:@"OrderHeaderView"];
    UINib *footer = [UINib nibWithNibName:@"OrderFooterView" bundle:nil];
    [self.tableView registerNib:footer forHeaderFooterViewReuseIdentifier:@"OrderFooterView"];
}

- (void)initData {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestOrderList) name:kOrder_NotificationOrderRefresh object:nil];
    if (kUseTestData) {
        self.tableData = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            OrderModel *order = [[OrderModel alloc] initWithTest];
            switch (self.type) {
                case JMOrderType_WaitPay:
                    //待付款
                    order.state = JMOrderState_WaitPay;
                    break;
                    
                case JMOrderType_WaitShenHe:
                    //待审核
                    order.state = JMOrderState_WaitShenHe;
                    break;
                    
                case JMOrderType_WaitFaHuo:
                    //待发货
                    order.state = JMOrderState_WaitFaHuo;
                    break;
                case JMOrderType_WaitShouHuo:
                    //待收货
                    order.state = JMOrderState_WaitShouHuo;
                    break;
                    
                default:
                    break;
            }
            [self.tableData addObject:order];
        }
        [self.tableView reloadData];
    }else{
        [self requestOrderList];
    }
}

- (void)checkDataEmpty {
    if (self.tableData.count == 0) {
        self.tableView.hidden = YES;
        self.noDataView.hidden = NO;
    } else {
        self.tableView.hidden = NO;
        self.noDataView.hidden = YES;
    }
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableData.count;
}

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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    OrderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderFooterView"];
    footer.footerData = self.tableData[section];
    footer.index = section;
    footer.delegate = self;
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderHeaderView"];
    header.headerData = self.tableData[section];
    header.index = section;
    header.delegate = self;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *order = self.tableData[indexPath.section];
    [self goDetailVC:order];
}

#pragma mark - OrderCellDelegate
- (void)clickOperationButton:(NSInteger)index title:(NSString *)buttonTitle {
    if ([buttonTitle isEqualToString:@"付款"]) {
        [self payOrder:index];
    } else if ([buttonTitle isEqualToString:@"申请退款"]) {
        [self refundOrder:index];
    } else if ([buttonTitle isEqualToString:@"确认收货"]) {
        [self confirmShouHuo:index];
    } else if ([buttonTitle isEqualToString:@"删除订单"]) {
        [self deleteOrder:index];
    } else if ([buttonTitle isEqualToString:@"查看凭证"]) {
        OrderModel *order = self.tableData[index];
        [self goReviewImage:order];
    } else if ([buttonTitle isEqualToString:@"删除订单"]) {
        [self cancelPayment:index];
    } else if ([buttonTitle isEqualToString:@"重新上传"]) {
        [self payOrder:index];
    } else if ([buttonTitle isEqualToString:@"申请售后"]) {
        [self goRefundCompleteVC:index];
    }
}

- (void)didTap:(NSInteger)index {
    //跳转到订单详情
    OrderModel *order = self.tableData[index];
    [self goDetailVC:order];
}

- (void)deleteOrder:(NSInteger)index {
    //删除订单
    GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
    tipView.message = @"确定要删除订单？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    tipView.buttonClickBlock = ^(NSInteger buttonIndex) {
        if(buttonIndex == 1){
//            [self requestDeleteOrder:index];
            [self.tableData removeObjectAtIndex:index];
            [self.tableView reloadData];
            [JMProgressHelper toastInWindowWithMessage:@"删除成功"];
        }
    };
    [self presentViewController:tipView animated:YES completion:nil];
}

- (void)cancelPayment:(NSInteger)index {
    //取消订单
    GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
    tipView.message = @"是否取消订单？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    tipView.buttonClickBlock = ^(NSInteger buttonIndex) {
        if(buttonIndex == 1){
            [self requestCancelOrder:index];
        }
    };
    [self presentViewController:tipView animated:YES completion:nil];
}

- (void)confirmShouHuo:(NSInteger)index {
    OrderModel *order = self.tableData[index];
    for (GoodModel *good in order.goods) {
        if (good.aftersaleState == JMGoodState_TuiHuoTuiKuan || good.aftersaleState == JMGoodState_TuiKuan) {
            GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
            tipView.message = @"该订单商品售后中，请等带售后结束后再进行收货";
            tipView.buttonTitles = @[@"确定"];
            [self presentViewController:tipView animated:YES completion:nil];
            return;
        }
    }
    GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
    tipView.message = @"确认收货之后将不能进行退款/退货，是否确认收货？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    tipView.buttonClickBlock = ^(NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            [self requestConfirmShouHuo:index];
        }
    };
    [self presentViewController:tipView animated:YES completion:nil];
}

- (void)refundOrder:(NSInteger)index {
    OrderModel *order = self.tableData[index];
    for (GoodModel *good in order.goods) {
        if (good.aftersaleState == JMGoodState_Normal || good.aftersaleState == JMGoodState_CloseAfterSale) {
            GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
            tipView.message = @"是否申请退款？";
            tipView.buttonTitles = @[@"取消",@"确定"];
            tipView.buttonClickBlock = ^(NSInteger buttonIndex) {
                if(buttonIndex == 1){
                    if(order.state == JMOrderState_WaitFaHuo){
                        [self goRefundVC:order];
                    }else if(order.state == JMOrderState_WaitShouHuo){
                        [self goSelectGoodRefundVC:order];
                    }
                }
            };
            [self presentViewController:tipView animated:YES completion:nil];
            return;
        }
    }
    GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
    tipView.message = @"您已提交过售后申请，无法再次提交";
    tipView.buttonTitles = @[@"确定"];
    [self presentViewController:tipView animated:YES completion:nil];
}

- (void)payOrder:(NSInteger)index {
    OrderModel *order = self.tableData[index];
    [self goPayVC:order];
}
#pragma mark - 跳转
- (void)goDetailVC:(OrderModel *)order {
    OrderDetailsVC *detailVC = [[OrderDetailsVC alloc] initWithStoryboard];
//    detailVC.orderId = order.orderId;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)goReviewImage:(OrderModel *)model {
//    YBImageBrowser *browser = [YBImageBrowser new];
//    YBIBImageData *data = [YBIBImageData new];
//    data.imageURL = [NSURL URLWithString:JMImageUrl(model.reviewImage)];
//    browser.dataSourceArray = @[data];
//    browser.currentPage     = 1;
//    [browser show];
}

- (void)goSelectGoodRefundVC:(OrderModel *)order {
    //前往退货列表
//    AfterSaleSelectProductVC *afterSaleSelectProductVC = [[AfterSaleSelectProductVC alloc] initWithStoryboard];
//    afterSaleSelectProductVC.order = order;
//    [self.navigationController pushViewController:afterSaleSelectProductVC animated:YES];
}

- (void)goRefundVC:(OrderModel *)order {
    //仅退款
//    AfterSaleOnlyRefundVC *afterSaleOnlyRefundVC = [[AfterSaleOnlyRefundVC alloc] initWithStoryboard];
//    afterSaleOnlyRefundVC.order = order;
//    [self.navigationController pushViewController:afterSaleOnlyRefundVC animated:YES];
}

- (void)goRefundAndGoodVC:(OrderModel *)order {
    //退货退款
//    AfterSaleRefundsVC *afterSaleRefundsVC = [[AfterSaleRefundsVC alloc] initWithStoryboard];
//    afterSaleRefundsVC.order = order;
//    [self.navigationController pushViewController:afterSaleRefundsVC animated:YES];
}

- (void)goPayVC:(OrderModel *)order {
    //上传支付凭证
//    PayUploadCertificateAlert *payUploadCertificateAlert = [[PayUploadCertificateAlert alloc] initWithStoryboard];
//    JMWeak(self);
//    payUploadCertificateAlert.orderId = order.orderNo;
//    payUploadCertificateAlert.total = order.totalPay.floatValue;
//    payUploadCertificateAlert.successBlock = ^{
//        [weakself goPaymentResultVC:order];
//    };
//    [self presentViewController:payUploadCertificateAlert animated:YES completion:nil];
}

- (void)goPaymentResultVC:(OrderModel *)order {
    //跳转支付结果
//    PayResultVC *payResultVC = [[PayResultVC alloc] initWithStoryboard];
//    payResultVC.total = order.totalPay;
//    payResultVC.orderId = order.orderId;
//    [self.navigationController pushViewController:payResultVC animated:YES];
}

- (void)goRefundCompleteVC:(NSInteger)index {
    //申请售后
//    AfterSaleExchangeVC *afterSaleExchangeVC = [[AfterSaleExchangeVC alloc] initWithStoryboard];
//    afterSaleExchangeVC.order = self.tableData[index];
//    [self.navigationController pushViewController:afterSaleExchangeVC animated:YES];
}

#pragma mark - 网络
- (void)requestOrderList {
    //订单列表
    if(self.refreshTool == nil){
        JMWeak(self);
        self.refreshTool = [[JMRefreshTool alloc] initWithScrollView:self.tableView dataAnalysisBlock:^NSArray *(NSDictionary *responseData) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            NSDictionary *dataDic = responseData[@"data"];
            NSArray *listArray = dataDic[@"list"];
            for(NSDictionary *dic in listArray){
                OrderModel *model = [[OrderModel alloc] initWithOrderListDictionary:dic];
                [array addObject:model];
            }
            if([weakself.refreshTool isAddData] == YES){
                [weakself.tableData addObjectsFromArray:array];
            }else{
                weakself.tableData = array;
            }
            [weakself.tableView reloadData];
            return array;
        }];
        self.refreshTool.requestUrl = kOrder_UrlOrderList;
        NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
        NSString *state = [NSString stringWithFormat:@"%ld",self.type];
        [params setJsonValue:state key:@"state"];
        self.refreshTool.requestParams = params;
    }
    [self.refreshTool loadMore:NO];
}

-(void)requestDeleteOrder:(NSInteger)index{
    //删除订单
    OrderModel *order = self.tableData[index];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:order.orderId key:@"orderId"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kOrder_UrlDeleteOrder parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self.tableData removeObjectAtIndex:index];
            [self.tableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:kOrder_NotificationOrderRefresh object:nil];
        }
    }];
}

-(void)requestConfirmShouHuo:(NSInteger)index{
    //确认收货
    OrderModel *order = self.tableData[index];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:order.orderId key:@"orderId"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kOrder_UrlConfirmReceipt parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:kOrder_NotificationOrderRefresh object:nil];
            [self didTap:index];
        }
    }];
}

-(void)requestCancelOrder:(NSInteger)index{
    //取消订单
    OrderModel *order = self.tableData[index];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:order.orderId key:@"orderId"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kOrder_UrlCancelOrder parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:kOrder_NotificationOrderRefresh object:nil];
        }
    }];
}

@end
