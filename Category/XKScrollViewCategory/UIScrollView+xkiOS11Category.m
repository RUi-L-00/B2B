//
//  UIScrollView+xkiOS11Category.m
//  PinShangHome
//
//  Created by Nicholas on 2017/10/24.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import "UIScrollView+xkiOS11Category.h"

@implementation UIScrollView (xkiOS11Category)

#pragma mark 适配iOS 11
- (void)xk_configContentInsetAdjustmentNever {
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        
    }
}

@end
