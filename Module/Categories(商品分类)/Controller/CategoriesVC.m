//
//  CategoriesVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "CategoriesVC.h"
#import "CategoriesSortVC.h"
#import "CategoriesSecondaryVC.h"

@interface CategoriesVC ()

@property (weak, nonatomic) IBOutlet UIView *typeContainerView;
@property (weak, nonatomic) IBOutlet UIView *goodsListContainerView;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@property (strong, nonatomic) CategoriesSortVC *typeVC;
@property (strong, nonatomic) CategoriesSecondaryVC *categoriesSecondaryVC;

@end

@implementation CategoriesVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"Categories"];
}

- (void)initControl {
    self.title = @"全部分类";
    JMWeak(self);
    self.typeVC.changeGroupBlock = ^(CategoriesModel * _Nonnull model) {
        [weakself.categoriesSecondaryVC changeParentGroup:model];
    };
    
    ViewBorderRadius(self.searchView, 5, 1, [UIColor colorWithHexString:@"#CCCCCC"]);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSString *identifier = segue.identifier;
    if([identifier isEqualToString:@"CategoriesSortVC"]){
        self.typeVC = (CategoriesSortVC *)segue.destinationViewController;
        self.typeVC.index = self.index;
    }else if([identifier isEqualToString:@"CategoriesGoodListVC"]){
        self.categoriesSecondaryVC = (CategoriesSecondaryVC *)segue.destinationViewController;
    }
}

- (BOOL)jmNavigationIsHideBottomLine:(JMNavigationBar *)navigationBar {
    return YES;
}

#pragma mark -Actions
- (IBAction)searchAction:(id)sender {
    HomeSearchVC  * homeSearchVC = [[HomeSearchVC alloc]initWithStoryboard];
    [self.navigationController pushViewController:homeSearchVC animated:YES];
}

@end
