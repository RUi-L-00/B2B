//
//  PaySetAddressAlert.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PaySetAddressAlert.h"

@interface PaySetAddressAlert ()

@end

@implementation PaySetAddressAlert

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Pay"];
}

#pragma mark - Actions
- (IBAction)buttonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.buttonClickBlock){
            UIButton *button = (UIButton *)sender;
            self.buttonClickBlock(button.tag);
        }
    }];
}

@end
