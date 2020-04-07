//
//  JMRefreshHelp.m
//  JMBaseProject
//
//  Created by liuny on 2018/7/10.
//  Copyright © 2018年 liuny. All rights reserved.
//

#import "JMRefreshTool.h"

static NSInteger startPageIndex = 1;
static NSInteger kGlobalPageSize = 10;

@interface JMRefreshTool()
@property (nonatomic, readwrite) NSInteger currPage;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, copy) requestCompletionBlock completionBlock;
@property (nonatomic, copy) NSString *modelClass;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSArray *(^dataAnalysisBlock)(NSDictionary *responseData);
@end

@implementation JMRefreshTool
-(instancetype)initWithScrollView:(UIScrollView *)scrollView analysisClass:(NSString *)modelClass completion:(requestCompletionBlock)completionBlock {
    self = [super init];
    if(self){
        self.requestParams = [NSMutableDictionary dictionary];
        self.scrollView = scrollView;
        self.isRefreshHeader = YES;
        self.isRefreshFooter = YES;
        self.modelClass = modelClass;
        self.completionBlock = completionBlock;
        self.pageSize = kGlobalPageSize;
    }
    return self;
}

//使用回调自己解析（数据格式不统一）
-(instancetype)initWithScrollView:(UIScrollView *)scrollView dataAnalysisBlock:(NSArray *(^)(NSDictionary *responseData))dataAnalysisBlock{
    self = [super init];
    if(self){
        self.scrollView = scrollView;
        self.isRefreshHeader = YES;
        self.isRefreshFooter = YES;
        self.dataAnalysisBlock = dataAnalysisBlock;
        self.pageSize = kGlobalPageSize;
    }
    return self;
}

-(BOOL)isAddData{
    if(self.currPage == startPageIndex){
        return NO;
    }else{
        return YES;
    }
}

-(void)setIsRefreshFooter:(BOOL)isRefreshFooter{
    _isRefreshFooter = isRefreshFooter;
    if(self.isRefreshFooter == YES){
        self.scrollView.mj_footer = [self refreshFooter];
    }else{
        self.scrollView.mj_footer = nil;
    }
}

-(void)setIsRefreshHeader:(BOOL)isRefreshHeader{
    _isRefreshHeader = isRefreshHeader;
    if(self.isRefreshHeader == YES){
        self.scrollView.mj_header = [self refreshHeader];
    }else{
        self.scrollView.mj_header = nil;
    }
}

-(MJRefreshBackNormalFooter *)refreshFooter{
//    MJRefreshAutoNormalFooter
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMore:YES];
    }];
    // 设置文字
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经到底了哦~" forState:MJRefreshStateNoMoreData];
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:12.0];
    // 设置颜色
    footer.stateLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    return footer;
}

-(MJRefreshNormalHeader *)refreshHeader{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadMore:NO];
    }];
    header.stateLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    header.stateLabel.font = [UIFont systemFontOfSize:12.0];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    return header;
}

-(void)loadMore:(BOOL)isMore{
    if(isMore){
        self.currPage++;
    }else{
        self.currPage = startPageIndex;
    }
    [self requestData];
}

// 结束刷新
- (void)endHeaderFooterRefreshing
{
    // 结束刷新状态
    ![self.scrollView.mj_header isRefreshing] ?: [self.scrollView.mj_header endRefreshing];
    ![self.scrollView.mj_footer isRefreshing] ?: [self.scrollView.mj_footer endRefreshing];
    self.scrollView.mj_header.hidden = NO;
    self.scrollView.mj_footer.hidden = NO;
}

-(void)requestData{
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:self.requestParams];
    
    if(self.isRefreshFooter == YES){
        //分页请求时添加
        [params setJsonValue:[NSString stringWithFormat:@"%ld",self.currPage] key:@"pageNumber"];
        [params setJsonValue:[NSString stringWithFormat:@"%ld",self.pageSize] key:@"pageSize"];
    }
    
    [[JMRequestManager sharedManager] POST:self.requestUrl parameters:params completion:^(JMBaseResponse *response) {
        [self endHeaderFooterRefreshing];
        if(response.error){
            //提示
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
            if(self.isRefreshFooter == YES){
                if(self.currPage > startPageIndex){
                    self.currPage--;
                }
            }
        }else{
            NSMutableArray *array;
            if(self.dataAnalysisBlock){
                //使用回调自己解析
                array = [self.dataAnalysisBlock(response.responseObject) mutableCopy];
            }else{
                //使用MJ数模转换解析
                Class modelClass = NSClassFromString(self.modelClass);
                
                array = [[NSMutableArray alloc] init];
                NSDictionary *dataDic = response.responseObject[@"data"];
                for(NSDictionary *dic in dataDic[@"list"]){
                    [array addObject:[modelClass mj_objectWithKeyValues:dic]];
                }
                if([self isAddData] == YES){
                    [self.dataArray addObjectsFromArray:array];
                }else{
                    self.dataArray = array;
                }
                
                if (self.completionBlock) {
                    self.completionBlock(self.dataArray);
                }
            }
            
            if(self.isRefreshFooter == YES){
                if(array.count < self.pageSize){
                    [self.scrollView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.scrollView.mj_footer endRefreshing];
                }
            }
        }
    }];
}
@end
