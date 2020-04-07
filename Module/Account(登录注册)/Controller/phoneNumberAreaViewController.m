//
//  phoneNumberAreaViewController.m
//  JMBaseProject
//
//  Created by 利是封 on 2020/3/9.
//  Copyright © 2020 liuny. All rights reserved.
//

#import "phoneNumberAreaViewController.h"
#import "PhoneNumberAreaModel.h"
#import "PhoneNumberGroupModel.h"
#import "PhoneNumberAreaCell.h"
@interface phoneNumberAreaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * tableData;
@property (nonatomic,strong) PhoneNumberAreaModel * selectModel;

@property (weak, nonatomic) IBOutlet UILabel *selectAreaLabel;

@end

@implementation phoneNumberAreaViewController


-(instancetype)initWithStoryboard{
    return [self initWithStoryboardName:@"Account"];
}

-(void)initControl{
    self.title = @"手机号所属区域";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 35;
    self.tableView.tableFooterView = [UIView new];
}

-(void)initData{
    self.tableData = [NSMutableArray array];
    PhoneNumberGroupModel * groupModel1 = [[PhoneNumberGroupModel alloc]init];
     groupModel1.letterTitle = @"A";
    PhoneNumberAreaModel * model1 = [[PhoneNumberAreaModel alloc]init];
    model1.name = @"阿尔巴尼亚";
    model1.number = @"9488";
    PhoneNumberAreaModel * model2 = [[PhoneNumberAreaModel alloc]init];
       model2.name = @"埃及";
       model2.number = @"0497";
    groupModel1.phoneModelArray = [NSMutableArray array];
    [groupModel1.phoneModelArray addObject:model1];
     [groupModel1.phoneModelArray addObject:model2];
     
    PhoneNumberGroupModel * groupModel2 = [[PhoneNumberGroupModel alloc]init];
    groupModel2.letterTitle = @"B";
    PhoneNumberAreaModel * model3 = [[PhoneNumberAreaModel alloc]init];
       model3.name = @"菠萝帝国";
       model3.number = @"0497";
    PhoneNumberAreaModel * model4 = [[PhoneNumberAreaModel alloc]init];
       model4.name = @"波波大帝国";
       model4.number = @"0497";
    groupModel2.phoneModelArray = [NSMutableArray array];
       [groupModel2.phoneModelArray addObject:model3];
        [groupModel2.phoneModelArray addObject:model4];
    [self.tableData addObject:groupModel1];
    [self.tableData addObject:groupModel2];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PhoneNumberGroupModel * model = self.tableData[section];
    return model.phoneModelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PhoneNumberAreaCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PhoneNumberAreaCell"];
     PhoneNumberGroupModel * groupModel = self.tableData[indexPath.section];
    PhoneNumberAreaModel * model = groupModel.phoneModelArray[indexPath.row];
    cell.cellData = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     PhoneNumberGroupModel * groupModel = self.tableData[indexPath.section];
    PhoneNumberAreaModel * model = groupModel.phoneModelArray[indexPath.row];
    model.isSelect = YES;
    self.selectModel.isSelect = NO;
    self.selectModel = model;
    [self.tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 27;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PhoneNumberGroupModel * groupModel = self.tableData[section];
    UIView * sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 27)];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(27, 4, 20, 20)];
    titleLabel.text = groupModel.letterTitle;
    titleLabel.textColor = [UIColor colorWithHexString:@"#222222"];
    titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 26, kScreenWidth, 1)];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [sectionView addSubview:titleLabel];
    [sectionView addSubview:bottomView];
//    sectionView.backgroundColor = [UIColor redColor];
    return sectionView;
}

@end
