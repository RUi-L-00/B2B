//
//  PayResultVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/25.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "PayResultVC.h"

@interface PayResultVC ()

@property (weak, nonatomic) IBOutlet UIButton *viewHistoryButton;
@property (weak, nonatomic) IBOutlet UIButton *goHomeButton;

@end

@implementation PayResultVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Pay"];
}

- (void)initControl {
    ViewRadius(self.goHomeButton, 5);
    ViewBorderRadius(self.viewHistoryButton, 5, 1, [UIColor colorWithHexString:@"#F16A30"]);
    self.title = @"提交结果";
}

#pragma mark -Action
- (IBAction)goHomeAction:(id)sender {
    //回到首页
    self.tabBarController.selectedIndex= 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (IBAction)viewHistoryAction:(id)sender {
    //查看记录
    OrderListVC *vc = [[OrderListVC alloc] initWithStoryboard];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 跳转
-(void)goDetailVC{
    //跳转订单详情页
//    OrderDetailsVC *orderDetailsVC = [[OrderDetailsVC alloc] initWithStoryboard];
//    orderDetailsVC.hidesBottomBarWhenPushed = YES;
//    orderDetailsVC.orderId = self.orderId;
//    OrderVC *orderVC = [[OrderVC alloc] initWithStoryboard];
//    orderVC.hidesBottomBarWhenPushed = YES;
//    orderVC.selectIndex = 2;
//
//    [self.navigationController popToRootViewControllerAnimated:NO];
//    UIViewController *homeRootVC = [UIWindow jm_currentViewController];
//    homeRootVC.tabBarController.selectedIndex = 2;
//    UIViewController *userRootVC = [UIWindow jm_currentViewController];
//    NSMutableArray *tempMarr = [NSMutableArray arrayWithArray:userRootVC.navigationController.viewControllers];
//    [tempMarr insertObject:orderVC atIndex:tempMarr.count];
//    [tempMarr insertObject:orderDetailsVC atIndex:tempMarr.count];
//    [userRootVC.navigationController setViewControllers:tempMarr animated:YES];
}

@end
