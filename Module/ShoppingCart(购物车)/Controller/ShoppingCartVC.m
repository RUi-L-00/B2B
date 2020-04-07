//
//  ShoppingCartVC.m
//  JMBaseProject
//
//  Created by ios on 2019/12/9.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "ShoppingCartVC.h"

#import "ShoppingCartCell.h"

@interface ShoppingCartVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *returnButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *managementButton;//管理
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
//总计
@property (weak, nonatomic) IBOutlet UIView *totalView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitOrDeleteButton;//结算or删除所选
@property (weak, nonatomic) IBOutlet UIView *unGoodsView;//没商品时展示的View

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *selectArray;
@property (assign, nonatomic) BOOL isAllSelect;//是否全选
@property (assign, nonatomic) BOOL isEdit;//是否编辑状态

@end

@implementation ShoppingCartVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"ShoppingCart"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (kUseTestData) {
        [self listUpdate];
    } else {
        [self requestData];
    }
}

- (void)initControl {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 126.0;
    
    ViewRadius(self.submitOrDeleteButton, 5);
    self.returnButton.hidden = !self.isGoodsDetails;
}

- (void)initData {
//    self.dataArray = @[[[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest], [[GoodModel alloc] initWithTest]].mutableCopy;
//    [self listUpdate];
//    [self.tableView reloadData];
}

#pragma mark -Private
- (void)listUpdate {
    //更新列表时调用
    if (self.dataArray.count == 0) {
        //没有商品
        self.unGoodsView.hidden = NO;
        self.managementButton.hidden = YES;
        self.titleLabel.text = [NSString stringWithFormat:@"购物车"];
    } else {
        //有商品
        self.unGoodsView.hidden = YES;
        self.managementButton.hidden = NO;
        self.titleLabel.text = [NSString stringWithFormat:@"购物车(%lu)", (unsigned long)self.dataArray.count];
    }
}

- (void)calculationTotal {
    //计算总价
    float total = 0;
    for (GoodModel *model in self.selectArray) {
        total += (model.selectSpec.price.floatValue * model.buyCount);
    }
    self.totalLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.selectArray.count];
}

#pragma mark -tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCell"];
    cell.isSelect = self.isAllSelect;
    GoodModel *model = self.dataArray[indexPath.row];
    cell.cellData = model;
    JMWeak(self);
    cell.selectBlock = ^(BOOL isSelect) {
        if (isSelect) {
            [weakself.selectArray addObject:model];
        } else {
            [weakself.selectArray removeObject:model];
            weakself.isAllSelect = NO;
            weakself.allSelectButton.selected = NO;
        }
        if (self.isEdit) {
            [weakself.submitOrDeleteButton setTitle:[NSString stringWithFormat:@"删除所选"] forState:UIControlStateNormal];
        } else {
            [weakself.submitOrDeleteButton setTitle:[NSString stringWithFormat:@"结算(%ld)", weakself.selectArray.count] forState:UIControlStateNormal];
        }
        [self calculationTotal];
    };
    cell.pushBlock = ^{
        GoodModel *model = self.dataArray[indexPath.row];
        [weakself goGoodsDetailsVC:model];
        
    };
    cell.editBlock = ^(GoodModel * _Nonnull cellData) {
        [self requestEditGood:cellData];
    };
    cell.modifySpecBlock = ^{
        [self goSelectNormVC:model];
    };
    return cell;
}

#pragma mark -navigation
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController {
    return NO;
}

