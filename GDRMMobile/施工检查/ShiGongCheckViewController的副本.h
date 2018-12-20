//
//  ShiGongCheckViewController.h
//  GDRMMobile
//
//  Created by xiaoxiaojia on 17/1/13.
//
//

#import <UIKit/UIKit.h>
#import "InspectionConstructionViewController.h"
#import "InspectionConstruction.h"
#import "DateSelectController.h"
#import "UserPickerViewController.h"
#import "CaseInfoPickerViewController.h"
#import "CasePrintViewController.h"
#import "ShiGongCheckViewController.h"
#import "MaintainPlanPickerViewController.h"
#import "RoadInspectViewController.h"
@interface ShiGongCheckViewController :UIViewController<UITextFieldDelegate,CaseIDHandler,UserPickerDelegate,DatetimePickerHandler,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,MaintainPlanPickerDelegate>
//@property (weak, nonatomic) IBOutlet UIButton *uiBtnSave;
//@property (weak, nonatomic) IBOutlet UIButton *uiBtnAdd;
@property (weak, nonatomic) IBOutlet UIButton * uiBtnFujian;
@property (weak, nonatomic) IBOutlet UITableView * tableCloseList;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollContent;
@property (weak, nonatomic) IBOutlet UITextField * endDate;
@property (weak, nonatomic) IBOutlet UITextField * stattdate;
@property (weak, nonatomic) IBOutlet UITextField * Fuzeren;
@property (weak, nonatomic) IBOutlet UITextField * tel_phone;


//施工检查备注
@property (weak, nonatomic) IBOutlet UITextView *textcheck_remark;

@property (weak, nonatomic) IBOutlet UITextField *textShiGongDanWei;
@property (weak, nonatomic) IBOutlet UITextField *textDidian;

@property (weak, nonatomic) IBOutlet UITextField *textProject;
@property (weak, nonatomic) IBOutlet UITextField *textchedao;
- (IBAction)selectProject:(UITextField *)sender;

@property (nonatomic, retain) NSString *inspectionID;
//@property (nonatomic, assign) RoadInspectViewController *roadInspectVC;
@property (weak, nonatomic) IBOutlet UIButton *DailyRoadWorkCheck;
- (IBAction)DailyRoadWorkCheckClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *SpecialProject;
- (IBAction)SpecialProjectCheckClick:(id)sender;



//@property (retain, nonatomic) NSURL *pdfFormatFileURL;
//@property (retain, nonatomic) NSURL *pdfFileURL;


@end
