//
//  MaintainCheckSpecialJobVC.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/6.
//

#import <UIKit/UIKit.h>

@interface MaintainCheckSpecialJobVC : UIViewController <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UITableView *tableviewList;
@property (nonatomic, retain) NSString * planID;
//检查时间及检查人员
@property (weak, nonatomic) IBOutlet UITextField *textdate;
- (IBAction)Selectdate:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textname;
- (IBAction)SelectCkeckUser:(id)sender;
//现场管理和作业人员
@property (weak, nonatomic) IBOutlet UITextField *textscene_manage_1;
@property (weak, nonatomic) IBOutlet UITextField *textscene_manage_2;
@property (weak, nonatomic) IBOutlet UITextField *textscene_manage_3;
@property (weak, nonatomic) IBOutlet UITextField *textscene_manage_4;
//机械、物料
@property (weak, nonatomic) IBOutlet UITextField *textmachine_marterial_1;
@property (weak, nonatomic) IBOutlet UITextField *textmachine_marterial_2;
@property (weak, nonatomic) IBOutlet UITextField *textmachine_marterial_3;
@property (weak, nonatomic) IBOutlet UITextField *textmachine_marterial_4;
//作业安全设施
@property (weak, nonatomic) IBOutlet UITextField *textsecurity_equipment_1;
@property (weak, nonatomic) IBOutlet UITextField *textsecurity_equipment_2;
@property (weak, nonatomic) IBOutlet UITextField *textsecurity_equipment_3;
@property (weak, nonatomic) IBOutlet UITextField *textsecurity_equipment_4;
//必须按作业控制区交通控制标志设置 相关的渠化装置和标志，指派专人负责、维持交通：
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_construct_1;
//应设专人观察险情，严防安全事故发生
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_construct_2;
//采取防滑坠落措施，并注意防备危岩、浮石滚落：
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_construct_3;
//设专人指挥交通，作业控制区应增加有关设施
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_construct_4;
//不得同时设置两个或两个以上养护施工作业控制区
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_construct_5;
//应设置悬挂式吊篮等防护设施，夜间须设置警示信号
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_construct_6;
//应根据需要设施限载标志
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_construct_7;
//应清除山体边坡或洞顶危石
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_construct_8;
//应定期测量隧道内一氧化碳浓度或烟尘浓度
@property (weak, nonatomic) IBOutlet UITextField *textmaintain_construct_9;
//其他检查
@property (weak, nonatomic) IBOutlet UITextField *textother;
//应整改完成时间
@property (weak, nonatomic) IBOutlet UITextField *textfinish_date;

//复查验证情况
@property (weak, nonatomic) IBOutlet UITextView *textviewrecheck;

- (IBAction)BtnSaveClick:(id)sender;
- (IBAction)BtnaddClick:(id)sender;
- (IBAction)DeleteUserData:(id)sender;

- (IBAction)BtnFuJianClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *ButtonFuJian;

@end
