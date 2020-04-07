//
//  UserCenterMyGiftVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterMyGiftVC.h"
#import "UserCenterMyGiftCell.h"
@interface UserCenterMyGiftVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * tableData;
@end

@implementation UserCenterMyGiftVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"UserCenter"];
}

-(void)initControl{
    self.title = @"我的礼券兑换";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 116.0;
}


-(void)initData{
    self.tableData = [NSMutableArray array];
    [self.tableData addObject:@"123"];
    [self.tableData addObject:@"123"];
    [self.tableData addObject:@"123"];
}


#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterMyGiftCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UserCenterMyGiftCell"];
    return cell;
}
@end
