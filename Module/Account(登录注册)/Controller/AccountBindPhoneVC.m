//
//  AccountBindPhoneVC.m
//  JMBaseProject
//
//  Created by Liuny on 2018/11/7.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "AccountBindPhoneVC.h"

@interface AccountBindPhoneVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeButton;
@property (strong, nonatomic) JMPhoneCodeTool *phoneCodeTool;
@end

@implementation AccountBindPhoneVC

-(instancetype)initWithStoryboard{
    return [self initWithStoryboardName:@"Account"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.phoneCodeTool stopTimer];
}

-(void)initControl{
    self.title = @"绑定手机号";
}

-(void)initData{
    
}

-(JMPhoneCodeTool *)phoneCodeTool{
    if(_phoneCodeTool == nil){
        //此处的字典用于标识验证法发送的类型
        _phoneCodeTool = [[JMPhoneCodeTool alloc] initWithPhoneCodeButton:self.phoneCodeButton type:JMPhoneCodeType_BindPhone];
    }
    return _phoneCodeTool;
}

#pragma mark - Actions
- (IBAction)sendPhoneCodeAction:(id)sender {
    //发送验证码
    [self.view endEditing:YES];
    self.phoneCodeTool.phoneNum = self.phoneTextField.text;
    //如果是国际号码，需要设置区号
//    self.phoneCodeTool.areaId = @""
    [self.phoneCodeTool sendPhoneCode];
}

- (IBAction)bindAction:(id)sender {
    //绑定
    NSString *phone = self.phoneTextField.text;
    if(JMIsEmpty(phone)){
        [JMProgressHelper toastInWindowWithMessage:self.phoneTextField.placeholder];
        return;
    }
    NSString *code = self.phoneCodeTextField.text;
    if(JMIsEmpty(code)){
        [JMProgressHelper toastInWindowWithMessage:self.phoneCodeTextField.placeholder];
        return;
    }
    [self requestBindPhone];
}

#pragma mark - 网络
-(void)requestBindPhone{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.phoneTextField.text key:@"mobile"];
    [params setJsonValue:self.phoneCodeTextField.text key:@"code"];
    [params setJsonValue:self.ids key:@"ids"];
    
    [[JMRequestManager sharedManager] POST:kAccount_UrlThirdLoginBindPhone parameters:params completion:^(JMBaseResponse *response) {
        if (self.completeBlock) {
            self.completeBlock(response);
        }
    }];
}

@end
