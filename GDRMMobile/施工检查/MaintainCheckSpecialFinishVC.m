//
//  MaintainCheckSpecialFinishVC.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import "MaintainCheckSpecialFinishVC.h"
#import "MaintainCheckSpecialFinish.h"
#import "MaintainCheckSpecial.h"
#import "MaintainPlan.h"
#import "UserInfo.h"
#import "OrgInfo.h"
#import "DateSelectController.h"
#import "UserPickerViewController.h"
#import "AttachmentViewController.h"
#import "CasePhoto.h"

@interface MaintainCheckSpecialFinishVC ()
@property (nonatomic,retain) NSString * specialID;
@property (nonatomic,retain) NSArray * dataarray;
@property (nonatomic,retain) MaintainCheckSpecial * CheckSpecial;
@property (nonatomic,retain) UIPopoverController *pickerPopover;
@property (nonatomic,retain) NSIndexPath * selectedindexpath;

@property (nonatomic,retain) MaintainCheckSpecialFinish * CheckSpecialFinish;
@property NSInteger Kselectedtag;

@end

@implementation MaintainCheckSpecialFinishVC

//保存数据
- (void)btnsaveData{
    self.CheckSpecial.name = self.textUser.text;
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:Date_version_yyyy];
    self.CheckSpecial.date = [dateformatter dateFromString:self.textdate.text];
    self.CheckSpecialFinish.finish_date = [dateformatter dateFromString:self.textfinish_date.text];
    self.CheckSpecialFinish.remove_rank = self.textremove_rank.text;
    self.CheckSpecialFinish.traffic_security_facility = self.texttraffic_security_facility.text;
    self.CheckSpecialFinish.other = self.textother.text;
    self.CheckSpecialFinish.recheck = self.textrecheck.text;
    
    self.CheckSpecialFinish.project_address = self.textproject_address.text;
    self.CheckSpecialFinish.manage_unit = self.textmanage_unit.text;
    [[AppDelegate App] saveContext];
}
//展示空或者加载内容
- (void)zhanshiforspecialIDOrNot:(NSString *)showname{
    
    MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
    self.textproject_address.text = showname ? self.CheckSpecialFinish.project_address : plan.project_address;
    self.textmanage_unit.text = showname ? self.CheckSpecialFinish.manage_unit : [OrgInfo orgInfoFororgshortname:plan.org_id];
    
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:Date_version_yyyy];
    self.textfinish_date.text = showname ? [dateformatter stringFromDate:self.CheckSpecialFinish.finish_date] :@"";
    self.textdate.text = showname ? [dateformatter stringFromDate:self.CheckSpecial.date] : @"";
    self.textUser.text = showname ? self.CheckSpecial.name : @"";
    self.textremove_rank.text = showname ? self.CheckSpecialFinish.remove_rank : @"";
    self.texttraffic_security_facility.text = showname ? self.CheckSpecialFinish.traffic_security_facility : @"";
    self.textother.text = showname ? self.CheckSpecialFinish.other : @"";
    self.textrecheck.text = showname ? self.CheckSpecialFinish.recheck : @"";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.attachmentButton setHidden:YES];
    self.scrollview.contentSize = CGSizeMake(790, 481);
    
    MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
    self.textproject_address.text = plan.project_address;
    self.textmanage_unit.text = [OrgInfo orgInfoFororgshortname:plan.org_id];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableviewList.dataSource = self;
    self.tableviewList.delegate = self;
    //     scrollview 滑动到下面
    self.dataarray = [MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"4"];
    
    self.textdate.tag = 555;
    self.textfinish_date.tag = 666;
    self.textUser.tag = 777;
    
    self.textdate.delegate = self;
    self.textUser.delegate = self;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag==666) {
        [self SelectDate:self.textfinish_date];
        return NO;
    }else if (textField.tag==555) {
        [self SelectDate:self.textdate];
        return NO;
    }else if (textField.tag==777){
        [self SelectUser:self.textUser];
        return NO;
    }
    return YES;
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
    self.CheckSpecialFinish = [MaintainCheckSpecialFinish MaintainCheckSpecialFinishforspecialID:special.myid];
    NSArray * photos = [CasePhoto casePhotos:self.CheckSpecialFinish.myid];
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    for (id photo in photos) {
        [context deleteObject:photo];
    }
    [context deleteObject:self.CheckSpecialFinish];
    [context deleteObject:obj];
    [[AppDelegate App] saveContext];
    self.dataarray = [MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"4"];
    [self.tableviewList reloadData];
    [self BtnaddClick:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier  = @"CheckSpecialFinishcell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:Date_version_yyyy];
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
    self.CheckSpecialFinish = [MaintainCheckSpecialFinish MaintainCheckSpecialFinishforspecialID:self.specialID];
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
        self.CheckSpecialFinish = [MaintainCheckSpecialFinish MaintainCheckSpecialFinishforspecialID:self.CheckSpecial.myid];
        [self btnsaveData];
        self.dataarray =[MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"4"];
        [self.tableviewList reloadData];
        [self tableView:self.tableviewList didSelectRowAtIndexPath:self.selectedindexpath];
        return;
    }else{
        //新建表
        self.CheckSpecial = [MaintainCheckSpecial newDataObjectWithEntityName:@"MaintainCheckSpecial"];
        self.specialID = self.CheckSpecial.myid;
        self.CheckSpecial.maintain_plan_id = self.planID;
        self.CheckSpecial.type = @"4";
        self.CheckSpecialFinish = [MaintainCheckSpecialFinish newDataObjectWithEntityName:@"MaintainCheckSpecialFinish"];
        NSString *currentUserID=[[NSUserDefaults standardUserDefaults] stringForKey:USERKEY];
        self.CheckSpecialFinish.manage_unit = [[OrgInfo orgInfoForOrgID:[UserInfo userInfoForUserID:currentUserID].organization_id] valueForKey:@"orgname"];
        //路段名称
//        MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
//        self.CheckSpecialFinish.project_address = plan.project_address;
        self.CheckSpecialFinish.special_check_id = self.specialID;
        [self btnsaveData];
        [[AppDelegate App] saveContext];
    }
    self.dataarray =[MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"4"];
    [self.tableviewList reloadData];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:self.tableviewList didSelectRowAtIndexPath:indexPath];
}

- (IBAction)BtnaddClick:(id)sender {
    self.specialID = @"";
    self.CheckSpecial = nil;
    self.CheckSpecialFinish = nil;
    [self zhanshiforspecialIDOrNot:nil];
    [self.tableviewList deselectRowAtIndexPath:self.selectedindexpath animated:NO];
}

- (IBAction)DeleteUserClick:(id)sender {
    self.textUser.text = @"";
}

- (IBAction)Btntoattachment:(id)sender {
    if(self.CheckSpecialFinish.myid.length >0){
        
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
    [next setValue:self.CheckSpecialFinish.myid forKey:@"constructionId"];
    [self.navigationController pushViewController:next animated:YES];
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
    [formator setDateFormat:Date_version_yyyy];
    if (self.Kselectedtag == 555) {
        self.textdate.text = [formator stringFromDate:date];
    }else if (self.Kselectedtag == 666){
        self.textfinish_date.text = [formator stringFromDate:date];
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
