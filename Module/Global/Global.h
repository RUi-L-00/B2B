//
//  Global.h
//  JMBaseProject
//
//  Created by Liuny on 2019/11/11.
//  Copyright © 2019 liuny. All rights reserved.
//


//------文件命名规范-----
/***结构**/
/*
文件夹：
Alert:继承JMBottomAlertViewController、JMCenterAlertViewController弹框,命名：模块+自己标识符+Alert
Model:数据model,命名:模块+自己标识符+Model
View:继承UITableViewCell、UICollectionViewCell、自定义view,命名:模块+自己标识符+Cell(View)
Controller:VC,命名:模块+自己标识符+VC

头文件：命名与模块相同
storyboard:第一个命名为模块相同，最多放15个VC,超过新建一个，命名:模块+Two 往后以此类推。
 */


#ifndef Global_h
#define Global_h

//------外部可识别的文件-----
#import "GlobalPickImageAlert.h"
#import "GlobalCenterTipAlert.h"
#import "GlobalHtmlVC.h"
#import "GlobalShareAlert.h"
#import "GlobalBottomButtonsAlert.h"

//------占位图-----(命名规范：k+模块名+"_"+Placeholder+自己标识符)
#define  kGlobal_PlaceholderUser     [UIImage imageNamed:@""]
#define  kGlobal_PlaceholderGood     [UIImage imageNamed:@""]


//------通知-----(命名规范：k+模块名+"_"+Notification+自己标识符)
//注意后面的内容就直接宏名字
#define  kGlobal_NotificationUser   @"kGlobal_NotificationUser"


//------接口地址-----(命名规范：k+模块名+"_"+Url+自己标识符)
#define kGlobal_UrlHtmlContent      fPinUrl(@"api/content/get")//HTML协议


#endif /* Global_h */
