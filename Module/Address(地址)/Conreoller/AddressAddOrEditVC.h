//
//  AddressAddOrEditVC.h
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddressAddOrEditVC : JMBaseViewController

@property (nonatomic, strong) AddressModel *editAddress;
@property (nonatomic, assign) BOOL isDefaultAdd;

@end

NS_ASSUME_NONNULL_END
