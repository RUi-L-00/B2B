//
//  OrderPageVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/27.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "OrderPageVC.h"
#import "OrderListVC.h"

@interface OrderPageVC ()

@property(nonatomic, strong) NSMutableArray *titlesArray;

@end

@implementation OrderPageVC

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self initControl];
    }
    return self;
}

-(void)initControl{
    //带下划线
    self.menuViewStyle = WMMenuViewStyleLine;
    //选中颜色
    self.titleColorSelected = kColorMain;
    //非选中颜色
    self.titleColorNormal = [UIColor colorWithHexString:@"#999999"];
    self.titleSizeSelected = 12.0;
    self.titleSizeNormal = 12.0;
    self.titleFontName = @"PingFangSC-Semibold";
   
    self.progressWidth = 30.0;
    self.progressHeight = 2.0;
}

-(NSMutableArray *)titlesArray{
    if(_titlesArray == nil){
        _titlesArray = [[NSMutableArray alloc] init];
        [_titlesArray addObject:@"全部订单"];
        [_titlesArray addObject:@"待付款"];
        [_titlesArray addObject:@"待审核"];
        [_titlesArray addObject:@"待发货"];
        [_titlesArray addObject:@"待收货"];
        [_titlesArray addObject:@"退款/售后"];
       
    }
    return _titlesArray;
}

#pragma mark - data source
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    CGFloat height = 36;
    return CGRectMake(0, 0, self.view.mj_w, height);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = 36.0;
    return CGRectMake(0, originY, self.view.mj_w, self.view.mj_h - originY);
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = kScreenWidth/6.0;
    return width;
}

-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController{
    return self.titlesArray.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index{
    return self.titlesArray[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
//    if(index == 5){
//        AfterSaleVC *afterSaleVC = [[AfterSaleVC alloc] initWithStoryboard];
//        return afterSaleVC;
//    }else{
        return [self orderListVCWithType:index];
//    }
}

-(UIViewController *)orderListVCWithType:(NSInteger)index{
    OrderListVC *orderListVC = [[OrderListVC alloc] initWithStoryboard];
    JMOrderType type;
    switch (index) {
        case 0:
            type = JMOrderType_All;
            break;
        case 1:
            type = JMOrderType_WaitPay;
            break;
        case 2:
            type = JMOrderType_WaitShenHe;
            break;
        case 3:
            type = JMOrderType_WaitFaHuo;
            break;
        case 4:
            type = JMOrderType_WaitShouHuo;
            break;
        default:
            type = JMOrderType_All;
            break;
    }
    
    orderListVC.type = type;
    return orderListVC;
}

@end
