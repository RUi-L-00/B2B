//
//  GoodsDetailsVC.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodsDetailsVC.h"
#import "GoodsDetailsSelectSpecificationAlert.h"
#import "GoodsMessageVC.h"

#import "SDCycleScrollView.h"

@interface GoodsDetailsVC () <UIWebViewDelegate, SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *carouselView;//轮播View
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *normLabel;//所选规格
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;
@property (weak, nonatomic) IBOutlet UIView *takeOffView;//商品下架
@property (weak, nonatomic) IBOutlet UIButton *addBuyCarButton;//加入购物车

@property (strong, nonatomic) GoodModel *goodModel;
@property (strong, nonatomic) NSMutableArray *imageArray;
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;

@end

@implementation GoodsDetailsVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"GoodsDetails"];
}

- (void)initControl {
    //self
    self.title = @"商品详情";
    
    //webView
    self.webView.delegate = self;
    
    //addBuyCarButton
    ViewRadius(self.addBuyCarButton, 5);
}

- (void)initData {
    if (kUseTestData) {
        self.goodModel = [[GoodModel alloc] initWithTest];
    } else {
        [self requestData];
    }
}

#pragma mark -cycleScrollView
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    //轮播图片点击回调
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 获取内容高度
    CGFloat height =  [[webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollHeight"] intValue];
    
    self.webViewHeight.constant = height;
    
    //重写contentSize,防止左右滑动
    CGSize size = webView.scrollView.contentSize;
    size.width = webView.scrollView.frame.size.width;
    webView.scrollView.contentSize = size;
}

#pragma mark -Actions
- (IBAction)selectNormAction:(id)sender {
    //选择规格
    [self goSelectNormVC];
}

- (IBAction)buyCarAction:(id)sender {
    //购物车
    [self goBuyCarVC];
}

- (IBAction)leaveCommentsAction:(id)sender {
    //留言
    GoodsMessageVC * goodsMessageVC = [[GoodsMessageVC alloc]initWithStoryboard];
    [self.navigationController pushViewController:goodsMessageVC animated:YES];
}

- (IBAction)addCarAction:(id)sender {
    //加入购物车
//    if (self.goodModel.selectSpec) {
//        [self addBuyCar];
//    } else {
        [self goSelectNormVC];
//    }
}

#pragma mark -跳转
- (void)goSelectNormVC {
    //跳转选择规格
    GoodsDetailsSelectSpecificationAlert *goodsDetailsSelectSpecificationAlert = [[GoodsDetailsSelectSpecificationAlert alloc] initWithStoryboard];
    goodsDetailsSelectSpecificationAlert.goodModel = self.goodModel;
    goodsDetailsSelectSpecificationAlert.selectBlock = ^(NSString * _Nonnull specStr) {
        self.normLabel.text = specStr;
    };
    [self presentViewController:goodsDetailsSelectSpecificationAlert animated:YES completion:nil];
}

- (void)goBuyCarVC {
    //跳转购物车
    ShoppingCartVC *vc = [[ShoppingCartVC alloc] initWithStoryboard];
    vc.isGoodsDetails = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -网络请求
- (void)requestData {
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    params[@"goodsId"] = self.goodId;
    [[JMRequestManager sharedManager] POST:kGoodsDetails_UrlGoodsDetails parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            NSDictionary *dataDic = response.responseObject[@"data"];
            self.goodModel = [[GoodModel alloc] initWithDetailsDic:dataDic];
        }
    }];
}

- (void)addBuyCar {
    //加入购物车
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    params[@"goodsId"] = self.goodModel.goodId;
    params[@"skuId"] = self.goodModel.selectSpec.selectSpecId;
    params[@"num"] = @(self.goodModel.buyCount);
    [[JMRequestManager sharedManager] POST:kGoodsDetails_UrlAddCar parameters:params completion:^(JMBaseResponse *response) {
        if (response.error) {
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        } else {
            //加入成功
            [self dismissViewControllerAnimated:YES completion:^{
                [JMProgressHelper toastInWindowWithMessage:response.responseObject[@"desc"]];
            }];
        }
    }];
}

#pragma mark -set方法
- (void)setGoodModel:(GoodModel *)goodModel {
    _goodModel = goodModel;
    self.nameLabel.text = goodModel.name;
    self.imageArray = goodModel.imageArray.mutableCopy;
    self.takeOffView.hidden = goodModel.isTakeOff.integerValue == 1;
    if (goodModel.isTakeOff.integerValue == 1) {
        self.takeOffView.hidden = YES;
        self.addBuyCarButton.enabled = YES;
        [self.addBuyCarButton setBackgroundColor:[UIColor colorWithHexString:@"#F16A30"]];
    } else {
        self.takeOffView.hidden = NO;
        self.addBuyCarButton.enabled = NO;
        [self.addBuyCarButton setBackgroundColor:[UIColor colorWithHexString:@"#EABFAD"]];
    }
    //商品详情addBuyCarButton
    NSString *contentHtml = [JMCommonMethod autoFitImageHtml:goodModel.goodContent];
    [self.webView loadHTMLString:contentHtml baseURL:nil];
}

- (void)setImageArray:(NSMutableArray *)imageArray {
    _imageArray = imageArray;
    //添加轮播图
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.cycleScrollView.imageURLStringsGroup = imageArray.copy;//设置轮播图地址数组
    self.cycleScrollView.showPageControl = YES;//是否显示分页控件
    self.cycleScrollView.pageDotColor = [UIColor colorWithHexString:@"#CCCCCC"];
    self.cycleScrollView.currentPageDotColor = [UIColor colorWithHexString:@"#F16A30"];
    self.cycleScrollView.pageControlDotSize = CGSizeMake(5.0, 5.0);//分页控件小圆点大小
    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;//图片的显示模式
    self.cycleScrollView.pageControlRightOffset = 5.0;//分页控件距离底部的距离
    self.cycleScrollView.delegate = self;
    [self.carouselView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

@end
