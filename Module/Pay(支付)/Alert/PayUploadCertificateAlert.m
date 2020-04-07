//
//  PayUploadCertificateAlert.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PayUploadCertificateAlert.h"

@interface PayUploadCertificateAlert ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;//价格
@property (weak, nonatomic) IBOutlet UIView *textCisternView;

@property (strong, nonatomic) UITextView *textView;

@end

@implementation PayUploadCertificateAlert

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Pay"];
}

- (void)initData {
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", self.total];

    self.textView = [[UITextView alloc] initWithFrame:CGRectZero];
    self.textView.font = [UIFont systemFontOfSize:14.0];
    self.textView.textColor = [UIColor colorWithHexString:@"#898989"];
//    self.textView.text = [JMProjectManager sharedJMProjectManager].loginUser.payInformation;
    self.textView.userInteractionEnabled = NO;
    self.textView.textAlignment = NSTextAlignmentCenter;
    [self.textCisternView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.textCisternView);
    }];
}

#pragma mark -Private
- (void)showLoading
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)dismissLoading
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


#pragma mark -Actions
- (IBAction)action:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1) {
        //上传凭证
        [JMPickPhotoTool pickImageWithCount:1 doneBlock:^(NSArray<UIImage *> *images) {
            [self requestUpdataCartificate:images.firstObject];
        }];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.cancelBlock) {
                self.cancelBlock();
            }
        }];
    }
}

#pragma mark -网络请求
- (void)requestUpdataCartificate:(UIImage *)image {
    //上传支付凭证
    [self showLoading];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    params[@"orderNo"] = self.orderId;
    [[JMRequestManager sharedManager] upload:kPay_UrlUploadCertificate parameters:params formDataBlock:^NSDictionary<NSData *,JMDataName *> *(id<AFMultipartFormData> formData, NSMutableDictionary<NSData *,JMDataName *> *needFillDataDict) {
        needFillDataDict[UIImageJPEGRepresentation(image, 0.5)] = @"payProof_image.jpg";
        return needFillDataDict;
    } progress:nil completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.successBlock) {
                    self.successBlock();
                }
            }];
        }
    }];
}

@end
