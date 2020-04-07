//
//  GoodModel.m
//  JMBaseProject
//
//  Created by ios on 2019/11/21.
//  Copyright © 2019 liuny. All rights reserved.
//

#import "GoodModel.h"

@implementation SpecItemModel

-(instancetype)initWithTest {
    if (self = [super init]) {
        self.normName = @"红色";
        self.normId = @"000";
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.normName = [dic getJsonValue:@"name"];
        self.normId = [dic getJsonValue:@"id"];
    }
    return self;
}

@end

@implementation GoodSpecModel

-(instancetype)initWithTest {
    if (self = [super init]) {
        self.patternName = @"颜色";
        self.normArray = @[[[SpecItemModel alloc] initWithTest], [[SpecItemModel alloc] initWithTest], [[SpecItemModel alloc] initWithTest], [[SpecItemModel alloc] initWithTest], [[SpecItemModel alloc] initWithTest]].mutableCopy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.patternName = [dic getJsonValue:@"name"];
        NSMutableArray<SpecItemModel *> *normArray = [NSMutableArray array];
        NSArray *list = dic[@"specAttributeList"];
        for (NSDictionary *dataDic in list) {
            SpecItemModel *model = [[SpecItemModel alloc] initWithDictionary:dataDic];
            [normArray addObject:model];
        }
        self.normArray = normArray.copy;
    }
    return self;
}

@end


@implementation SelectSpecModel

-(instancetype)initWithTest {
    if (self = [super init]) {
        self.selectSpecId = @"000";
        self.selectSpecCode = @"123";
        self.price = @"88";
        self.stock = @"99";
        self.selectSpecImage = @"home_pic";
    }
    return self;
}

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.selectSpecId = [dict getJsonValue:@"id"];
        self.selectSpecCode = [dict getJsonValue:@"skuCode"];
        self.price = [dict getJsonValue:@"price"];
        self.stock = [dict getJsonValue:@"stock"];
        self.selectSpecImage = [dict getJsonValue:@"image"];
    }
    return self;
}

//购物车初始化方法
-(instancetype)initWithBuyCarDic:(NSDictionary *)dict{
    self = [super init];
    if(self){
        self.selectSpecId = [dict getJsonValue:@"skuId"];
        self.selectSpecCode = [dict getJsonValue:@"desc"];
        self.price = [dict getJsonValue:@"price"];
        self.stock = [dict getJsonValue:@"stock"];
        self.selectSpecImage = [dict getJsonValue:@"image"];
    }
    return self;
}

@end

@implementation GoodModel

-(instancetype)initWithTest{
    self = [super init];
    if(self){
        self.name = @"ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩";
        self.price = @"88.00";
        self.coverImage = @"home_pic";
        self.originalPrice = @"111";
        self.summary = @"商品描述商品描述商品描述...";
        self.saleCount = @"123";
        self.goodContent = @"ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩ROUGE COCO 可可小姐唇膏，香奈儿经典全新演绎。创新升级配方，更柔润、光彩";
        self.isCollect = @"1";
        self.goodSpecArray = @[[[GoodSpecModel alloc] initWithTest], [[GoodSpecModel alloc] initWithTest], [[GoodSpecModel alloc] initWithTest]].mutableCopy;
        self.productSpecificationsArray = @[[[SelectSpecModel alloc] initWithTest], [[SelectSpecModel alloc] initWithTest], [[SelectSpecModel alloc] initWithTest]].mutableCopy;
        //轮播图
        self.imageArray = @[@"home_pic", @"home_pic", @"home_pic", @"home_pic", @"home_pic"];
        self.isTakeOff = @"1";
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
    }
    return self;
}

//首页商品列表初始化方法
- (instancetype)initWithHomeListDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goodId = [dic getJsonValue:@"id"];
        self.coverImage = [dic getJsonValue:@"image"];
        self.name = [dic getJsonValue:@"name"];
        self.summary = [dic getJsonValue:@"remark"];
        self.sort = [dic getJsonValue:@"labelName"];
    }
    return self;
}

//分类页商品列表初始化方法
- (instancetype)initWithCategoriesGoodListDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goodId = [dic getJsonValue:@"id"];
        self.coverImage = [dic getJsonValue:@"image6"];
        self.name = [dic getJsonValue:@"name"];
        self.summary = [dic getJsonValue:@"remark"];
        self.sort = [dic getJsonValue:@"labelName"];
    }
    return self;
}

