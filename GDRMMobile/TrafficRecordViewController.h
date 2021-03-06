//
//  TrafficRecordViewController.h
//  GDRMMobile
//
//  Created by 高 峰 on 13-7-9.
//
//

#import <UIKit/UIKit.h>
#import "DateSelectController.h"
//#import "SystemTypeListViewController.h"
#import "ListSelectViewController.h"
#import "RoadInspectViewController.h"
#import "RoadSegmentPickerViewController.h"

@interface TrafficRecordViewController : UIViewController <UITextFieldDelegate, DatetimePickerHandler, ListSelectPopoverDelegate, RoadSegmentPickerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *accidentListTableView;

//肇事车辆
@property (weak, nonatomic) IBOutlet UITextField *textCar;
//事故来源
@property (weak, nonatomic) IBOutlet UITextField *textInfocom;
//地点
@property (weak, nonatomic) IBOutlet UITextField *textlocation;
//发生地点选择。  云罗，收费站
- (IBAction)textlocationCLick:(id)sender;

//事故方向     或收费站名称
@property (weak, nonatomic) IBOutlet UILabel *labelSecondPlace;
//@property (weak, nonatomic) IBOutlet UITextField *textFix;
@property (weak, nonatomic) IBOutlet UITextField *textSecondPlace;
- (IBAction)textSelectSecondPlace:(id)sender;
//事故位置   或匝道出口
@property (weak, nonatomic) IBOutlet UILabel *labelThirdplace;
@property (weak, nonatomic) IBOutlet UITextField *textThirdPlace;
- (IBAction)textSelectThirdPlace:(id)sender;

//发生地点（桩号）
@property (weak, nonatomic) IBOutlet UITextField *textStartKM;
@property (weak, nonatomic) IBOutlet UITextField *textStartM;
//结束桩号
@property (weak, nonatomic) IBOutlet UITextField *textEndKM;
@property (weak, nonatomic) IBOutlet UITextField *textEndM;

//发生时间
@property (weak, nonatomic) IBOutlet UITextField *textHappentime;
//事故性质
@property (weak, nonatomic) IBOutlet UITextField *textProperty;
//事故分类
@property (weak, nonatomic) IBOutlet UITextField *textType;
//事故类别
@property (weak, nonatomic) IBOutlet UITextField *textSort;

//封道情况
@property (weak, nonatomic) IBOutlet UITextField *textseal_road;

@property (weak, nonatomic) IBOutlet UITextField *textbadcar_sum;
@property (weak, nonatomic) IBOutlet UITextField *textfleshwound_sum;
@property (weak, nonatomic) IBOutlet UITextField *textbadwound_sum;
@property (weak, nonatomic) IBOutlet UITextField *textdeath_sum;


////伤亡情况
//@property (weak, nonatomic) IBOutlet UITextField *textWdsituation;
////损失金额
////@property (weak, nonatomic) IBOutlet UITextField *textLost;
////是否结案
//@property (weak, nonatomic) IBOutlet UITextField *textIsend;
////索赔方式
//@property (weak, nonatomic) IBOutlet UITextField *textPaytype;
//拯救处理结束时间
@property (weak, nonatomic) IBOutlet UITextField *textZjend;
//拯救处理开始时间
@property (weak, nonatomic) IBOutlet UITextField *textZjstart;
//事故处理开始时间
@property (weak, nonatomic) IBOutlet UITextField *textClstart;
//事故处理结束时间
@property (weak, nonatomic) IBOutlet UITextField *textClend;
//备注
@property (weak, nonatomic) IBOutlet UITextField *textRemark;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//拯救处理开关
@property (weak, nonatomic) IBOutlet UISwitch *switchZJCLDate;
//事故处理开关
@property (weak, nonatomic) IBOutlet UISwitch *switchSGCLDate;
//巡查记录ID
@property (nonatomic, strong) NSString *rel_id;

//交通状况
@property (weak, nonatomic) IBOutlet UITextField *textTrafficFlow;
//车型
@property (weak, nonatomic) IBOutlet UITextField *textcarType;

//事故原因
@property (weak, nonatomic) IBOutlet UITextField *textcaseReason;
//处理人
@property (weak, nonatomic) IBOutlet UITextField *textCheckUser;
@property (weak, nonatomic) IBOutlet UITextField *accident_class;

//路段和收费站ID
@property (nonatomic,retain) NSString * roadSegmentID;
@property (nonatomic,retain) NSString * sfzID;
//选择  弹出窗口  和    弹出状态(应该弹出内容）
//@property (nonatomic,retain) UIPopoverController *caseInfoPickerpopover;
@property (nonatomic,assign) RoadSegmentPickerState roadSegmentPickerState;

//处理人选择
- (IBAction)textUserClick:(id)sender;
//清空处理人
- (IBAction)RemoveUserDataClick:(id)sender;
- (IBAction)RemoveUserCLassDataCLick:(id)sender;
- (IBAction)DeleteCarNumnerClick:(id)sender;

- (IBAction)textChanged:(id)sender;

//隧道     是为1 否为0
@property (weak, nonatomic) IBOutlet UITextField *texttunnelNUM;
//其他部门到达时间
@property (weak, nonatomic) IBOutlet UITextField *textother_arrivetimestring;



@property (nonatomic, strong) RoadInspectViewController * roadVC;

- (IBAction)btnSave:(id)sender;
//- (IBAction)btnCancel:(id)sender;
- (IBAction)btnNew:(UIButton *)sender;
- (IBAction)btnPhoto:(UIButton *)sender;

- (IBAction)textTouch:(UITextField *)sender;
@end
