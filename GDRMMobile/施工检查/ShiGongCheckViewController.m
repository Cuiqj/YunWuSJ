#import "ShiGongCheckViewController.h"
#import "UserInfo.h"
#import "InspectionConstructionCell.h"
#import "AttachmentViewController.h"
#import "InspectionConstructionPDFViewController.h"
#import "CaseDocumentsViewController.h"
#import "MaintainPlanCheck.h"
#import "OrgInfo.h"
#import "ListSelectViewController.h"
#import "Systype.h"

#import "DailyRoadWorkViewController.h"
#import "MaintainCheckSpecialJobVC.h"
#import "MaintainCheckSpecialControlAreaVC.h"
#import "MaintainCheckSpecialScenceVC.h"
#import "MaintainCheckSpecialFinishVC.h"
#import "MaintainCheckSpecialTrafficSecurityFacilityVC.h"

static NSString *inspectionConstructionTable = @"InspectionConstructionTable";
static NSString *inspectionConstruction      = @"InspectionConstruction";

typedef enum {
    kStartTime1 = 0,
    kEndTime1,
    kStartTime2,
    kEndTime2,
    kInspectionDate
} TimeState;

@interface ShiGongCheckViewController ()
@property (retain, nonatomic) NSMutableArray      *constructionList;
@property (retain, nonatomic) UIPopoverController *pickerPopover;
@property (copy, nonatomic  ) NSString            *constructionID;
@property (assign, nonatomic) TimeState           timeState;

@property (nonatomic,retain) NSArray * MaintainPlanData;;

//跳转时关联id
@property (copy, nonatomic) NSString * maintainPlanID;

//设定文书查看状态，编辑模式或者PDF查看模式
@property (nonatomic,assign) DocPrinterState docPrinterState;

@property (assign,nonatomic) BOOL      isWeatherFirstOrWeatherSecond;
@property (assign,nonatomic) NSInteger touchTextTag;

-(void)keyboardWillShow:(NSNotification *)aNotification;
-(void)keyboardWillHide:(NSNotification *)aNotification;
-(BOOL)checkInspectionConstructionInfo;
@end

@implementation ShiGongCheckViewController{
    NSIndexPath *notDeleteIndexPath;
    
    NSString *currentFileName;
    //弹窗标识，为0弹出天气选择，为1弹出车型选择，为2弹出损坏程度选择
    NSInteger touchedTag;
    NSDate *proveDate;
    
}
//@synthesize uiBtnSave;
@synthesize tableCloseList;
//@synthesize scrollContent;
@synthesize constructionList;
@synthesize pickerPopover;
@synthesize constructionID  = _constructionID;
@synthesize maintainPlanID  = _maintainPlanID;
@synthesize docPrinterState = _docPrinterState;

@synthesize inspectionID  = _inspectionID;
//@synthesize roadInspectVC = _roadInspectVC;

//@synthesize firstView;
//@synthesize secondView;
@synthesize isWeatherFirstOrWeatherSecond;
//@synthesize pdfFormatFileURL;
//@synthesize pdfFileURL;

