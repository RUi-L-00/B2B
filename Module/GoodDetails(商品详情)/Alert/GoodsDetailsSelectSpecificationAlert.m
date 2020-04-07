//
//  GoodsDetailsSelectSpecificationAlert.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodsDetailsSelectSpecificationAlert.h"

#import "GoodsDetailsPatternCell.h"

@interface GoodsDetailsSelectSpecificationAlert () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *goodImage;//商品图片
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//商品价格
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *countView;
@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;//数量
@property (weak, nonatomic) IBOutlet UIButton *addButton;//+++
@property (weak, nonatomic) IBOutlet UIButton *lessButton;//---
@property (weak, nonatomic) IBOutlet UIButton *addCarButton;//加入购物车

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *specDic;//选中的规格
@property (strong, nonatomic) NSMutableArray *selectSpecArray;//选择的规格数组

@end

@implementation GoodsDetailsSelectSpecificationAlert

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"GoodsDetails"];
}

- (void)initControl {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;

    self.specDic = [NSMutableDictionary dictionary];
    
    [self.quantityTextField addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventValueChanged];
    
    self.quantityTextField.delegate = self;
    
    switch (self.type) {
        case JMSelectNorm_Details:
            //商品详情
            self.countView.hidden = NO;
            break;
            
        case JMSelectNorm_Car:
            //商品详情
            self.countView.hidden = YES;
            break;
            
        default:
            break;
    }
}

- (void)initData {
    if (kUseTestData) {
        self.goodImage.image = [UIImage imageNamed:self.goodModel.coverImage];
    } else {
        if (self.type == JMSelectNorm_Car) {
            [self requestData];
        } else {
            [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[JMCommonMethod pinImagePath:self.goodModel.coverImage]]];
        }
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@", self.goodModel.name];
    self.dataArray = [self.goodModel.goodSpecArray mutableCopy];
    [self.tableView reloadData];
}

#pragma mark -Private
- (void)updateSelectSpec {
    //更新选中规格
    NSMutableArray *textArray = [[NSMutableArray alloc] init];
    for (GoodSpecModel *specModel in self.dataArray) {
        for (SpecItemModel *itemModel in specModel.normArray) {
            if (itemModel.isSelect) {
                [textArray addObject:itemModel.normName];
            }
        }
    }
    
    NSString *specName = [textArray componentsJoinedByString:@","];
    //更新选中规格
    for(SelectSpecModel *spec in self.goodModel.productSpecificationsArray){
        if([spec.selectSpecCode isEqualToString:specName]){
            self.goodModel.selectSpec = spec;
            self.nameLabel.text = [NSString stringWithFormat:@"%@", self.goodModel.name];
            [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[JMCommonMethod pinImagePath:self.goodModel.selectSpec.selectSpecImage]]];
            break;
        }
    }
    self.goodModel.buyCount = self.quantityTextField.text.integerValue;
}

#pragma mark -textField
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self textFieldChange];
}

#pragma mark -tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDetailsPatternCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsDetailsPatternCell"];
    GoodSpecModel *model = self.dataArray[indexPath.row];
    cell.cellData = model;
    JMWeak(self);
    cell.selectSpecBlock = ^(NSInteger collectionRow) {
        NSString *key = [NSString stringWithFormat:@"%ld", indexPath.row];
        SpecItemModel *specModel = model.normArray[collectionRow];
        weakself.specDic[key] = specModel.normName;
        if (self.specDic.allKeys.count == self.dataArray.count) {
            [self updateSelectSpec];
        }
    };
    return cell;
}

#pragma mark -Actions
- (IBAction)offAction:(id)sender {
    //关闭按钮
    if (self.selectBlock) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSString *name = @"";
        NSArray *specGroup = self.goodModel.goodSpecArray;
        for(GoodSpecModel *group in specGroup){
            NSArray *items = group.normArray;
            SpecItemModel *selectModel;
            for(SpecItemModel *model in items){
                if(model.isSelect == YES){
                    selectModel = model;
                    name = [name stringByAppendingFormat:@" %@", model.normName];
                }
            }
            if(selectModel == nil){
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                return;
            } else{
                [array addObject:selectModel];
            }
        }
        self.selectSpecArray = array.copy;
        [self updateSelectSpec];
        self.selectBlock(name);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)lessAction:(id)sender {
    //---
    self.quantityTextField.text = [NSString stringWithFormat:@"%ld", self.quantityTextField.text.integerValue - 1];
    [self textFieldChange];
}

