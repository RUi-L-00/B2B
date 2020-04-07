//
//  ForgetPasswordViewController.m
//  JMBaseProject
//
//  Created by Liuny on 2018/11/7.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "AccountForgetPasswordVC.h"

@interface AccountForgetPasswordVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong, nonatomic) JMPhoneCodeTool *phoneCodeTool;
@end

@implementation AccountForgetPasswordVC

-(instancetype)initWithStoryboard{
    return [self initWithStoryboardName:@"Account"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.phoneCodeTool stopTimer];
}

-(void)initControl{
    self.title = @"忘记密码";
       self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
}

-(void)initData{
    
}


-(NSArray<UIButton *> *)textViewControllerRelationButtons:(JMTextViewController *)textViewController{
    return @[self.confirmButton];
}

-(JMPhoneCodeTool *)phoneCodeTool{
    if(_phoneCodeTool == nil){
        //此处的字典用于标识验证法发送的类型
        _phoneCodeTool = [[JMPhoneCodeTool alloc] initWithPhoneCodeButton:self.phoneCodeButton type:JMPhoneCodeType_ForgetPassword];
    }
    return _phoneCodeTool;
}

#pragma mark - Actions
- (IBAction)passwordSeeOrNotSeeAction:(id)sender {
    //密码明文/密码显示
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    switch (button.tag) {
        case 0:
            self.passwordTextField.secureTextEntry = !button.selected;
            break;
        case 1:
            self.confirmPasswordTextField.secureTextEntry = !button.selected;
            break;
        default:
            break;
    }
}

- (IBAction)sendPhoneCodeAction:(id)sender {
    //发送验证码
    [self.view endEditing:YES];
    self.phoneCodeTool.phoneNum = self.phoneTextField.text;
    //如果是国际号码，需要设置区号
    //    self.phoneCodeTool.areaId = @""
    [self.phoneCodeTool sendPhoneCode];
    
}

- (IBAction)resetAction:(id)sender {
    //重置密码
    NSString *phone = self.phoneTextField.text;
    if(phone.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.phoneTextField.placeholder];
        return;
    }
    NSString *code = self.phoneCodeTextField.text;
    if(code.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.phoneCodeTextField.placeholder];
        return;
    }
    NSString *password = self.passwordTextField.text;
    if(password.length == 0){
        [JMProgressHelper toastInWindowWithMessage:self.passwordTextField.placeholder];
        return;
    }
    NSString *confirmPassword = self.confirmPasswordTextField.text;
    if(![password isEqualToString:confirmPassword]){
        [JMProgressHelper toastInWindowWithMessage:@"两次输入的密码不相同"];
        return;
    }
    
    [self requestForgetPassword];
}

#pragma mark - 网络
-(void)requestForgetPassword{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.phoneTextField.text key:@"mobile"];
    [params setJsonValue:self.phoneCodeTextField.text key:@"code"];
    [params setJsonValue:self.passwordTextField.text key:@"password"];
    
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kAccount_UrlFindPassword parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
