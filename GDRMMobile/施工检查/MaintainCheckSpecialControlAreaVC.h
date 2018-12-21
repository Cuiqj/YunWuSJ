//
//  MaintainCheckSpecialControlAreaVC.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//检查中第二个施工专项检查

#import <UIKit/UIKit.h>

@interface MaintainCheckSpecialControlAreaVC : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITableView *tableviewList;

@property (nonatomic, retain) NSString * planID;
//检查时间
@property (weak, nonatomic) IBOutlet UITextField *textdate;
//检查人员
@property (weak, nonatomic) IBOutlet UITextField *trxtUser;
//施工路段
@property (weak, nonatomic) IBOutlet UITextField *textproject_address;
//管理单位
@property (weak, nonatomic) IBOutlet UITextField *textmanage_unit;




@property (weak, nonatomic) IBOutlet UITextField *textzone_length_1;
@property (weak, nonatomic) IBOutlet UITextField *textzone_length_2;
@property (weak, nonatomic) IBOutlet UITextField *textzone_length_3;
@property (weak, nonatomic) IBOutlet UITextField *textzone_length_4;
@property (weak, nonatomic) IBOutlet UITextField *textzone_length_5;
@property (weak, nonatomic) IBOutlet UITextField *textzone_length_6;

@property (weak, nonatomic) IBOutlet UITextField *textfacility_lay_1;
@property (weak, nonatomic) IBOutlet UITextField *textfacility_lay_2;
@property (weak, nonatomic) IBOutlet UITextField *textfacility_lay_3;
@property (weak, nonatomic) IBOutlet UITextField *textfacility_lay_4;
@property (weak, nonatomic) IBOutlet UITextField *textfacility_lay_5;
@property (weak, nonatomic) IBOutlet UITextField *textfacility_lay_6;


@property (weak, nonatomic) IBOutlet UITextField *textother_regulation_1;
@property (weak, nonatomic) IBOutlet UITextField *textother_regulation_2;
@property (weak, nonatomic) IBOutlet UITextField *textother_regulation_3;
@property (weak, nonatomic) IBOutlet UITextField *textother_regulation_4;

@property (weak, nonatomic) IBOutlet UITextField *textother;
@property (weak, nonatomic) IBOutlet UITextView *textrecheck;
//整改完成时间
@property (weak, nonatomic) IBOutlet UITextField *textfinish_date;

- (IBAction)BtnSaveClick:(id)sender;
- (IBAction)BtnaddClick:(id)sender;
- (IBAction)DeleteUserClick:(id)sender;
//附件
- (IBAction)Btntoattachment:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *attachmentButton;



- (IBAction)Selectdate:(id)sender;
- (IBAction)SelectUserClick:(id)sender;












@end
