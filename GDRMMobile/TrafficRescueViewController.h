//
//  TrafficRescueViewController.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/13.
//

#import <UIKit/UIKit.h>

@interface TrafficRescueViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableviewList;
//公司名称
@property (weak, nonatomic) IBOutlet UITextField *textorg_id;
//拯救车牌
@property (weak, nonatomic) IBOutlet UITextField *textsa_car;
//  通知时间
@property (weak, nonatomic) IBOutlet UITextField *textnotice_time;
//  到达时间
@property (weak, nonatomic) IBOutlet UITextField *textarrival_time;
//事故车牌
@property (weak, nonatomic) IBOutlet UITextField *textac_car;
//司乘人姓名电话
@property (weak, nonatomic) IBOutlet UITextField *textcrew;
//收费
@property (weak, nonatomic) IBOutlet UITextField *textcharge;
//拯救人员
@property (weak, nonatomic) IBOutlet UITextField *textsa_person;
//巡查人员
@property (weak, nonatomic) IBOutlet UITextField *textpatrol_person;
//处理结束时间
@property (weak, nonatomic) IBOutlet UITextField *textend_time;
//现场救援情况
@property (weak, nonatomic) IBOutlet UITextView *textviewsituation;
//备注
@property (weak, nonatomic) IBOutlet UITextView *textviewremark;

- (IBAction)SelectDate:(id)sender;
- (IBAction)SelectUser:(id)sender;
//选择公司
- (IBAction)SelectCompany:(id)sender;

- (IBAction)BtnDeleteUserData:(id)sender;
- (IBAction)BtnSaveClick:(id)sender;
- (IBAction)BtnaddClick:(id)sender;
- (IBAction)BtnFuJianClick:(id)sender;

@end
