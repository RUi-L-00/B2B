//
//  GlobalShareAlert.m
//  JMBaseProject
//
//  Created by Liuny on 2019/11/4.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GlobalShareAlert.h"

@interface GlobalShareAlert ()

@end

@implementation GlobalShareAlert

-(instancetype)initWithStoryboard{
    return [self initWithStoryboardName:@"Global"];
}

#pragma mark - Actions

- (IBAction)shareAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    switch (button.tag) {
        case 0:
            //微信
            break;
        case 1:
            //朋友圈
            break;
        case 2:
            //新浪微博
            break;
        case 3:
            //QQ
            break;
        default:
            break;
    }
}

@end
