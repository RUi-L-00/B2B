//
//  GiftDetailsVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "GiftDetailsVC.h"

@interface GiftDetailsVC ()

@end

@implementation GiftDetailsVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Gift"];
}

- (void)initControl {
    self.view.backgroundColor = [UIColor whiteColor];
    
}



- (IBAction)ApplyAction:(id)sender {
    GlobalCenterTipAlert *tipView = [[GlobalCenterTipAlert alloc] initWithStoryboard];
          tipView.message = @"是否确定申请兑换？";
          tipView.buttonTitles = @[@"取消",@"确定"];
          tipView.buttonClickBlock = ^(NSInteger buttonIndex) {
              if(buttonIndex == 1){
                 
              }
          };
          [self presentViewController:tipView animated:YES completion:nil];
}

@end
