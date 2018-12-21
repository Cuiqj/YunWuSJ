//
//  MaintainCheckSpecialJobVC.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/6.
//

#import "MaintainCheckSpecialJobVC.h"
#import "MaintainCheckSpecialJob.h"
#import "MaintainCheckSpecial.h"
#import "MaintainPlan.h"
#import "UserInfo.h"
#import "OrgInfo.h"
#import "DateSelectController.h"
#import "UserPickerViewController.h"
#import "AttachmentViewController.h"
#import "CasePhoto.h"

@interface MaintainCheckSpecialJobVC ()

@property (nonatomic,retain) NSString * specialID;
@property (nonatomic,retain) NSArray * dataarray;
@property (nonatomic,retain) MaintainCheckSpecial * CheckSpecial;
@property (nonatomic,retain) UIPopoverController *pickerPopover;
@property (nonatomic,retain) NSIndexPath * selectedindexpath;
@property NSInteger Kselectedtag;


@property (nonatomic,retain) MaintainCheckSpecialJob * CheckSpecialJob;

@end


@implementation MaintainCheckSpecialJobVC
//保存数据
- (void)btnsaveData{
    self.CheckSpecial.name = self.textname.text;
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    self.CheckSpecial.date = [dateformatter dateFromString:self.textdate.text];
    self.CheckSpecialJob.finish_date = [dateformatter dateFromString:self.textfinish_date.text];
    
    self.CheckSpecialJob.scene_manage_1 = self.textscene_manage_1.text;
    self.CheckSpecialJob.scene_manage_2 = self.textscene_manage_2.text;
    self.CheckSpecialJob.scene_manage_3 = self.textscene_manage_3.text;
    self.CheckSpecialJob.scene_manage_4 = self.textscene_manage_4.text;
    
    self.CheckSpecialJob.machine_material_1 = self.textmachine_marterial_1.text;
    self.CheckSpecialJob.machine_material_2 = self.textmachine_marterial_2.text;
    self.CheckSpecialJob.machine_material_3 = self.textmachine_marterial_3.text;
    self.CheckSpecialJob.machine_material_4 = self.textmachine_marterial_4.text;
    
    self.CheckSpecialJob.security_equipment_1 = self.textsecurity_equipment_1.text;
    self.CheckSpecialJob.security_equipment_2 = self.textsecurity_equipment_2.text;
    self.CheckSpecialJob.security_equipment_3 = self.textsecurity_equipment_3.text;
    self.CheckSpecialJob.security_equipment_4 = self.textsecurity_equipment_4.text;
    self.CheckSpecialJob.maintain_construct_1 = self.textmaintain_construct_1.text;
    self.CheckSpecialJob.maintain_construct_2 = self.textmaintain_construct_2.text;
    self.CheckSpecialJob.maintain_construct_3 = self.textmaintain_construct_3.text;
    self.CheckSpecialJob.maintain_construct_4 = self.textmaintain_construct_4.text;
    self.CheckSpecialJob.maintain_construct_5 = self.textmaintain_construct_5.text;
    self.CheckSpecialJob.maintain_construct_6 = self.textmaintain_construct_6.text;
    self.CheckSpecialJob.maintain_construct_7 = self.textmaintain_construct_7.text;
    self.CheckSpecialJob.maintain_construct_8 = self.textmaintain_construct_8.text;
    self.CheckSpecialJob.maintain_construct_9 = self.textmaintain_construct_9.text;
    self.CheckSpecialJob.other = self.textother.text;
    self.CheckSpecialJob.recheck = self.textviewrecheck.text;
    
    self.CheckSpecialJob.project_address = self.textproject_address.text;
    self.CheckSpecialJob.manage_unit = self.textmanage_unit.text;
    
    [[AppDelegate App] saveContext];
}
//展示空或着内容
- (void)zhanshiforspecialIDOrNot:(NSString *)showname{
    
    MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
    self.textproject_address.text = showname ? self.CheckSpecialJob.project_address : plan.project_address;
    self.textmanage_unit.text = showname ? self.CheckSpecialJob.manage_unit : [OrgInfo orgInfoFororgshortname:plan.org_id];
    
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    self.textfinish_date.text = showname ? [dateformatter stringFromDate:self.CheckSpecialJob.finish_date] :@"";
    self.textdate.text = showname ? [dateformatter stringFromDate:self.CheckSpecial.date] : @"";
    self.textname.text = showname ? self.CheckSpecial.name : @"";
    self.textscene_manage_1.text = showname ? self.CheckSpecialJob.scene_manage_1 : @"";
    self.textscene_manage_2.text = showname ? self.CheckSpecialJob.scene_manage_2 : @"";
    self.textscene_manage_3.text = showname ? self.CheckSpecialJob.scene_manage_3 : @"";
    self.textscene_manage_4.text = showname ? self.CheckSpecialJob.scene_manage_4 : @"";
    
    self.textmachine_marterial_1.text = showname ? self.CheckSpecialJob.machine_material_1 : @"";
    self.textmachine_marterial_2.text = showname ? self.CheckSpecialJob.machine_material_2 : @"";
    self.textmachine_marterial_3.text = showname ? self.CheckSpecialJob.machine_material_3 : @"";
    self.textmachine_marterial_4.text = showname ? self.CheckSpecialJob.machine_material_4 : @"";
    
    self.textsecurity_equipment_1.text = showname ? self.CheckSpecialJob.security_equipment_1 : @"";
    self.textsecurity_equipment_2.text = showname ? self.CheckSpecialJob.security_equipment_2 : @"";
    self.textsecurity_equipment_3.text = showname ? self.CheckSpecialJob.security_equipment_3 : @"";
    self.textsecurity_equipment_4.text = showname ? self.CheckSpecialJob.security_equipment_4 : @"";
    self.textmaintain_construct_1.text = showname ? self.CheckSpecialJob.maintain_construct_1 : @"";
    self.textmaintain_construct_2.text = showname ? self.CheckSpecialJob.maintain_construct_2 : @"";
    self.textmaintain_construct_3.text = showname ? self.CheckSpecialJob.maintain_construct_3 : @"";
    self.textmaintain_construct_4.text = showname ? self.CheckSpecialJob.maintain_construct_4 : @"";
    self.textmaintain_construct_5.text = showname ? self.CheckSpecialJob.maintain_construct_5 : @"";
    self.textmaintain_construct_6.text = showname ? self.CheckSpecialJob.maintain_construct_6 : @"";
    self.textmaintain_construct_7.text = showname ? self.CheckSpecialJob.maintain_construct_7 : @"";
    self.textmaintain_construct_8.text = showname ? self.CheckSpecialJob.maintain_construct_8 : @"";
    self.textmaintain_construct_9.text = showname ? self.CheckSpecialJob.maintain_construct_9 : @"";
    self.textother.text = showname ? self.CheckSpecialJob.other : @"";
    self.textviewrecheck.text = showname ? self.CheckSpecialJob.recheck : @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
    self.textproject_address.text = plan.project_address;
    self.textmanage_unit.text = [OrgInfo orgInfoFororgshortname:plan.org_id];
    
    // Do any additional setup after loading the view.
//    [self.ButtonFuJian setHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableviewList.dataSource = self;
    self.tableviewList.delegate = self;
    //     scrollview 滑动到下面
    self.scrollview.frame = CGRectMake(235, 0, 800, 600);
    self.scrollview.contentSize = CGSizeMake(800, 720);
    self.dataarray = [MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"1"];
    
    self.textdate.tag = 555;
    self.textfinish_date.tag = 666;
    self.textname.tag = 777;
    self.textname.delegate = self;
    self.textdate.delegate = self;
    self.textfinish_date.delegate = self;
    
    self.scrollview.clipsToBounds = YES;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag==666) {
        [self Selectdate:self.textfinish_date];
        return NO;
    }else if (textField.tag==555) {
        [self Selectdate:self.textdate];
        return NO;
    }else if (textField.tag==777){
        [self SelectCkeckUser:self.textname];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    self.CheckSpecialJob = [MaintainCheckSpecialJob MaintainCheckSpecialJobforspecialID:special.myid];
    NSArray * photos = [CasePhoto casePhotos:self.CheckSpecialJob.myid];
    for (id photo in photos) {
        [context deleteObject:photo];
    }
    [context deleteObject:self.CheckSpecialJob];
    [context deleteObject:obj];
//    [self.dataarray removeObjectAtIndex:indexPath.row];
    [[AppDelegate App] saveContext];
    //删除tableviewcell
//    [tableView beginUpdates];
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
//    [tableView endUpdates];
    self.dataarray = [MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"1"];
    [self.tableviewList reloadData];
    [self BtnaddClick:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier  = @"CheckSpecialJobVCcell";
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
    self.CheckSpecialJob = [MaintainCheckSpecialJob MaintainCheckSpecialJobforspecialID:self.specialID];
    self.selectedindexpath = indexPath;
    [self zhanshiforspecialIDOrNot:@"显示"];
    //所有控制表格中行高亮的代码都只在这里
    [self.tableviewList deselectRowAtIndexPath:[self.tableviewList indexPathForSelectedRow] animated:YES];
    [self.tableviewList selectRowAtIndexPath:indexPath animated:nil scrollPosition:nil];
}
- (IBAction)Selectdate:(id)sender {
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
        if (self.Kselectedtag == 555){
            frame = CGRectMake(frame.origin.x+240, frame.origin.y, frame.size.width, frame.size.height);
        }
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
        self.textfinish_date.text = [formator stringFromDate:date];
    }
    
}
- (IBAction)SelectCkeckUser:(id)sender {
    UITextField * textfield = (UITextField *)sender;
     CGRect frame = CGRectMake(textfield.frame.origin.x+240, textfield.frame.origin.y, textfield.frame.size.width, textfield.frame.size.height);
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
    if (self.textname.text.length>0) {
        self.textname.text = [NSString stringWithFormat:@"%@、%@",self.textname.text,name];
    }else{
        self.textname.text = name;
    }
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
        self.CheckSpecialJob = [MaintainCheckSpecialJob MaintainCheckSpecialJobforspecialID:self.CheckSpecial.myid];
        [self btnsaveData];
        self.dataarray = [MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"1"];
        [self.tableviewList reloadData];
        [self tableView:self.tableviewList didSelectRowAtIndexPath:self.selectedindexpath];
        return;
    }else{
        //新建表
        self.CheckSpecial = [MaintainCheckSpecial newDataObjectWithEntityName:@"MaintainCheckSpecial"];
        self.specialID = self.CheckSpecial.myid;
        self.CheckSpecial.maintain_plan_id = self.planID;
        self.CheckSpecial.type = @"1";
        self.CheckSpecialJob = [MaintainCheckSpecialJob newDataObjectWithEntityName:@"MaintainCheckSpecialJob"];
        self.CheckSpecialJob.special_check_id = self.specialID;
//        NSString *currentUserID=[[NSUserDefaults standardUserDefaults] stringForKey:USERKEY];
//        self.CheckSpecialJob.manage_unit = [[OrgInfo orgInfoForOrgID:[UserInfo userInfoForUserID:currentUserID].organization_id] valueForKey:@"orgname"];
        //路段名称
        MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
        self.CheckSpecialJob.project_address = plan.project_address;
        self.CheckSpecialJob.manage_unit = [OrgInfo orgInfoFororgshortname:plan.org_id];
        [self btnsaveData];
        [[AppDelegate App] saveContext];
    }
    self.dataarray =[MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"1"];
    [self.tableviewList reloadData];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:self.tableviewList didSelectRowAtIndexPath:indexPath];
}
- (IBAction)BtnaddClick:(id)sender {
    self.specialID = @"";
    self.CheckSpecial = nil;
    self.CheckSpecialJob = nil;
    [self zhanshiforspecialIDOrNot:nil];
    [self.tableviewList deselectRowAtIndexPath:self.selectedindexpath animated:NO];
}

- (IBAction)DeleteUserData:(id)sender {
    self.textname.text = @"";
}
- (IBAction)BtnFuJianClick:(id)sender {
    if(self.CheckSpecialJob.myid.length >0){
        
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
    [next setValue:self.CheckSpecialJob.myid forKey:@"constructionId"];
    [self.navigationController pushViewController:next animated:YES];
    
}
@end
