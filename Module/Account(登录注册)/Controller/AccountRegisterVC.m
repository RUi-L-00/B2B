//
//  AccountRegisterVC.m
//  JMBaseProject
//
//  Created by Liuny on 2018/11/7.
//  Copyright © 2018 liuny. All rights reserved.
//

#import "AccountRegisterVC.h"
#import "StyleTFView.h"
#import "phoneNumberAreaViewController.h"
@interface AccountRegisterVC ()
//选择类型
@property (weak, nonatomic) IBOutlet UIButton *personalButton;
@property (weak, nonatomic) IBOutlet UIButton *companyButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@property (weak, nonatomic) IBOutlet StyleTFView *companyNumberView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *CompanyTextField;
@property (weak, nonatomic) IBOutlet UITextField *mailboxTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *registerAcceptButton;

@property (strong, nonatomic) JMPhoneCodeTool *phoneCodeTool;
@end

@implementation AccountRegisterVC

-(instancetype)initWithStoryboard{
    return [self initWithStoryboardName:@"Account"];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.phoneCodeTool stopTimer];
}

-(void)initControl{
    self.title = @"注册";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
}

-(void)initData{
    
}



-(NSArray<UIButton *> *)textViewControllerRelationButtons:(JMTextViewController *)textViewController{
    return @[self.registerAcceptButton];
}

-(JMPhoneCodeTool *)phoneCodeTool{
    if(_phoneCodeTool == nil){
        //此处的字典用于标识验证法发送的类型
        _phoneCodeTool = [[JMPhoneCodeTool alloc] initWithPhoneCodeButton:self.phoneCodeButton type:JMPhoneCodeType_Register];
    }
    return _phoneCodeTool;
}

#pragma mark - Actions

- (IBAction)selectTypeAction:(UIButton *)sender {
    
    if(sender.tag == 0){
        self.nameLabel.text = @"个人";
        self.companyNumberView.hidden = YES;
        self.personalButton.selected = YES;
        self.companyButton.selected = NO;
        self.nameTextField.placeholder = @"请输入用户名";
    }else{
        self.nameLabel.text = @"公司名称";
        self.nameTextField.placeholder = @"请输入公司名";
         self.companyNumberView.hidden = NO;
        self.personalButton.selected = NO;
        self.companyButton.selected = YES;
    }
}

- (IBAction)passwordPlaintextAction:(id)sender {
    UIButton * button = (UIButton *)sender;
     button.selected = !button.selected;
    if (button.selected) {
         self.passwordTextField.secureTextEntry = NO;
    }else{
         self.passwordTextField.secureTextEntry = YES;
    }
}

- (IBAction)duplicatePasswordPlaintextAction:(UIButton *)sender {
     sender.selected = !sender.selected;
    if (sender.selected) {
            self.confirmPasswordTextField.secureTextEntry = NO;
       }else{
            self.confirmPasswordTextField.secureTextEntry = YES;
       }
}


//选择区号
- (IBAction)phoneNumberAction:(id)sender {
    phoneNumberAreaViewController * phoneNumberAreaVC = [[phoneNumberAreaViewController alloc]initWithStoryboard];
    [self.navigationController pushViewController:phoneNumberAreaVC animated:YES];
}



- (IBAction)registerAcceptAction:(id)sender {
    //注册协议勾选
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
}

- (IBAction)acceptInfoAction:(id)sender {
    UIButton * button = (UIButton *)sender;
    //注册协议
     GlobalHtmlVC *htmlVC = [[GlobalHtmlVC alloc] init];
    if (button.tag == 0) {
         htmlVC.type = Html_FuWu;
    }else{
        htmlVC.type = Html_YinSi;
    }
    [self.navigationController pushViewController:htmlVC animated:YES];
}

- (IBAction)sendPhoneCodeAction:(id)sender {
    //发送验证码
    [self.view endEditing:YES];
    self.phoneCodeTool.phoneNum = self.mailboxTextField.text;
    //如果是国际号码，需要设置区号
    //    self.phoneCodeTool.areaId = @"";
    [self.phoneCodeTool sendPhoneCode];
}

- (IBAction)registerAction:(id)sender {
    //注册
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
//    if(self.registerAcceptButton.isSelected == NO){
//        [JMProgressHelper toastInWindowWithMessage:@"请同意注册协议"];
//        return;
//    }
    [self requestRegister];
}

#pragma mark - 网络
-(void)requestRegister{
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [params setJsonValue:self.phoneTextField.text key:@"phone"];
    [params setJsonValue:self.phoneCodeTextField.text key:@"code"];
    [params setJsonValue:self.passwordTextField.text key:@"password"];
    [params setJsonValue:self.nameTextField.text key:@"name"];
    [params setJsonValue:self.mailboxTextField.text key:@"email"];
    
    
    if ([self.nameLabel.text isEqualToString:@"公司名称"]) {
         [params setJsonValue:self.confirmPasswordTextField.text key:@"companyCode"];
        [params setJsonValue:@"3" key:@"type"];
    }else{
        [params setJsonValue:@"0" key:@"type"];
    }
    
    [self showLoading];
    [[JMRequestManager sharedManager] POST:kAccount_UrlRegister parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            //TODO
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}



@end
