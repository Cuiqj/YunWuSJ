//
//  InspectionTotalViewController.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/8.
//

#import <UIKit/UIKit.h>

#import "InspectionTotal.h"

@interface InspectionTotalViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) NSString * inspectionID;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

//每日事件
@property (weak, nonatomic) IBOutlet UITextField *textdaily_event;
//班别
@property (weak, nonatomic) IBOutlet UITextField *textpersonnel_class;
//接班公里数" Name="mileage_before_trans
@property (weak, nonatomic) IBOutlet UITextField *textmileage_before_trans;
//交班公里数" Name="mileage_after_trans
@property (weak, nonatomic) IBOutlet UITextField *textmileage_after_trans;
//巡查人" Name="inspect_people_num
@property (weak, nonatomic) IBOutlet UITextField *textinspect_people_num;
//巡查次" Name="inspect_times
@property (weak, nonatomic) IBOutlet UITextField *textinspect_times;

//事故" Name="traffic_accident
@property (weak, nonatomic) IBOutlet UITextField *texttraffic_accident;
//有路产" Name="roadasset_case
@property (weak, nonatomic) IBOutlet UITextField *textroadasset_case;
//清障" Name="clear_barrier
@property (weak, nonatomic) IBOutlet UITextField *textclear_barrier;
//帮助故障车" Name="help_trouble_car
@property (weak, nonatomic) IBOutlet UITextField *texthelp_trouble_car;
//检查桥涵" Name="check_bridge
@property (weak, nonatomic) IBOutlet UITextField *textcheck_bridge;

//检查施工现场" Name="check_job_site
@property (weak, nonatomic) IBOutlet UITextField *textcheck_job_site;
//纠正违反公路施工安全作业规程行为" Name="correct_violate
@property (weak, nonatomic) IBOutlet UITextField *textcorrect_violate;
//劝离行人(次)" Name="exhort_passerby
@property (weak, nonatomic) IBOutlet UITextField *textexhort_passerby;
//劝离路肩停放车辆" Name="exhort_car
@property (weak, nonatomic) IBOutlet UITextField *textexhort_car;
//恢复中央活动栏杆" Name="resume_railing
@property (weak, nonatomic) IBOutlet UITextField *textresume_railing;

//检查服务区" Name="check_service
@property (weak, nonatomic) IBOutlet UITextField *textcheck_service;
//发现违法行为" Name="find_illegal
@property (weak, nonatomic) IBOutlet UITextField *textfind_illegal;
//纠正违法行为" Name="alter_illegal
@property (weak, nonatomic) IBOutlet UITextField *textalter_illegal;
//分流" Name="shunt
@property (weak, nonatomic) IBOutlet UITextField *textshunt;
//清理桥下杂物" Name="clean_bridge_misc
@property (weak, nonatomic) IBOutlet UITextField *textclean_bridge_misc;

//开施工整改通知书" Name="construction_note
@property (weak, nonatomic) IBOutlet UITextField *textconstruction_note;
//开停工整改通知书
@property (weak, nonatomic) IBOutlet UITextField *textstop_note;
//查处违章建筑" Name="find_illegal_con
@property (weak, nonatomic) IBOutlet UITextField *textfind_illegal_con;
//拆除违章建筑" Name="remove_illegal_con
@property (weak, nonatomic) IBOutlet UITextField *textremove_illegal_con;
//查处违章设广告" Name="find_illegal_adv
@property (weak, nonatomic) IBOutlet UITextField *textfind_illegal_adv;

//拆除违章广告" Name="remove_illegal_adv
@property (weak, nonatomic) IBOutlet UITextField *textremove_illegal_adv;
//其他违章行为" Name="other_illegal
@property (weak, nonatomic) IBOutlet UITextField *textother_illegal;
//组织宣传" Name="propaganda
@property (weak, nonatomic) IBOutlet UITextField *textpropaganda;
//回收交通设施" Name="get_facilities
@property (weak, nonatomic) IBOutlet UITextField *textget_facilities;




- (IBAction)BtnSaveClick:(id)sender;
- (IBAction)BtnEmptyClick:(id)sender;



- (IBAction)textpersonnel_class_Click:(id)sender;

@end
