//
//  MaintainCheckSpecialTrafficSecurityFacilityVC.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//检查中第五个施工专项检查

#import <UIKit/UIKit.h>

@interface MaintainCheckSpecialTrafficSecurityFacilityVC : UIViewController <UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableviewList;
@property (nonatomic, retain) NSString * planID;

//施工路段方向
@property (weak, nonatomic) IBOutlet UITextField *textdirection;

//施工单位
@property (weak, nonatomic) IBOutlet UITextField *textconstruct_org;

//施工负责人
@property (weak, nonatomic) IBOutlet UITextField *textconstruct_name;


@property (weak, nonatomic) IBOutlet UILabel *labelstake_startanded;
@property (weak, nonatomic) IBOutlet UILabel *textstake_startandend;

@property (weak, nonatomic) IBOutlet UITextField *textdate;
@property (weak, nonatomic) IBOutlet UITextField *textUser;

@property (weak, nonatomic) IBOutlet UITextField *textconstr_start;
@property (weak, nonatomic) IBOutlet UITextField *textconstr_end;

@property (weak, nonatomic) IBOutlet UITextField *textspecial_item;
@property (weak, nonatomic) IBOutlet UITextField *textremark;

- (IBAction)BtnSaveClick:(id)sender;
- (IBAction)BtnaddClick:(id)sender;

- (IBAction)BtnFuJianClick:(id)sender;
- (IBAction)DeleteUserData:(id)sender;



- (IBAction)SelectDate:(id)sender;


- (IBAction)SelectUser:(id)sender;




@end
