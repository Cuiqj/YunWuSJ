//
//  ServerSettingController.h
//  GDRMMobile
//
//  Created by yu hongwu on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DataDownLoad.h"
#import "DataUpLoad.h"

@interface  DataSyncController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *uibuttonInit;
@property (weak, nonatomic) IBOutlet UIButton *uibuttonReset;
@property (weak, nonatomic) IBOutlet UIButton *uibuttonUpload;
@property (weak, nonatomic) IBOutlet UILabel *versionName;
@property (weak, nonatomic) IBOutlet UIButton *uibuttonResetForm;
@property (weak, nonatomic) IBOutlet UIButton *UpdateVersionBtn;
@property (weak, nonatomic) IBOutlet UIButton *ChangeOrganization;

@property (weak, nonatomic) IBOutlet UILabel *versionTime;
- (IBAction)btnInitData:(id)sender;                 //获取基础数据
- (IBAction)btnUpLoadData:(UIButton *)sender;           //上传业务数据
- (IBAction)btnUser:(id)sender;                     //还原文书格式配置设置
@property (weak, nonatomic) IBOutlet UIButton *setServerBtn;
@property (weak, nonatomic) IBOutlet UIButton *updateDocFormatBtn;

- (IBAction)UpdateVersion:(id)sender;

- (IBAction)btnUpdateDocFormat:(UIButton *)sender;      //更新文书
- (IBAction)Changeorganization:(id)sender;              //切换机构

@end
