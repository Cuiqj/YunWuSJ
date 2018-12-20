//
//  MaintainCheckSpecialTrafficSecurityFacilityVC.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import "MaintainCheckSpecialTrafficSecurityFacilityVC.h"
#import "MaintainCheckSpecialTrafficSecurityFacility.h"
#import "MaintainCheckSpecial.h"
#import "MaintainPlan.h"
#import "UserInfo.h"
#import "OrgInfo.h"
#import "DateSelectController.h"
#import "UserPickerViewController.h"
#import "CasePhoto.h"

#import "AttachmentViewController.h"
@interface MaintainCheckSpecialTrafficSecurityFacilityVC ()
@property (nonatomic,retain) NSString * specialID;
@property (nonatomic,retain) NSArray * dataarray;
@property (nonatomic,retain) MaintainCheckSpecial * CheckSpecial;
@property (nonatomic,retain) UIPopoverController * pickerPopover;

@property (nonatomic,retain) MaintainCheckSpecialTrafficSecurityFacility * CheckSpecialTraffic;
@property (nonatomic,retain) NSIndexPath * selectedindexpath;

@property NSInteger Kselectedtag;


@end

@implementation MaintainCheckSpecialTrafficSecurityFacilityVC

//保存数据
- (void)btnsaveData{
    self.CheckSpecialTraffic.direction = self.textdirection.text;
    self.CheckSpecialTraffic.construct_org = self.textconstruct_org.text;
    self.CheckSpecialTraffic.construct_name = self.textconstruct_name.text;
    MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
    self.CheckSpecialTraffic.stake_end = plan.station_end;
    self.CheckSpecialTraffic.stake_start = plan.station_start;
    self.CheckSpecial.name = self.textUser.text;
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    self.CheckSpecial.date = [dateformatter dateFromString:self.textdate.text];
    self.CheckSpecialTraffic.constr_start = [dateformatter dateFromString:self.textconstr_start.text];
    self.CheckSpecialTraffic.constr_end = [dateformatter dateFromString:self.textconstr_end.text];
    self.CheckSpecialTraffic.special_item = self.textspecial_item.text;
    self.CheckSpecialTraffic.remark = self.textremark.text;
    [[AppDelegate App] saveContext];
}
//展示空或者加载内容
- (void)zhanshiforspecialIDOrNot:(NSString *)showname{
    MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    self.textconstr_end.text = self.CheckSpecialTraffic.constr_end ? [dateformatter stringFromDate:self.CheckSpecialTraffic.constr_end] :[dateformatter stringFromDate:plan.date_end];
    self.textconstr_start.text = self.CheckSpecialTraffic.constr_start ? [dateformatter stringFromDate:self.CheckSpecialTraffic.constr_start] :[dateformatter stringFromDate:plan.date_start];
    self.textdate.text = showname ? [dateformatter stringFromDate:self.CheckSpecial.date] : @"";
    self.textUser.text = showname ? self.CheckSpecial.name : @"";
    self.textspecial_item.text = showname? self.CheckSpecialTraffic.special_item : @"";
    self.textremark.text = showname ? self.CheckSpecialTraffic.remark : @"";
    self.textdirection.text = plan.project_direction;
    self.textconstruct_org.text = plan.construct_org;
    self.textconstruct_name.text = plan.org_principal;
    if(plan.station_end.integerValue != 0 && plan.station_start != 0){
        self.textstake_startandend.text = [NSString stringWithFormat:@"K%02ld+%03ldM-K%02ld+%03ldM",plan.station_start.integerValue/1000,plan.station_start.integerValue%1000,plan.station_end.integerValue/1000,plan.station_end.integerValue%1000];
    }else if (plan.station_end == 0 && plan.station_start.integerValue != 0) {
        self.textstake_startandend.text = [NSString stringWithFormat:@"K%02ld+%03ldM",plan.station_start.integerValue/1000,plan.station_start.integerValue%1000];
    }else if(plan.station_end.integerValue == 0 && plan.station_start.integerValue == 0){
        self.textstake_startandend.text = @"无";
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableviewList.dataSource = self;
    self.tableviewList.delegate = self;
    //     scrollview 滑动到下面
    self.dataarray = [MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"5"];
    
    self.textdate.tag = 555;
    self.textconstr_start.tag = 666;
    self.textconstr_end.tag = 667;
    self.textUser.tag = 777;
    [self zhanshiforspecialIDOrNot:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarray.count;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除数据库数据            检查内容删除
    id obj=[self.dataarray objectAtIndex:indexPath.row];
    MaintainCheckSpecial * special = (MaintainCheckSpecial *)self.dataarray[indexPath.row];
    if ([special.myid isEqualToString:self.specialID]) {
        self.specialID = @"";
    }
    self.CheckSpecialTraffic = [MaintainCheckSpecialTrafficSecurityFacility MaintainCheckSpecialTrafficSecurityFacilityforspecialID:special.myid];
    NSArray * photos = [CasePhoto casePhotos:self.CheckSpecialTraffic.myid];
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    for (id photo in photos) {
        [context deleteObject:photo];
    }
    [context deleteObject:self.CheckSpecialTraffic];
    [context deleteObject:obj];
    [[AppDelegate App] saveContext];
    self.dataarray = [MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"5"];
    [self.tableviewList reloadData];
    [self BtnaddClick:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier  = @"MaintainCheckSpecialTrafficSecurityFacilitycell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    MaintainCheckSpecial * special = self.dataarray[indexPath.row];
    cell.textLabel.text = [formatter stringFromDate:special.date];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    //    if (CheckDaily.isuploaded.boolValue) {
    //        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //    } else {
    //        cell.accessoryType = UITableViewCellAccessoryNone;
    //    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.CheckSpecial = (MaintainCheckSpecial *)self.dataarray[indexPath.row];
    self.specialID = self.CheckSpecial.myid;
    self.CheckSpecialTraffic = [MaintainCheckSpecialTrafficSecurityFacility MaintainCheckSpecialTrafficSecurityFacilityforspecialID:self.specialID];
    self.selectedindexpath = indexPath;
    [self zhanshiforspecialIDOrNot:@"显示"];
    //所有控制表格中行高亮的代码都只在这里
    [self.tableviewList deselectRowAtIndexPath:[self.tableviewList indexPathForSelectedRow] animated:YES];
    [self.tableviewList selectRowAtIndexPath:indexPath animated:nil scrollPosition:nil];
}

- (IBAction)BtnSaveClick:(id)sender {
    if(self.textdate.text.length>0){
        
    }else{
        __weak typeof(self)weakself = self;
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择检查时间，再保存！"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:cancelAction];
        [weakself.navigationController presentViewController:ac animated:YES completion:nil];
        return;
    }
    if (self.specialID.length >0) {
        self.CheckSpecial = [MaintainCheckSpecial MaintainCheckSpecialforMyid:self.specialID];
        self.CheckSpecialTraffic = [MaintainCheckSpecialTrafficSecurityFacility MaintainCheckSpecialTrafficSecurityFacilityforspecialID:self.CheckSpecial.myid];
        [self btnsaveData];
        [self.tableviewList reloadData];
        [self tableView:self.tableviewList didSelectRowAtIndexPath:self.selectedindexpath];
        return;
    }else{
        //新建表
        self.CheckSpecial = [MaintainCheckSpecial newDataObjectWithEntityName:@"MaintainCheckSpecial"];
        self.specialID = self.CheckSpecial.myid;
        self.CheckSpecial.maintain_plan_id = self.planID;
        self.CheckSpecial.type = @"5";
        self.CheckSpecialTraffic = [MaintainCheckSpecialTrafficSecurityFacility newDataObjectWithEntityName:@"MaintainCheckSpecialTrafficSecurityFacility"];
//        NSString *currentUserID=[[NSUserDefaults standardUserDefaults] stringForKey:USERKEY];
//        self.CheckSpecialTraffic.manage_unit = [[OrgInfo orgInfoForOrgID:[UserInfo userInfoForUserID:currentUserID].organization_id] valueForKey:@"orgname"];
        //路段名称
//        MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
//        self.CheckSpecialTraffic.project_address = plan.project_address;
        self.CheckSpecialTraffic.special_check_id = self.specialID;
        [self btnsaveData];
        [[AppDelegate App] saveContext];
    }
    self.dataarray =[MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"5"];
    [self.tableviewList reloadData];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:self.tableviewList didSelectRowAtIndexPath:indexPath];
}

- (IBAction)BtnaddClick:(id)sender {
    self.specialID = @"";
    self.CheckSpecial = nil;
    self.CheckSpecialTraffic = nil;
    [self zhanshiforspecialIDOrNot:nil];
    [self.tableviewList deselectRowAtIndexPath:self.selectedindexpath animated:NO];
}

- (IBAction)BtnFuJianClick:(id)sender {
    if(self.CheckSpecialTraffic.myid.length >0){
        
    }else{
        __weak typeof(self)weakself = self;
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择检查记录，再选择附件"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:cancelAction];
        [weakself.navigationController presentViewController:ac animated:YES completion:nil];
        return;
    }
    UIStoryboard *board            = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    AttachmentViewController *next = [board instantiateViewControllerWithIdentifier:@"AttachmentViewController"];
    [next setValue:self.CheckSpecialTraffic.myid forKey:@"constructionId"];
    [self.navigationController pushViewController:next animated:YES];
}

- (IBAction)DeleteUserData:(id)sender {
    self.textUser.text = @"";
}

- (IBAction)SelectDate:(id)sender {
    UITextField * textfield = (UITextField *)sender;
    self.Kselectedtag = textfield.tag;
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        DateSelectController *dsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
        dsVC.delegate = self;
        dsVC.pickerType = 1;
        dsVC.datePicker.maximumDate = [NSDate date];
        [dsVC showdate:self.textdate.text];
        CGRect frame= textfield.frame;
        self.pickerPopover = [[UIPopoverController alloc] initWithContentViewController:dsVC];
        [self.pickerPopover presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        dsVC.dateselectPopover = self.pickerPopover;
    }
}
-(void)setDate:(NSDate *)date forcheckdate:(NSString *)check{
    //    self.CheckSpecial.date = date;
    NSDateFormatter *formator =[[NSDateFormatter alloc]init];
    [formator setLocale:[NSLocale currentLocale]];
    [formator setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    if (self.Kselectedtag == 555) {
        self.textdate.text = [formator stringFromDate:date];
    }else if (self.Kselectedtag == 666){
        self.textconstr_start.text = [formator stringFromDate:date];
    }else if (self.Kselectedtag == 667){
        self.textconstr_end.text = [formator stringFromDate:date];
    }
}

- (IBAction)SelectUser:(id)sender {
    UITextField * textfield = (UITextField *)sender;
    CGRect frame = textfield.frame;
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        UserPickerViewController *acPicker=[[UserPickerViewController alloc] init];
        acPicker.delegate=self;
        self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:acPicker];
        [self.pickerPopover setPopoverContentSize:CGSizeMake(140, 200)];
        [self.pickerPopover presentPopoverFromRect:frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        acPicker.pickerPopover=self.pickerPopover;
    }
}
-(void)setUser:(NSString *)name andUserID:(NSString *)userID{
    if (self.textUser.text.length>0) {
        self.textUser.text = [NSString stringWithFormat:@"%@、%@",self.textUser.text,name];
    }else{
        self.textUser.text = name;
    }
}
@end
