//
//  ConstructionReformViewController.h
//  YUNWUMobile
//
//  Created by admin on 2020/4/7.
//施工整改    及停工整改

#import <UIKit/UIKit.h>
#import "Reform.h"
#import "ConstructionReform.h"
#import "ShutdownReform.h"
#import "ResultReform.h"
#import "CasePrintViewController.h"
#import "ReformPDFViewController.h"


@interface ReformViewController : CasePrintViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) ConstructionReform * constructionReform;
@property (nonatomic,strong) ShutdownReform * shutdownReform;
@property (nonatomic,retain) NSMutableArray * data;
//
//@property (retain, nonatomic) NSURL *pdfFormatFileURL;
//@property (retain, nonatomic) NSURL *pdfFileURL;


@property (weak, nonatomic) IBOutlet UIScrollView *myscrollview;
//施工整改及停工整改选择器
@property (weak, nonatomic) IBOutlet UISegmentedControl *segueController;
- (IBAction)segueChange:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *ReformtableView;
//项目名称 select project_name from maintainplan
- (IBAction)Selectproject_name:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textproject_name;
//流水号
@property (weak, nonatomic) IBOutlet UITextField *textserial_number;
//检查单位  select name,id from orginfo
- (IBAction)Selectorg_id:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textorg_id;
//整改单位
- (IBAction)Selectunit_id:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textunit_id;
//检查人
- (IBAction)Selectname:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textname;
//发现日期  222
@property (weak, nonatomic) IBOutlet UITextField *textdate;
//截止时间  223
@property (weak, nonatomic) IBOutlet UITextField *textend_time;
//签收时间  224
@property (weak, nonatomic) IBOutlet UITextField *textre_time;
//检查时间  225
@property (weak, nonatomic) IBOutlet UITextField *textinspect_time;
//记录时间
@property (weak, nonatomic) IBOutlet UITextField *textrecord_date;
- (IBAction)Selectdate:(id)sender;

//路段   select name from roadsegment          //where org_id in (select id from dbo.f_GetParent_Orgid
@property (weak, nonatomic) IBOutlet UITextField *textroad;
- (IBAction)selectoad:(id)sender;
//方向    select type_value from systype where code_name='方向'    and org_id={@user.org_id}
@property (weak, nonatomic) IBOutlet UITextField *textdirection;
- (IBAction)Selectdirection:(id)sender;
//开始桩号
@property (weak, nonatomic) IBOutlet UITextField *textkstation_start;
@property (weak, nonatomic) IBOutlet UITextField *textmstation_start;
//结束桩号
@property (weak, nonatomic) IBOutlet UITextField *textkstation_end;
@property (weak, nonatomic) IBOutlet UITextField *textmstation_end;
//隐患情况
@property (weak, nonatomic) IBOutlet UITextView *texttrouble;
//
@property (weak, nonatomic) IBOutlet UILabel *labelend_time;
    //签收人
@property (weak, nonatomic) IBOutlet UITextField *textrecipient;
@property (weak, nonatomic) IBOutlet UILabel *labelrecipient;
    //整改结果
@property (weak, nonatomic) IBOutlet UITextView *textresult;
//整改状态     select '未整改',0 text    已整改，1
@property (weak, nonatomic) IBOutlet UITextField *textstatus;
- (IBAction)Selectstatus:(id)sender;

//附件
- (IBAction)fujianBtnClick:(id)sender;
//保存
- (IBAction)BtnSaveClick:(id)sender;
//打印通知    打印施工通知
- (IBAction)printClick:(id)sender;
//新增
- (IBAction)addReform:(id)sender;


















@end