//商品详情初始化方法
- (instancetype)initWithDetailsDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goodId = [dic getJsonValue:@"id"];
        self.coverImage = [dic getJsonValue:@"image6"];
        self.name = [dic getJsonValue:@"name"];
        self.price = [dic getJsonValue:@"price"];
        self.originalPrice = [dic getJsonValue:@"oldPrice"];
        self.summary = [dic getJsonValue:@"remark"];
        self.saleCount = [dic getJsonValue:@"sellCount"];
        self.goodContent = [dic getJsonValue:@"content"];
        self.isCollect = [dic getJsonValue:@"isCollected"];
        NSMutableArray<GoodSpecModel *> *goodSpecArray = [NSMutableArray array];
        NSArray *goodSpecList = dic[@"specList"];
        for (NSDictionary *dataDic in goodSpecList) {
            GoodSpecModel *model = [[GoodSpecModel alloc] initWithDictionary:dataDic];
            [goodSpecArray addObject:model];
        }
        self.goodSpecArray = goodSpecArray.copy;
        NSMutableArray<SelectSpecModel *> *productSpecificationsArray = [NSMutableArray array];
        NSArray *productSpecificationsList = dic[@"skuList"];
        for (NSDictionary *dataDic in productSpecificationsList) {
            SelectSpecModel *model = [[SelectSpecModel alloc] initWithDictionary:dataDic];
            [productSpecificationsArray addObject:model];
        }
        self.productSpecificationsArray = productSpecificationsArray.copy;
        //轮播图
        NSMutableArray *imageArray = [[NSMutableArray alloc] init];
        NSString *image1 = [dic getJsonValue:@"image1"];
        if(image1.length > 0){
            image1 = [JMCommonMethod pinImagePath:image1];
            [imageArray addObject:image1];
        }
        NSString *image2 = [dic getJsonValue:@"image2"];
        if(image2.length > 0){
            image2 = [JMCommonMethod pinImagePath:image2];
            [imageArray addObject:image2];
        }
        NSString *image3 = [dic getJsonValue:@"image3"];
        if(image3.length > 0){
            image3 = [JMCommonMethod pinImagePath:image3];
            [imageArray addObject:image3];
        }
        NSString *image4 = [dic getJsonValue:@"image4"];
        if(image4.length > 0){
            image4 = [JMCommonMethod pinImagePath:image4];
            [imageArray addObject:image4];
        }
        NSString *image5 = [dic getJsonValue:@"image5"];
        if(image5.length > 0){
            image5 = [JMCommonMethod pinImagePath:image5];
            [imageArray addObject:image5];
        }
        self.imageArray = imageArray.copy;
        self.isTakeOff = @"1";
    }
    return self;
}

//购物车初始化方法
- (instancetype)initWithBuyCarDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goodId = [dic getJsonValue:@"goodsId"];
        self.coverImage = [dic getJsonValue:@"image"];
        self.name = [dic getJsonValue:@"name"];
        self.price = [dic getJsonValue:@"price"];
        self.buyCount = [dic getJsonValue:@"num"].integerValue;
        self.selectSpec = [[SelectSpecModel alloc] initWithBuyCarDic:dic];
        self.goodsModelsSpecAttributePriceId = [dic getJsonValue:@"goodsModelsSpecAttributePriceId"];
        self.goodsCartId = [dic getJsonValue:@"goodsCartId"];
    }
    return self;
}

//订单初始化方法
- (instancetype)initWithOrderDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goodId = [dic getJsonValue:@"goodsId"];
        self.coverImage = [dic getJsonValue:@"skuImg"];
        self.name = [dic getJsonValue:@"goodsName"];
        self.selectSpec = [[SelectSpecModel alloc] initWithDictionary:dic];
        self.buyCount = [dic getJsonValue:@"num"].integerValue;
        self.price = [dic getJsonValue:@"price"];
        self.aftersaleState = [dic getJsonValue:@"state"].integerValue;
    }
    return self;
}

//售后初始化方法
- (instancetype)initWithAfterDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goodId = [dic getJsonValue:@"goodsId"];
        self.coverImage = [dic getJsonValue:@"skuImg"];
        self.name = [dic getJsonValue:@"goodsName"];
        self.selectSpec = [[SelectSpecModel alloc] initWithDictionary:dic];
        self.buyCount = [dic getJsonValue:@"refundNum"].integerValue;
        self.price = [dic getJsonValue:@"price"];
    }
    return self;
}

//我的收藏初始化方法
- (instancetype)initWithMyCollectDic:(NSDictionary *)dic {
    if (self = [super init]) {
        self.goodId = [dic getJsonValue:@"goodsId"];
        self.coverImage = [dic getJsonValue:@"goodsImg"];
        self.name = [dic getJsonValue:@"goodsName"];
        self.price = [dic getJsonValue:@"price"];
        self.originalPrice = [dic getJsonValue:@"oldprice"];
        self.summary = [dic getJsonValue:@"remark"];
    }
    return self;
}

@end