- (IBAction)addAction:(id)sender {
    //+++
    self.quantityTextField.text = [NSString stringWithFormat:@"%ld", self.quantityTextField.text.integerValue + 1];
    [self textFieldChange];
}

- (void)textFieldChange {
    //文本框内容变化时执行
    if (self.quantityTextField.text.integerValue <= 1) {
        self.quantityTextField.text = @"1";
        self.lessButton.enabled = NO;
    } else {
        self.lessButton.enabled = YES;
    }
}

- (IBAction)addCarAction:(id)sender {
    //加入购物车
    if (kUseTestData) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
//        [self requestAddCar];
        [self requestGetPrice];
    }
}

#pragma mark -网络请求
- (void)requestData {
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    params[@"goodsId"] = self.goodModel.goodId;
    [[JMRequestManager sharedManager] POST:kGoodsDetails_UrlGoodsDetails parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            NSDictionary *dataDic = response.responseObject[@"data"];
            self.goodModel = [[GoodModel alloc] initWithDetailsDic:dataDic];
            [self.goodImage sd_setImageWithURL:[NSURL URLWithString:[JMCommonMethod pinImagePath:self.goodModel.coverImage]]];
            self.nameLabel.text = [NSString stringWithFormat:@"%@", self.goodModel.name];
            self.dataArray = [self.goodModel.goodSpecArray mutableCopy];
            [self.tableView reloadData];
        }
    }];
}

- (void)requestGetPrice {
//    kGoodsDetails_UrlGetPrice
    //获取价格和规格的ID
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSString *name = @"";
    NSString *specAttrIds = @"";
    NSArray *specGroup = self.goodModel.goodSpecArray;
    for(GoodSpecModel *group in specGroup){
        NSArray *items = group.normArray;
        SpecItemModel *selectModel;
        for(SpecItemModel *model in items){
            if(model.isSelect == YES){
                selectModel = model;
                name = [name stringByAppendingFormat:@" %@", model.normName];
                specAttrIds = [specAttrIds stringByAppendingFormat:@"%@|", model.normId];
            }
        }
        if(selectModel == nil){
            NSString *message = [NSString stringWithFormat:@"请选择%@",group.patternName];
            [JMProgressHelper toastInWindowWithMessage:message];
            return;
        }
        else{
            [array addObject:selectModel];
        }
    }
    self.selectSpecArray = array.copy;
    [self updateSelectSpec];
    self.selectBlock(name);
    specAttrIds = [specAttrIds substringToIndex:specAttrIds.length - 1];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    params[@"goodsId"] = self.goodModel.goodId;
    params[@"specAttrIds"] = specAttrIds;
    [[JMRequestManager sharedManager] POST:kGoodsDetails_UrlGetPrice parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            NSDictionary *dataDic = response.responseObject[@"data"];
            NSString *goodsModelsSpecAttributePriceId = [dataDic getJsonValue:@"goodsModelsSpecAttributePriceId"];
            [self requestAddCar:goodsModelsSpecAttributePriceId];
        }
    }];
}

- (void)requestAddCar:(NSString *)goodsModelsSpecAttributePriceId {
    //加入购物车
    if (self.selectBlock) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSString *name = @"";
        NSArray *specGroup = self.goodModel.goodSpecArray;
        for(GoodSpecModel *group in specGroup){
            NSArray *items = group.normArray;
            SpecItemModel *selectModel;
            for(SpecItemModel *model in items){
                if(model.isSelect == YES){
                    selectModel = model;
                    name = [name stringByAppendingFormat:@" %@", model.normName];
                }
            }
            if(selectModel == nil){
                NSString *message = [NSString stringWithFormat:@"请选择%@",group.patternName];
                [JMProgressHelper toastInWindowWithMessage:message];
                return;
            }
            else{
                [array addObject:selectModel];
            }
        }
        self.selectSpecArray = array.copy;
        [self updateSelectSpec];
        self.selectBlock(name);
    }
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    params[@"goodsId"] = self.goodModel.goodId;
    params[@"skuId"] = self.goodModel.selectSpec.selectSpecId;
    params[@"num"] = @(self.goodModel.buyCount);
    params[@"type"] = @"0";
    params[@"goodsModelsSpecAttributePriceId"] = goodsModelsSpecAttributePriceId;
    [[JMRequestManager sharedManager] POST:kGoodsDetails_UrlAddCar parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            //加入成功
            [self dismissViewControllerAnimated:YES completion:^{
                [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            }];
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

- (NSMutableArray *)selectSpecArray {
    if (!_selectSpecArray) {
        _selectSpecArray = [NSMutableArray array];
    }
    return _selectSpecArray;
}

@end
