//
//  UserCenterMainVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterMainVC.h"
#import "UserCenterMainCell.h"
#import "UserCenterInfoVC.h"
#import "OrderListVC.h"
#import "UserCenterMyScoresrVC.h"
#import "UserCenterSetupVC.h"
#import "UserCenterHelpVC.h"
#import "UserCenterAboutusVC.h"
@interface UserCenterMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//消费额
@property (weak, nonatomic) IBOutlet UILabel *consumptionLabel;
//积分
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * tableData;
@end

@implementation UserCenterMainVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"UserCenter"];
}



-(void)initControl{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 42;
    self.tableView.tableFooterView = [UIView new];
    
}

-(void)initData{
    self.tableData = [NSMutableArray array];
      [self.tableData addObject:@{@"Image":@"my_icon01",@"Text":@"我的订单"}];
      [self.tableData addObject:@{@"Image":@"my_icon02",@"Text":@"我的礼券兑换"}];
      [self.tableData addObject:@{@"Image":@"my_icon03",@"Text":@"设置"}];
      [self.tableData addObject:@{@"Image":@"my_icon04",@"Text":@"帮助中心"}];
    [self requestUrlBudgetCount];
}

#pragma mark -navigation
- (BOOL)navUIBaseViewControllerIsNeedNavBar:(JMNavUIBaseViewController *)navUIBaseViewController {
    return NO;
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterMainCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UserCenterMainCell"];
    NSDictionary * dic = self.tableData[indexPath.row];
    NSString * text  = [dic getJsonValue:@"Text"];
    NSString * image  = [dic getJsonValue:@"Image"];
    cell.nameLabel.text = text;
    [cell.iconImageView setImage:[UIImage imageNamed:image]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary * dic = self.tableData[indexPath.row];
     NSString * text  = [dic getJsonValue:@"Text"];
    if ([text isEqualToString:@"我的订单"]) {
        OrderListVC * orderListVC = [[OrderListVC alloc]initWithStoryboard];
        [self.navigationController pushViewController:orderListVC animated:YES];
    } else  if ([text isEqualToString:@"我的礼券兑换"]) {
        UserCenterMyGiftVC * myGiftVC = [[UserCenterMyGiftVC alloc]initWithStoryboard];
        [self.navigationController pushViewController:myGiftVC animated:YES];
    } else if ([text isEqualToString:@"设置"]) {
        UserCenterSetupVC * setupVC = [[UserCenterSetupVC alloc]initWithStoryboard];
        [self.navigationController pushViewController:setupVC animated:YES];
    } else if ([text isEqualToString:@"帮助中心"]) {
        UserCenterHelpVC * helpVC = [[UserCenterHelpVC alloc]initWithStoryboard];
        [self.navigationController pushViewController:helpVC animated:YES];
    }
}

#pragma mark - Actopm
//跳转个人
- (IBAction)personalInformationAction:(id)sender {
    UserCenterInfoVC * infoVC = [[UserCenterInfoVC alloc]initWithStoryboard];
    [self.navigationController pushViewController:infoVC animated:YES];
}

//跳转明细
- (IBAction)myScoresAction:(id)sender {
    UserCenterMyScoresrVC * myScoresrVC = [[UserCenterMyScoresrVC alloc]initWithStoryboard];
   [self.navigationController pushViewController:myScoresrVC animated:YES];
}


#pragma mark - 网络
-(void)requestUrlBudgetCount{
    [self showLoading];
    NSMutableDictionary *params = [JMCommonMethod baseRequestParams];
    [[JMRequestManager sharedManager] POST:kGift_UrlBudgetCount parameters:params completion:^(JMBaseResponse *response) {
        [self dismissLoading];
        if(response.error){
            [JMProgressHelper toastInWindowWithMessage:response.errorMsg];
        }else{
            
            
        }
    }];
}

@end
