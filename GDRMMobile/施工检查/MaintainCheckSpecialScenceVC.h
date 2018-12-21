//
//  MaintainCheckSpecialScenceVC.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/6.
//检查中第三个施工专项检查

#import <UIKit/UIKit.h>

@interface MaintainCheckSpecialScenceVC : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@property (weak, nonatomic) IBOutlet UITableView *tableviewList;
@property (nonatomic, retain) NSString * planID;

//施工路段
@property (weak, nonatomic) IBOutlet UITextField *textproject_address;
//管理单位
@property (weak, nonatomic) IBOutlet UITextField *textmanage_unit;

@property (weak, nonatomic) IBOutlet UITextField *textdate;
@property (weak, nonatomic) IBOutlet UITextField *textUser;

@property (weak, nonatomic) IBOutlet UITextField *textlay_rank;

@property (weak, nonatomic) IBOutlet UITextField *textsign_1;
@property (weak, nonatomic) IBOutlet UITextField *textsign_2;
@property (weak, nonatomic) IBOutlet UITextField *textsign_3;
@property (weak, nonatomic) IBOutlet UITextField *textsign_4;
@property (weak, nonatomic) IBOutlet UITextField *textsign_5;
@property (weak, nonatomic) IBOutlet UITextField *textsign_6;
@property (weak, nonatomic) IBOutlet UITextField *textsign_7;

@property (weak, nonatomic) IBOutlet UITextField *textlighting_facility;

@property (weak, nonatomic) IBOutlet UITextField *textworkspace_doorway;

@property (weak, nonatomic) IBOutlet UITextField *texttunnel_construct;

@property (weak, nonatomic) IBOutlet UITextField *textother;

@property (weak, nonatomic) IBOutlet UITextView *textrecheck;

@property (weak, nonatomic) IBOutlet UITextField *textfinish_date;

- (IBAction)BtnSaveClick:(id)sender;
- (IBAction)BtnaddClick:(id)sender;
- (IBAction)DeleteUserData:(id)sender;

//附件
- (IBAction)Btntoattachment:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *attachmentButton;





- (IBAction)SelectDate:(id)sender;

- (IBAction)SelectUser:(id)sender;




@end
