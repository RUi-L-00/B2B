
//
//  AddressSelectCityAlert.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressSelectCityAlert.h"

#import "AddressCityCell.h"

#import "AddressCityModel.h"

@interface AddressSelectCityAlert ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *shengButton;
@property (weak, nonatomic) IBOutlet UIButton *shiButton;
@property (weak, nonatomic) IBOutlet UIButton *quButton;
@property (strong, nonatomic) IBOutlet UIView *cityTitleView;

@property (strong, nonatomic) UIView *selectFlagView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (strong, nonatomic) NSMutableArray *shengArray;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) AddressCityModel *selectSheng;
@property (strong, nonatomic) AddressCityModel *selectShi;
@property (strong, nonatomic) AddressCityModel *selectQu;

@end

@implementation AddressSelectCityAlert

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Address"];
}

-(void)initControl{
    //初始化选中线条
    self.selectFlagView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, 40, 2)];
    self.selectFlagView.backgroundColor = kColorCityTintColor;
    self.selectFlagView.centerX = self.shengButton.superview.centerX;
    [self.cityTitleView addSubview:self.selectFlagView];
    if(self.shengButton.selected){
        self.selectFlagView.centerX = self.shengButton.superview.centerX;
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 36.0;
}

-(void)initData{
    [self requestShengList];
}

#pragma mark - Set
-(void)setSelectSheng:(AddressCityModel *)selectSheng{
    if(self.selectSheng){
        self.selectSheng.isSelect = NO;
    }
    _selectSheng = selectSheng;
    if(self.selectSheng){
        self.selectSheng.isSelect = YES;
        [self.shengButton setTitle:self.selectSheng.cityName forState:UIControlStateNormal];
    }else{
        [self.shengButton setTitle:@"省份" forState:UIControlStateNormal];
    }
    self.selectShi=nil;
}

-(void)setSelectShi:(AddressCityModel *)selectShi{
    if(self.selectShi){
        self.selectShi.isSelect = NO;
    }
    _selectShi = selectShi;
    if(self.selectShi){
        self.selectShi.isSelect = YES;
        [self.shiButton setTitle:self.selectShi.cityName forState:UIControlStateNormal];
    }else{
        [self.shiButton setTitle:@"城市" forState:UIControlStateNormal];
    }
    self.selectQu = nil;
}

-(void)setSelectQu:(AddressCityModel *)selectQu{
    if(self.selectQu){
        self.selectQu.isSelect = NO;
    }
    _selectQu = selectQu;
    if(self.selectQu){
        self.selectQu.isSelect = YES;
        [self.quButton setTitle:self.selectQu.cityName forState:UIControlStateNormal];
    }else{
        [self.quButton setTitle:@"地区" forState:UIControlStateNormal];
    }
    [self.view layoutIfNeeded];
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCityCell"];
    AddressCityModel *model = self.tableData[indexPath.row];
    [cell updateWithTitle:model.cityName isSelect:model.isSelect];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCityModel *city = self.tableData[indexPath.row];
    if(self.shengButton.isSelected){
        self.selectSheng = city;
        [self requestShiListWithId:self.selectSheng.cityId];
    }else if(self.shiButton.isSelected){
        self.selectShi = city;
        [self requestQuListWithId:self.selectShi.cityId];
    }else if(self.quButton.isSelected){
        self.selectQu = city;
        [UIView animateWithDuration:0.3 animations:^{
            self.selectFlagView.mj_w = self.quButton.mj_w + 10;
            self.selectFlagView.centerX = self.quButton.superview.centerX;
        }];
        [self.tableView reloadData];
    }
}

