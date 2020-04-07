//
//  AddressAddOrEditVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "AddressAddOrEditVC.h"

@interface AddressAddOrEditVC ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UIView *addressInfoTextView;
@property (weak, nonatomic) IBOutlet UIButton *isDefaultButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@property (strong, nonatomic) NSString *selectSheng;
@property (strong, nonatomic) NSString *selectShi;
@property (strong, nonatomic) NSString *selectQu;
@property (strong, nonatomic) NSString *selectQuId;
@property (strong, nonatomic) UITextView *textView;

@end

@implementation AddressAddOrEditVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Address"];
}

-(void)initControl{
    if(self.editAddress){
        self.title = @"修改收货地址";
        [self.bottomButton setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        self.title = @"添加收货地址";
        [self.bottomButton setTitle:@"添加" forState:UIControlStateNormal];
    }
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView.font = [UIFont systemFontOfSize:14.0];
    self.textView.textColor = [UIColor colorWithHexString:@"#999999"];
    self.textView.placeholder = @"请输入详细的收货地址";
    [self.addressInfoTextView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.addressInfoTextView);
    }];
}

-(void)initData{
    if(self.editAddress){
        self.nameTextField.text = self.editAddress.name;
        self.phoneTextField.text = self.editAddress.phone;
        self.cityTextField.text = [NSString stringWithFormat:@"%@ %@ %@",self.editAddress.sheng,self.editAddress.shi,self.editAddress.qu];
        self.textView.text = self.editAddress.address;
        self.isDefaultButton.selected = self.editAddress.isDefault;
    }
}

#pragma mark - Actions
- (IBAction)cityAction:(id)sender {
    [self.view endEditing:YES];
    //所在地区
    [self goSelectCityVC];
}

- (IBAction)defaultAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}

- (IBAction)bottomButtonAction:(id)sender {
    NSString *name = self.nameTextField.text;
    if(name.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.nameTextField.placeholder];
        return;
    }
    NSString *mobile = self.phoneTextField.text;
    if(mobile.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.phoneTextField.placeholder];
        return;
    }
    NSString *city = self.cityTextField.text;
    if(city.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.cityTextField.placeholder];
        return;
    }
    NSString *address = self.textView.text;
    if(address.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.textView.placeholder];
        return;
    }
    
    UIButton *button = (UIButton *)sender;
    NSString *buttonTitle = button.currentTitle;
    if([buttonTitle isEqualToString:@"添加"]){
        [self requestAddAddress:self.isDefaultAdd];
    }else if([buttonTitle isEqualToString:@"保存"]){
        [self requestEditAddress];
    }
}

#pragma mark -跳转
- (void)goSelectCityVC {
    //选择地区
    AddressSelectCityAlert *addressSelectCityAlert = [[AddressSelectCityAlert alloc] initWithStoryboard];
    addressSelectCityAlert.buttonClickBlock = ^(NSMutableDictionary * _Nonnull params) {
        self.cityTextField.text = [params getJsonValue:@"showText"];
        self.selectSheng = [params getJsonValue:@"shengName"];
        self.selectShi = [params getJsonValue:@"shiName"];
        self.selectQu = [params getJsonValue:@"quName"];
        self.selectQuId = [params getJsonValue:@"areaId"];
    };
    [self presentViewController:addressSelectCityAlert animated:YES completion:nil];
}

#pragma mark - 网络
-(void)requestAddAddress:(BOOL)isDefault{
    //添加地址
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    NSString *name = self.nameTextField.text;
    NSString *mobile = self.phoneTextField.text;
    NSString *address = self.textView.text;
    [params setJsonValue:name key:@"name"];
    [params setJsonValue:mobile key:@"mobile"];
    [params setJsonValue:address key:@"address"];
    [params setJsonValue:self.selectSheng key:@"sheng"];
    [params setJsonValue:self.selectShi key:@"shi"];
    [params setJsonValue:self.selectQu key:@"qu"];
    [params setJsonValue:self.selectQuId key:@"areaId"];
    NSString *isChoice = self.isDefaultButton.isSelected?@"1":@"0";
    [params setJsonValue:isChoice key:@"isChoice"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kAddress_UrlAddAddress parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:kAddress_NotificationUpdataList object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)requestEditAddress{
    //编辑地址
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    NSString *name = self.nameTextField.text;
    NSString *mobile = self.phoneTextField.text;
    NSString *address = self.textView.text;
    [params setJsonValue:self.editAddress.addressId key:@"id"];
    [params setJsonValue:name key:@"name"];
    [params setJsonValue:mobile key:@"mobile"];
    [params setJsonValue:address key:@"address"];
    [params setJsonValue:self.selectSheng key:@"sheng"];
    [params setJsonValue:self.selectShi key:@"shi"];
    [params setJsonValue:self.selectQu key:@"qu"];

    NSString *isChoice = self.isDefaultButton.isSelected?@"1":@"0";
    [params setJsonValue:isChoice key:@"isChoice"];
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kAddress_UrlEditAddress parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:kAddress_NotificationUpdataList object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