- (void)viewDidLoad{
    self.constructionList=[[InspectionConstruction inspectionConstructionInfoForID:@""] mutableCopy];
    self.constructionList=[[ MaintainPlanCheck maintainCheckForID:@""] mutableCopy];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.ButtonfuJian setHidden:YES];
    
    NSArray * array = [MaintainPlan allMaintainPlan];
    for (int i = 0; i<[array count]; i++) {
        MaintainPlan * plan = array[i];
        if ([plan.is_finish intValue] == 0) {
            [self.constructionList addObject:plan];
        }
    }
    [self.textProject setEnabled:NO];
    [self.Fuzeren setEnabled:NO];
    [self.stattdate setEnabled:NO];
    [self.endDate setEnabled:NO];
    
    
    self.navigationItem.title=@"施工检查";
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated{
    //生成巡查记录
//    if (self.roadInspectVC && [[self.navigationController visibleViewController] isEqual:self.roadInspectVC]) {
//        if (![self.inspectionID isEmpty]) {
//            NSString *remark;
//            NSArray *users=[[NSUserDefaults standardUserDefaults] objectForKey:INSPECTORARRAYKEY];
//            NSString*usersname=[[NSString alloc]init];
//            for (NSString *name in users) {
//                if([usersname isEmpty])
//                    usersname = name;
//                else
//                    usersname = [usersname stringByAppendingFormat:@",%@",name];
//            }
//            NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
//            [formatter setLocale:[NSLocale currentLocale]];
//            [formatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
////            NSDate * check_date=[formatter dateFromString:self.check_date.text];
//            [formatter setDateFormat:@"HH时mm分"];
////            NSString*time=[formatter stringFromDate:check_date];
//            /*
//            10:14，当班巡至（粤高速）S32往西K06+600M与K08+500M，恒建进行XXX施工，封闭XX车道，现场有/无人员施工，标志标牌摆放符合规范。
//            10:14，当班巡至（粤高速）S32往西K06+600M与K08+500M，恒建进行XXX施工，封闭XX车道，现场有/无人员施工，标志标牌摆放不符合规范/施工人员不穿反光衣/上游封闭区过短/未封闭施工区域，已现场开具整改通知书/停工通知书/已通知现场负责人整改，已现场整改完毕/已限期X天整改/已停工。
//*/
////            if(self.weiguiSwitch.isOn)
////                remark =[NSString stringWithFormat:@"%@当班巡至%@，%@进行%@施工，封闭%@车道，现场有人员施工，标志标牌摆放不符合规范/施工人员不穿反光衣/上游封闭区过短/未封闭施工区域，已现场开具整改通知书/停工通知书/已通知现场负责人整改，已现场整改完毕/已限期X天整改/已停工。",time, self.textDidian.text,self.textShiGongDanWei.text,self.textProject.text,self.textchedao.text];
////            else
////                remark =[NSString stringWithFormat:@"%@当班巡至%@，%@进行%@施工，封闭%@车道，现场有人员施工，标志标牌摆放符合规范。",time, self.textDidian.text,self.textShiGongDanWei.text,self.textProject.text,self.textchedao.text];
//            [self.roadInspectVC  createRecodeByShiGongCheck:self.constructionID withRemark:remark];
//            [self setInspectionID:nil];
//            [self setRoadInspectVC:nil];
//        }
//    }
    [super viewWillDisappear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.constructionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier  = @"MaintainCheckCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    MaintainPlanCheck * constructionInfo=[self.constructionList objectAtIndex:indexPath.row];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"MM月dd日HH时"];
//    [formatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    MaintainPlan * maintainplan = self.constructionList[indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",maintainplan.project_name,[formatter stringFromDate:maintainplan.date_start]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",maintainplan.project_name,[formatter stringFromDate:maintainplan.date_start]];
    cell.textLabel.backgroundColor=[UIColor clearColor];
//    NSString *local=@"";
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",maintainplan.project_address,maintainplan.org_principal];
    cell.textLabel.backgroundColor=[UIColor clearColor];
//    if (constructionInfo.isuploaded.boolValue) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MaintainPlan * maintainplan = self.constructionList[indexPath.row];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
//    self.check_date.text =[formatter stringFromDate:checkInfo.check_date];
//    self.textchecker.text       = checkInfo.checker;
    self.maintainPlanID         = maintainplan.myid;
    self.textProject.text       = maintainplan.project_name;
    self.stattdate.text = [formatter stringFromDate:maintainplan.date_start];
    self.endDate.text = [formatter stringFromDate:maintainplan.realy_end_time];
    self.Fuzeren.text = maintainplan.org_principal;
    self.textShiGongDanWei.text = maintainplan.construct_org;
    self.textDidian.text = maintainplan.project_address;
    self.textchedao.text = maintainplan.close_desc;
    self.tel_phone.text = maintainplan.tel_number;
    //所有控制表格中行高亮的代码都只在这里
    [self.tableCloseList deselectRowAtIndexPath:[self.tableCloseList indexPathForSelectedRow] animated:YES];
    [self.tableCloseList selectRowAtIndexPath:indexPath animated:nil scrollPosition:nil];
}
//- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self tableView:tableCloseList didSelectRowAtIndexPath:indexPath];
//}

- (IBAction)DailyRoadWorkCheckClick:(id)sender {
    if ([self projrctisSelected]) {
        UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        DailyRoadWorkViewController * dailyroadworkcheck =[mainstoryboard instantiateViewControllerWithIdentifier:@"DailyRoadWorkCheck"];
        dailyroadworkcheck.planID = self.maintainPlanID;
        [self.navigationController pushViewController:dailyroadworkcheck animated:YES];
    }
}
- (IBAction)SpecialProjectCheckClick:(id)sender {
    if ([self projrctisSelected]) {
        __weak typeof(self)weakself = self;
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"" message:@"请选择所做的专项检查"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"养护施工作业专项安全检查" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            MaintainCheckSpecialJobVC * CheckSpecialJobVC =[mainstoryboard instantiateViewControllerWithIdentifier:@"CheckSpecialJobVC"];
//            MaintainCheckSpecialJobVC * CheckSpecialJobVC = [[MaintainCheckSpecialJobVC alloc] init];
            CheckSpecialJobVC.planID = self.maintainPlanID;
            CheckSpecialJobVC.title = @"养护施工作业专项安全检查";
            [weakself.navigationController pushViewController:CheckSpecialJobVC animated:YES];
        }];
        [ac addAction:doneAction];
        UIAlertAction *doneAction1 = [UIAlertAction actionWithTitle:@"养护施工作业控制区布置专项安全检查" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            MaintainCheckSpecialControlAreaVC * CheckSpecialControlAreaVC =[mainstoryboard instantiateViewControllerWithIdentifier:@"CheckSpecialControlAreaVC"];
            CheckSpecialControlAreaVC.planID = self.maintainPlanID;
            CheckSpecialControlAreaVC.title = @"养护施工作业控制区布置专项安全检查";
            [weakself.navigationController pushViewController:CheckSpecialControlAreaVC animated:YES];
        }];
        [ac addAction:doneAction1];
        UIAlertAction *doneAction2 = [UIAlertAction actionWithTitle:@"养护施工作业现场专项安全检查" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            MaintainCheckSpecialScenceVC * CheckSpecialScenceVC =[mainstoryboard instantiateViewControllerWithIdentifier:@"CheckSpecialScenceVC"];
            CheckSpecialScenceVC.planID = self.maintainPlanID;
            CheckSpecialScenceVC.title = @"养护施工作业现场专项安全检查";
            [weakself.navigationController pushViewController:CheckSpecialScenceVC animated:YES];
        }];
        [ac addAction:doneAction2];
        UIAlertAction *doneAction3 = [UIAlertAction actionWithTitle:@"养护施工完成后专项安全检查" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            MaintainCheckSpecialFinishVC * CheckSpecialFinishVC =[mainstoryboard instantiateViewControllerWithIdentifier:@"CheckSpecialFinishVC"];
            CheckSpecialFinishVC.planID = self.maintainPlanID;
            CheckSpecialFinishVC.title = @"养护施工完成后专项安全检查";
            [weakself.navigationController pushViewController:CheckSpecialFinishVC animated:YES];
        }];
        [ac addAction:doneAction3];
        UIAlertAction *doneAction4 = [UIAlertAction actionWithTitle:@"专项施工交安设施设置检查" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            UIStoryboard *mainstoryboard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            MaintainCheckSpecialTrafficSecurityFacilityVC * CheckSpecialTrafficSecurityFacilityVC =[mainstoryboard instantiateViewControllerWithIdentifier:@"CheckSpecialTrafficSecurityFacilityVC"];
            CheckSpecialTrafficSecurityFacilityVC.planID = self.maintainPlanID;
            CheckSpecialTrafficSecurityFacilityVC.title = @"专项施工交安设施设置检查";
            [weakself.navigationController pushViewController:CheckSpecialTrafficSecurityFacilityVC animated:YES];
        }];
        [ac addAction:doneAction4];
        [weakself.navigationController presentViewController:ac animated:YES completion:nil];
    }
}
    
- (BOOL)projrctisSelected{
    if (!self.maintainPlanID) {
        __weak typeof(self)weakself = self;
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择施工项目"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:cancelAction];
        [weakself.navigationController presentViewController:ac animated:YES completion:nil];
        return NO;
    }
    return YES;
}
@end