#pragma mark - Actions
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)okAction:(id)sender {
    if(self.selectSheng == nil || self.selectShi == nil || self.selectQu == nil){
        [JMProgressHelper toastInWindowWithMessage:@"请选择省市区"];
        return;
    }
    if(self.buttonClickBlock){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setJsonValue:self.selectSheng.cityName key:@"shengName"];
        [params setJsonValue:self.selectShi.cityName key:@"shiName"];
        [params setJsonValue:self.selectQu.cityName key:@"quName"];
        [params setJsonValue:self.selectQu.cityId key:@"areaId"];
        params[@"shengId"] = self.selectSheng.cityId;
        params[@"shiId"] = self.selectShi.cityId;
        params[@"quId"] = self.selectQu.cityId;
        NSString *showText = [NSString stringWithFormat:@"%@-%@-%@",self.selectSheng.cityName,self.selectShi.cityName,self.selectQu.cityName];
        [params setJsonValue:showText key:@"showText"];
        self.buttonClickBlock(params);
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)shengAction:(id)sender {
    //省
    self.tableData = self.shengArray;
    self.shengButton.selected = YES;
    self.shiButton.selected = NO;
    self.quButton.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.selectFlagView.mj_w = self.shengButton.mj_w + 10;
        self.selectFlagView.centerX = self.shengButton.superview.centerX;
    }];
    [self.tableView reloadData];
}
- (IBAction)shiAction:(id)sender {
    //市
    if(self.selectSheng == nil){
        [JMProgressHelper toastInWindowWithMessage:@"请先选择省份"];
    }else{
        [self requestShiListWithId:self.selectSheng.cityId];
    }
}
- (IBAction)quAction:(id)sender {
    //区
    if(self.selectSheng == nil || self.selectShi == nil){
        [JMProgressHelper toastInWindowWithMessage:@"请先选择省市"];
    }else{
        [self requestQuListWithId:self.selectShi.cityId];
    }
}

#pragma mark - 网络
-(void)requestShengList{
    [[JMRequestManager sharedManager] POST:kAddress_UrlAddressSheng parameters:nil completion:^(JMBaseResponse *response) {
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            NSArray *dataArray = response.responseObject[@"data"];
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for(NSDictionary *dic in dataArray){
                AddressCityModel *model = [[AddressCityModel alloc] init];
                model.cityId = [dic getJsonValue:@"id"];
                model.cityName = [dic getJsonValue:@"name"];
                model.isSelect = NO;
                [array addObject:model];
            }
            self.shengArray = array;
            self.tableData = self.shengArray;
            [self.tableView reloadData];
        }
    }];
}

-(void)requestShiListWithId:(NSString *)shengId{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:shengId key:@"parentId"];
    [[JMRequestManager sharedManager] POST:kAddress_UrlAddressShi parameters:params completion:^(JMBaseResponse *response) {
        NSArray *dataArray = response.responseObject[@"data"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in dataArray){
            AddressCityModel *model = [[AddressCityModel alloc] init];
            model.cityId = [dic getJsonValue:@"id"];
            model.cityName = [dic getJsonValue:@"name"];
            if([self.selectShi.cityId isEqualToString:model.cityId]){
                model.isSelect = YES;
            }else{
                model.isSelect = NO;
            }
            [array addObject:model];
        }
        self.tableData = array;
        self.shengButton.selected = NO;
        self.quButton.selected = NO;
        self.shiButton.selected = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.selectFlagView.mj_w = self.shiButton.mj_w + 10;
            self.selectFlagView.centerX = self.shiButton.superview.centerX;
        }];

        [self.tableView reloadData];
        //table回到顶部
        [self.tableView beginUpdates];
        self.tableView.contentOffset = CGPointZero;
        [self.tableView endUpdates];
    }];
}

-(void)requestQuListWithId:(NSString *)shiId{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:shiId key:@"parentId"];
    [[JMRequestManager sharedManager] POST:kAddress_UrlAddressQu parameters:params completion:^(JMBaseResponse *response) {
        NSArray *dataArray = response.responseObject[@"data"];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in dataArray){
            AddressCityModel *model = [[AddressCityModel alloc] init];
            model.cityId = [dic getJsonValue:@"id"];
            model.cityName = [dic getJsonValue:@"name"];
            if([self.selectQu.cityId isEqualToString:model.cityId]){
                model.isSelect = YES;
            }else{
                model.isSelect = NO;
            }
            [array addObject:model];
        }
        self.tableData = array;
        self.shengButton.selected = NO;
        self.shiButton.selected = NO;
        self.quButton.selected = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.selectFlagView.mj_w = self.quButton.mj_w + 10;
            self.selectFlagView.centerX = self.quButton.superview.centerX;
        }];
        [self.tableView reloadData];
        //table回到顶部
        [self.tableView beginUpdates];
        self.tableView.contentOffset = CGPointZero;
        [self.tableView endUpdates];
    }];
}

@end
