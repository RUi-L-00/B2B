//
//  UIScrollView+xkCategory.m
//  PinShangHome
//
//  Created by Nicholas on 2017/9/22.
//  Copyright © 2017年 com.xiaopao. All rights reserved.
//

#import "UIScrollView+xkCategory.h"
#import <MJRefresh.h>
#import <objc/runtime.h>

@implementation UIScrollView (xkCategory)

#pragma mark ----- 普通刷新
#pragma mark 普通刷新头
- (void)xk_setNormalHeaderWithRefreshingBlock:(XKRefreshingBlock)refreshingBlock {
    __weak typeof(self) weakSelf = self;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.page = 1;
        if (weakSelf.mj_footer) [weakSelf.mj_footer resetNoMoreData];
        if (refreshingBlock) refreshingBlock();
    }];
}

#pragma mark 设置刷新脚
- (void)xk_setBackStateFooterWithRefreshingBlock:(XKRefreshingBlock)refreshingBlock {
    __weak typeof(self) weakSelf = self;
    self.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        if (refreshingBlock) refreshingBlock();
    }];
}

#pragma mark 一次性设置普通刷新头与脚
- (void)xk_setNormalHeaderWithRefreshingBlock:(XKRefreshingBlock)headerRefreshingBlock backStateFooterWithRefreshingBlock:(XKRefreshingBlock)footerRefreshingBlock {
    self.page = 1;
    if (headerRefreshingBlock) [self xk_setNormalHeaderWithRefreshingBlock:headerRefreshingBlock];
    if (footerRefreshingBlock) [self xk_setBackStateFooterWithRefreshingBlock:footerRefreshingBlock];
}

#pragma mark - 结束刷新
- (void)xk_endRefreshing {
    
    if (self.mj_header.isRefreshing) [self.mj_header endRefreshing];
    if (self.mj_footer.isRefreshing) [self.mj_footer endRefreshing];
}

- (void)setPage:(NSInteger)page {
    objc_setAssociatedObject(self, @"page", @(page), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)page {
    NSNumber *number = objc_getAssociatedObject(self, @"page");
    return number.integerValue;
}

@end
