//
//  MaintainCheckSpecialFinishVC.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//检查中第四个施工专项检查

#import <UIKit/UIKit.h>

@interface MaintainCheckSpecialFinishVC : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableviewList;
@property (nonatomic, retain) NSString * planID;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;


@property (weak, nonatomic) IBOutlet UITextField *textdate;
@property (weak, nonatomic) IBOutlet UITextField *textUser;
//施工路段
@property (weak, nonatomic) IBOutlet UITextField *textproject_address;
//管理单位
@property (weak, nonatomic) IBOutlet UITextField *textmanage_unit;



@property (weak, nonatomic) IBOutlet UITextField *textremove_rank;
@property (weak, nonatomic) IBOutlet UITextField *texttraffic_security_facility;
@property (weak, nonatomic) IBOutlet UITextField *textother;

@property (weak, nonatomic) IBOutlet UITextView *textrecheck;

@property (weak, nonatomic) IBOutlet UITextField *textfinish_date;



- (IBAction)BtnSaveClick:(id)sender;
- (IBAction)BtnaddClick:(id)sender;
- (IBAction)DeleteUserClick:(id)sender;
//附件
- (IBAction)Btntoattachment:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *attachmentButton;



- (IBAction)SelectDate:(id)sender;
- (IBAction)SelectUser:(id)sender;




@end
