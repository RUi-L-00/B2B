//
//  GoodModel.h
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
    JMGoodState_Normal              = 0,        //正常订单
    JMGoodState_TuiHuoTuiKuan       = 1,        //退货退款中
    JMGoodState_TuiKuan             = 2,        //仅退款中
    JMGoodState_AlreadyTuiKuan      = 3,        //已退款
    JMGoodState_CloseAfterSale      = 4,        //售后关闭
    JMGoodState_TuiKuanSuccess      = 5,        //申请被拒
}JMGoodState;

/// 某种规格的型号：例如颜色规格：红色、绿色等等
@interface SpecItemModel : NSObject

@property (copy, nonatomic) NSString *normId;//规格型号ID
@property (copy, nonatomic) NSString *normName;//规格型号名称
@property (assign, nonatomic) BOOL isSelect;//是否选中

- (instancetype)initWithDictionary:(NSDictionary *)dic;
//假数据初始化方法
-(instancetype)initWithTest;

@end

/// 商品规格：比如颜色、码数等等
@interface GoodSpecModel : NSObject

@property (copy, nonatomic) NSString *patternName;//规格名称
@property (strong, nonatomic) NSArray<SpecItemModel *> *normArray;//这个规格包含的类型

- (instancetype)initWithDictionary:(NSDictionary *)dic;
//假数据初始化方法
-(instancetype)initWithTest;

@end

@interface SelectSpecModel : NSObject

@property (nonatomic, copy) NSString *selectSpecImage;
@property (nonatomic, copy) NSString *selectSpecId;
@property (nonatomic, copy) NSString *selectSpecCode;
@property (nonatomic, copy) NSString *stock;//库存
@property (nonatomic, copy) NSString *price;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithBuyCarDic:(NSDictionary *)dict;
//假数据初始化方法
-(instancetype)initWithTest;

@end

/// 商品
@interface GoodModel : NSObject

@property (copy, nonatomic) NSString *goodId;//商品ID
@property (copy, nonatomic) NSString *coverImage;//商品图片
@property (copy, nonatomic) NSString *name;//商品名称
@property (copy, nonatomic) NSString *price;//商品价格
@property (copy, nonatomic) NSString *originalPrice;//商品原价
@property (copy, nonatomic) NSString *goodDepict;//商品描述
@property (copy, nonatomic) NSString *summary;//商品简介
@property (copy, nonatomic) NSString *saleCount;//商品销量
@property (strong, nonatomic) NSArray<SelectSpecModel *> *productSpecificationsArray;//商品规格
@property (strong, nonatomic) SelectSpecModel *selectSpec;//已选规格
@property (copy, nonatomic) NSString *isCollect;//是否收藏
@property (copy, nonatomic) NSString *sort;//商品所属分类

//订单使用
@property (assign, nonatomic) NSString *goodsModelsSpecAttributePriceId;
@property (assign, nonatomic) NSInteger buyCount;//购买数量
@property (assign, nonatomic) JMGoodState aftersaleState;//是否售后

//商品详情使用
@property (strong, nonatomic) NSArray<GoodSpecModel *> *goodSpecArray;//可选规格
@property (strong, nonatomic) NSArray *imageArray;//轮播图
@property (copy, nonatomic) NSString *goodContent;//商品详情富文本
@property (strong, nonatomic) NSString *isTakeOff;//商品是否下架

@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, copy) NSString *goodsCartId;//购物车id


//暂时可能没用的属性
@property (copy, nonatomic) NSString *isDrainage;//是否引流商品

//通用方法
- (instancetype)initWithDictionary:(NSDictionary *)dic;
//首页商品列表初始化方法
- (instancetype)initWithHomeListDic:(NSDictionary *)dic;
//分类页商品列表初始化方法
- (instancetype)initWithCategoriesGoodListDic:(NSDictionary *)dic;
//商品详情初始化方法
- (instancetype)initWithDetailsDic:(NSDictionary *)dic;
//购物车初始化方法
- (instancetype)initWithBuyCarDic:(NSDictionary *)dic;
//我的收藏初始化方法
- (instancetype)initWithMyCollectDic:(NSDictionary *)dic;
//订单初始化方法
- (instancetype)initWithOrderDic:(NSDictionary *)dic;
//售后初始化方法
- (instancetype)initWithAfterDic:(NSDictionary *)dic;
//假数据初始化方法
-(instancetype)initWithTest;

@end

NS_ASSUME_NONNULL_END
