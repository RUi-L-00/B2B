//
//  HomePageVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "HomePageVC.h"

#import "HomeProductListVC.h"

@interface HomePageVC ()

@property (strong, nonatomic) NSMutableArray *titleArray;

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initControl];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initControl];
    }
    return self;
}

- (void)initControl {
    self.titleFontName = @"PingFangSC-Bold";
    //选中样式
    self.titleColorSelected = [UIColor colorWithHexString:@"#F16A30"];
    self.titleSizeSelected = 17.0;
    //未选中颜色
    self.titleColorNormal = [UIColor colorWithHexString:@"#B0A8A4"];
    self.titleSizeNormal = 14.0;
    
    //下划线
    self.menuViewStyle = WMMenuViewStyleDefault;
    
    //设置样式为左对齐
    self.menuViewLayoutMode = WMMenuViewLayoutModeLeft;
}

#pragma mark -dataSource
//设置分栏的高度
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, self.view.width, 54);
}

//设置页面（除去分栏）的frame
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 54, self.view.width, self.view.height - 54);
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titleArray.count;
}

- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index{
    return self.titleArray[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return [self HomeRecommendVC:index];
}

-(UIViewController *)HomeRecommendVC:(NSInteger)type{
    HomeProductListVC *homeProductListVC = [[HomeProductListVC alloc] initWithStoryboard];
    homeProductListVC.type = type;
    return homeProductListVC;
}

#pragma mark -懒加载
- (NSMutableArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSMutableArray array];
        [_titleArray addObject:@"推荐"];
        [_titleArray addObject:@"热门"];
        [_titleArray addObject:@"上新"];
    }
    return _titleArray;
}

@end
