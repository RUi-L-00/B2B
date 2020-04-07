//
//  PayVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PayVC.h"
#import "PayResultVC.h"
#import "PaySelectSalesVC.h"
#import "PaySetAddressAlert.h"

#import "PaySelectSalesModel.h"

@interface PayVC () <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;//总计
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *salesNameLabel;//销售人员

@property (strong, nonatomic) AddressModel *selectAddress;//选择的地址
@property (copy, nonatomic) NSString *orderId;//订单ID
@property (copy, nonatomic) NSString *orderNo;//订单号
@property (strong, nonatomic) PaySelectSalesModel *selectModel;

@end

@implementation PayVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Pay"];
}

- (void)initControl {
    self.title = @"确认订单";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 120.0;
    self.tableView.tableFooterView.height = 200.0;
    
    self.textView.delegate = self;
}

- (void)initData {
    self.totalLabel.text = [NSString stringWithFormat:@"%ld", self.dataArray.count];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*)text
{
    [super textView:textView shouldChangeTextInRange:range replacementText:text];
    //这个判断相当于是textfield中的点击return的代理方法
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    //在输入过程中 判断加上输入的字符 是否超过限定字数
    NSString *str = [NSString stringWithFormat:@"%@%@", textView.text, text];
    if (str.length > 30)
    {
        NSInteger index = 30 - textView.text.length;
        if (index>=0) {
            NSString * string = [NSString stringWithFormat:@"%@%@",textView.text,[text substringToIndex:index]];
            textView.text = string;
        }
        return NO;
    }
  
    return YES;
}

#pragma mark -tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    GoodModel *model = self.dataArray[indexPath.row];
    cell.cellData = model;
    return cell;
}

#pragma mark -Actions
- (IBAction)submitAction:(id)sender {
    //提交订单
//    [self requestBuyCarOrder];
    PayResultVC *payResultVC = [[PayResultVC alloc] initWithStoryboard];
    payResultVC.hidesBottomBarWhenPushed = YES;
    UIViewController *rootVC = self.navigationController.viewControllers.firstObject;
    NSMutableArray *tempMarr = [NSMutableArray array];
    [tempMarr insertObject:rootVC atIndex:tempMarr.count];
    [tempMarr insertObject:payResultVC atIndex:tempMarr.count];
    [rootVC.navigationController setViewControllers:tempMarr animated:YES];
}

- (IBAction)salesAction:(id)sender {
    //销售人员
    PaySelectSalesVC *vc = [[PaySelectSalesVC alloc] initWithStoryboard];
    vc.selectBlock = ^(PaySelectSalesModel * _Nonnull model) {
        self.selectModel = model;
        self.salesNameLabel.text = model.salesName;
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark -跳转
- (void)goPaymentResultVCWithOrderId:(NSString *)orderId total:(NSString *)total {
    //跳转支付结果
    PayResultVC *payResultVC = [[PayResultVC alloc] initWithStoryboard];
    payResultVC.orderId = orderId;
    payResultVC.total = total;
    [self.navigationController pushViewController:payResultVC animated:YES];
}

#pragma mark -网络请求
- (void)requestBuyCarOrder {
    //创建购物车购买订单
    [self showLoading];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    params[@"addressId"] = self.selectAddress.addressId;
    params[@"remark"] = self.textView.text;
    NSString *goods = @"";
    for (int i = 0; i < self.dataArray.count; i++) {
        GoodModel *model = self.dataArray[i];
        if (i == 0) {
            goods = model.goodId;
        } else {
            goods = [NSString stringWithFormat:@"%@,%@", goods, model.goodId];
        }
    }
    params[@"cartIds"] = goods;
    [[JMRequestManager sharedManager] POST:kPay_UrlShoppingCartOrder parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            NSDictionary *dataDic = response.responseObject[@"data"];
            self.orderId = [dataDic getJsonValue:@"id"];
            self.orderNo = [dataDic getJsonValue:@"orderNo"];
            PayResultVC *payResultVC = [[PayResultVC alloc] initWithStoryboard];
            payResultVC.hidesBottomBarWhenPushed = YES;
            payResultVC.hidesBottomBarWhenPushed = YES;
            UIViewController *rootVC = self.navigationController.viewControllers.firstObject;
            NSMutableArray *tempMarr = [NSMutableArray array];
            [tempMarr insertObject:rootVC atIndex:tempMarr.count];
            [tempMarr insertObject:payResultVC atIndex:tempMarr.count];
            [rootVC.navigationController setViewControllers:tempMarr animated:YES];
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
