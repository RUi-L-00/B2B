//
//  PayUploadCertificateAlert.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBottomAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayUploadCertificateAlert : JMBottomAlertViewController

@property (assign, nonatomic) float total;//应付款
@property (strong, nonatomic) NSString *orderId;
@property (copy, nonatomic) void(^successBlock)(void);
@property (copy, nonatomic) void(^cancelBlock)(void);

@end

NS_ASSUME_NONNULL_END
