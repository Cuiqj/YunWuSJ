//
//  InspectionOutViewController.h
//  GDRMMobile
//
//  Created by yu hongwu on 12-9-13.
//
//交班界面

#import <UIKit/UIKit.h>
#import "CheckItemDetails.h"
#import "CheckItems.h"
#import "TempCheckItem.h"
#import "DateSelectController.h"
#import "InspectionOutCheck.h"
#import "Inspection.h"
#import "InspectionHandler.h"
#import "InspectionRecord.h"

@interface InspectionOutViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,DatetimePickerHandler>
- (IBAction)btnCancel:(UIBarButtonItem *)sender;

//提交
- (IBAction)btnSave:(UIBarButtonItem *)sender;
- (IBAction)btnOK:(UIBarButtonItem *)sender;
- (IBAction)btnDismiss:(UIBarButtonItem *)sender;
- (IBAction)textTouch:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UIView *inputView;
@property (weak, nonatomic) IBOutlet UITableView *tableCheckItems;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerCheckItemDetails;
@property (weak, nonatomic) IBOutlet UITextField *textDetail;
@property (weak, nonatomic) IBOutlet UITextView *textDeliver;
@property (weak, nonatomic) IBOutlet UITextField *textEndDate;
@property (weak, nonatomic) IBOutlet UITextField *textMile;
@property (weak, nonatomic) IBOutlet UITextField *textroad;

@property (weak, nonatomic) id <InspectionHandler> delegate;


@property (weak, nonatomic) IBOutlet UILabel *RoadLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *KmLabel;


@end


//清障
//帮助故障车
//检查桥涵
//检查施工现场
//纠正违反公路施工安全作业规程行为
//劝离行人(次)
//劝离路肩停放车辆
//便民
//恢复中央活动栏杆
//检查服务区
//发现违法行为
//纠正违法行为
//分流
//清理桥下杂物
//开施工整改通知书
//开停工整改通知书
//查处违章建筑
//拆除违章建筑
//查处违章设广告
//拆除违章广告
//其它违章行为
//组织宣传
//抓获损坏路产案件
//拆除桥下铺（处/平方米）
//纠正违反安全作业规程
//为故障车摆放交通设施(次)
//收回交通设施










