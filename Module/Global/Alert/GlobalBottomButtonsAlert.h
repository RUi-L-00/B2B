//
//  GlobalBottomButtonsAlert.h
//  JMBaseProject
//
//  Created by Liuny on 2019/11/11.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "JMBottomAlertViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GlobalBottomButtonsAlert : JMBottomAlertViewController

//注意顺序，由上到下
@property (nonatomic, strong) NSArray<NSString *> *buttonTitles;
@property (nonatomic, copy) void(^buttonClick)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