#pragma mark -Actions
- (IBAction)managementAction:(id)sender {
    //管理
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    self.isEdit = button.selected;
    if (self.isEdit) {
        self.totalView.hidden = YES;
        [self.submitOrDeleteButton setTitle:[NSString stringWithFormat:@"删除"] forState:UIControlStateNormal];
        [self.submitOrDeleteButton setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
        [self.submitOrDeleteButton setTitleColor:[UIColor colorWithHexString:@"#F16A30"] forState:UIControlStateNormal];
        ViewBorderRadius(self.submitOrDeleteButton, 5, 1, [UIColor colorWithHexString:@"#F16A30"]);
    } else {
        self.totalView.hidden = NO;
        [self.submitOrDeleteButton setTitle:[NSString stringWithFormat:@"结算(%ld)", self.selectArray.count] forState:UIControlStateNormal];
        [self.submitOrDeleteButton setBackgroundColor:[UIColor colorWithHexString:@"#F16A30"]];
        [self.submitOrDeleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ViewBorderRadius(self.submitOrDeleteButton, 5, 1, [UIColor clearColor]);
    }
}

- (IBAction)allSelectAction:(id)sender {
    //全选
    self.allSelectButton.selected = !self.allSelectButton.selected;
    self.isAllSelect = self.allSelectButton.selected;
    if (self.isAllSelect) {
        self.selectArray = [self.dataArray mutableCopy];
    } else {
        self.selectArray = [NSMutableArray array];
    }
    for (GoodModel *model in self.dataArray) {
        model.isSelect = self.isAllSelect;
    }
    [self.tableView reloadData];
    if (self.isEdit) {
        [self.submitOrDeleteButton setTitle:[NSString stringWithFormat:@"删除所选"] forState:UIControlStateNormal];
    } else {
        [self.submitOrDeleteButton setTitle:[NSString stringWithFormat:@"结算(%ld)", self.selectArray.count] forState:UIControlStateNormal];
    }
    [self calculationTotal];
}

- (IBAction)submitOrDeleteAction:(id)sender {
    //结算or删除所选
    if (self.selectArray.count != 0) {
        if (self.isEdit) {
            //编辑状态
            [self showDeleteTip];
        } else {
            //非编辑状态
            [self goConfirmOrderVC];
        }
    } else {
        [JMProgressHelper toastInWindowWithMessage:@"请先选中商品"];
    }
}

- (IBAction)returnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -跳转
- (void)goConfirmOrderVC {
    //跳转确认订单
    PayVC *payVC = [[PayVC alloc] initWithStoryboard];
    payVC.type = JMConfirmOrderType_BuyCar;
    payVC.dataArray = self.selectArray;
    [self.navigationController pushViewController:payVC animated:YES];
}

- (void)goGoodsDetailsVC:(GoodModel *)model {
    //跳转商品详情
    GoodsDetailsVC *goodsDetailsVC = [[GoodsDetailsVC alloc] initWithStoryboard];
    goodsDetailsVC.goodId = model.goodId;
    [self.navigationController pushViewController:goodsDetailsVC animated:YES];
}

- (void)goSelectNormVC:(GoodModel *)model {
    //跳转选择规格
    GoodsDetailsSelectSpecificationAlert *goodsDetailsSelectSpecificationAlert = [[GoodsDetailsSelectSpecificationAlert alloc] initWithStoryboard];
    goodsDetailsSelectSpecificationAlert.goodModel = model;
    goodsDetailsSelectSpecificationAlert.type = JMSelectNorm_Car;
    goodsDetailsSelectSpecificationAlert.selectBlock = ^(NSString * _Nonnull specStr) {
//        self.normLabel.text = specStr;
        [self.tableView reloadData];
    };
    [self presentViewController:goodsDetailsSelectSpecificationAlert animated:YES completion:nil];
}

- (void)showDeleteTip {
    //是否删除弹窗
    GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
    tipView.message = @"确认要删除勾选的商品？";
    tipView.buttonTitles = @[@"取消",@"确定"];
    tipView.buttonClickBlock = ^(NSInteger buttonIndex) {
        if(buttonIndex == 1){
           [self requestDeleteGoods];
//            for (GoodModel *model in self.selectArray) {
//                [self.dataArray removeObject:model];
//            }
//            self.selectArray = [NSMutableArray array];
//            [JMProgressHelper toastInWindowWithMessage:@"删除成功"];
//            [self listUpdate];
//            [self calculationTotal];
//            [self.tableView reloadData];
        }
    };
    [self presentViewController:tipView animated:YES completion:nil];
}

#pragma mark -网络请求
- (void)requestData {
    //请求购物车列表
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kShoppingCart_UrlPageCart parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            self.dataArray = [NSMutableArray array];
            NSArray *dataArr = response.responseObject[@"data"];
            for (NSDictionary *dic in dataArr) {
                GoodModel *model = [[GoodModel alloc] initWithBuyCarDic:dic];
                model.isSelect = self.isAllSelect;
                [self.dataArray addObject:model];
            }
            if (!self.isEdit) {
                [self.submitOrDeleteButton setTitle:[NSString stringWithFormat:@"结算(%ld)", self.selectArray.count] forState:UIControlStateNormal];
            }
            [self listUpdate];
            [self calculationTotal];
            [self.tableView reloadData];
        }
    }];
}

- (void)requestDeleteGoods {
    //删除商品
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    NSString *goodIds = @"";
    for (int i = 0; i < self.selectArray.count; i++) {
        if (i == 0) {
            GoodModel *model = self.selectArray[i];
            goodIds = model.goodsCartId;
        } else {
            GoodModel *model = self.selectArray[i];
            goodIds = [NSString stringWithFormat:@"%@|%@", goodIds, model.goodsCartId];
        }
    }
    params[@"goodsCardIds"] = goodIds;
    [[JMRequestManager sharedManager] POST:kShoppingCart_UrlDelCart parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self requestData];
            [self.tableView reloadData];
        }
    }];
}

- (void)requestEditGood:(GoodModel *)model {
    //编辑购物车商品数量
    [self showLoading];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    params[@"cartId"] = model.goodId;
    params[@"num"] = @(model.buyCount);
    params[@"skuId"] = model.selectSpec.selectSpecId;
    [[JMRequestManager sharedManager] POST:kShoppingCart_UrlEditCart parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self calculationTotal];
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

- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}

@end
