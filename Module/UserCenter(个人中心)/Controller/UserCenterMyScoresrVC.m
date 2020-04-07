//
//  UserCenterMyScoresrVC.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/11.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "UserCenterMyScoresrVC.h"
#import "UserCenterMyScoresrCell.h"
@interface UserCenterMyScoresrVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *unDataView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * tableData;

@property (weak, nonatomic) IBOutlet UIView *popView;
@property (weak, nonatomic) IBOutlet UILabel *selectTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *popSelectTypeLabel;

//全部
@property (weak, nonatomic) IBOutlet UIView *allBtnView;
//增加
@property (weak, nonatomic) IBOutlet UIView *addBtnView;
//减少
@property (weak, nonatomic) IBOutlet UIView *decreaseBtnView;


//选中类型
@property (nonatomic,assign) NSInteger selectType;
@end

@implementation UserCenterMyScoresrVC

- (instancetype)initWithStoryboard {
    return [self initWithStoryboardName:@"UserCenter"];
}

-(void)initControl{
    self.title = @"我的积分明细";
    self.selectType = 0;
    self.popView.hidden = YES;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F9F9F9"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 58.0;
}


-(void)initData{
    self.tableData = [NSMutableArray array];
    [self.tableData addObject:@"123"];
    [self.tableData addObject:@"123"];
    [self.tableData addObject:@"123"];
}

#pragma mark - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    self.unDataView.hidden = self.tableData.count != 0;
    return self.tableData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterMyScoresrCell * cell =[tableView dequeueReusableCellWithIdentifier:@"UserCenterMyScoresrCell"];
    return cell;
}

#pragma mark - Action
//选择类型
- (IBAction)selectBtnAction:(UIButton *)sender {
    self.selectType = sender.tag;
    self.popView.hidden = YES;
      NSString * typeName;
    switch (self.selectType) {
        case 0:
            typeName = @"全部";
            break;
        case 1:
            typeName = @"积分增加";
             break;
        case 2:
            typeName = @"积分减少";
             break;
            
        default:
            break;
    }
    self.selectTypeLabel.text = typeName;
    self.popView.hidden = YES;
}

//收起弹窗
- (IBAction)putAwayAction:(id)sender {
    self.popView.hidden = YES;
    
}

//弹出弹窗
- (IBAction)showPopViewAction:(id)sender {
     self.popView.hidden = NO;
    NSString * typeName;
    switch (self.selectType) {
        case 0:
            typeName = @"全部";
            self.allBtnView.hidden = YES;
            self.addBtnView.hidden = NO;
            self.decreaseBtnView.hidden = NO;
            break;
        case 1:
            typeName = @"积分增加";
            self.allBtnView.hidden = NO;
            self.addBtnView.hidden = YES;
            self.decreaseBtnView.hidden = NO;
             break;
        case 2:
            typeName = @"积分减少";
            self.allBtnView.hidden = NO;
            self.addBtnView.hidden = NO;
            self.decreaseBtnView.hidden = YES;
             break;
            
        default:
            break;
    }
    self.popSelectTypeLabel.text = typeName;
}

@end
