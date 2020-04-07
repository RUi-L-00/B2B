//
//  OrderVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderVC.h"
#import "OrderPageVC.h"

@interface OrderVC ()

@property (nonatomic, weak) OrderPageVC *orderPageVC;

@end

@implementation OrderVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Order"];
}

-(void)initControl{
    self.title = @"我的订单";
    
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)initData{
    self.orderPageVC.selectIndex = (int)self.selectIndex;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"pageViewController"]){
        self.orderPageVC = segue.destinationViewController;
    }
}

@end
