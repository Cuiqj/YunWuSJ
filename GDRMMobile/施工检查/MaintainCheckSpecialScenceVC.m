//
//  MaintainCheckSpecialScenceVC.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/6.
//

#import "MaintainCheckSpecialScenceVC.h"
#import "MaintainCheckSpecialScence.h"
#import "MaintainCheckSpecial.h"
#import "MaintainPlan.h"
#import "UserInfo.h"
#import "OrgInfo.h"
#import "DateSelectController.h"
#import "UserPickerViewController.h"
#import "AttachmentViewController.h"

#import "CasePhoto.h"

@interface MaintainCheckSpecialScenceVC ()
@property (nonatomic,retain) NSString * specialID;
@property (nonatomic,retain) NSArray * dataarray;
@property (nonatomic,retain) MaintainCheckSpecial * CheckSpecial;
@property (nonatomic,retain) UIPopoverController *pickerPopover;
@property (nonatomic,retain) NSIndexPath * selectedindexpath;
@property (nonatomic,retain) MaintainCheckSpecialScence * CheckSpecialScence;

@property NSInteger Kselectedtag;


@end

@implementation MaintainCheckSpecialScenceVC

//保存数据
- (void)btnsaveData{
    self.CheckSpecial.name = self.textUser.text;
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    self.CheckSpecial.date = [dateformatter dateFromString:self.textdate.text];
    self.CheckSpecialScence.finish_date = [dateformatter dateFromString:self.textfinish_date.text];
    self.CheckSpecialScence.lay_rank = self.textlay_rank.text;
    self.CheckSpecialScence.sign_1 = self.textsign_1.text;
    self.CheckSpecialScence.sign_2 = self.textsign_2.text;
    self.CheckSpecialScence.sign_3 = self.textsign_3.text;
    self.CheckSpecialScence.sign_4 = self.textsign_4.text;
    self.CheckSpecialScence.sign_5 = self.textsign_5.text;
    self.CheckSpecialScence.sign_6 = self.textsign_6.text;
    self.CheckSpecialScence.sign_7 = self.textsign_7.text;
    self.CheckSpecialScence.lighting_facility = self.textlighting_facility.text;
    self.CheckSpecialScence.workspace_doorway = self.textworkspace_doorway.text;
    self.CheckSpecialScence.tunnel_construct = self.texttunnel_construct.text;
    self.CheckSpecialScence.other = self.textother.text;
    self.CheckSpecialScence.recheck = self.textrecheck.text;
    //主表获取或修改过数据保存
//    MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
    self.CheckSpecialScence.project_address = self.textproject_address.text;
    self.CheckSpecialScence.manage_unit = self.textmanage_unit.text;
    [[AppDelegate App] saveContext];
}
//展示空或者加载内容
- (void)zhanshiforspecialIDOrNot:(NSString *)showname{
    MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
    self.textproject_address.text = showname ? self.CheckSpecialScence.project_address : plan.project_address;
    self.textmanage_unit.text = showname ? self.CheckSpecialScence.manage_unit : [OrgInfo orgInfoFororgshortname:plan.org_id];
    
    
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:@"yyyy年MM月dd日HH时mm分"];
    self.textfinish_date.text = showname ? [dateformatter stringFromDate:self.CheckSpecialScence.finish_date] :@"";
    self.textdate.text = showname ? [dateformatter stringFromDate:self.CheckSpecial.date] : @"";
    self.textUser.text = showname ? self.CheckSpecial.name : @"";
    self.textlay_rank.text = showname ? self.CheckSpecialScence.lay_rank : @"";
    self.textsign_1.text = showname ? self.CheckSpecialScence.sign_1 : @"";
    self.textsign_2.text = showname ? self.CheckSpecialScence.sign_2 : @"";
    self.textsign_3.text = showname ? self.CheckSpecialScence.sign_3 : @"";
    self.textsign_4.text = showname ? self.CheckSpecialScence.sign_4 : @"";
    self.textsign_5.text = showname ? self.CheckSpecialScence.sign_5 : @"";
    self.textsign_6.text = showname ? self.CheckSpecialScence.sign_6 : @"";
    self.textsign_7.text = showname ? self.CheckSpecialScence.sign_7 : @"";
    
    self.textlighting_facility.text = showname ? self.CheckSpecialScence.lighting_facility : @"";
    self.textworkspace_doorway.text = showname ? self.CheckSpecialScence.workspace_doorway : @"";
    self.texttunnel_construct.text = showname ? self.CheckSpecialScence.tunnel_construct : @"";
    self.textother.text = showname ? self.CheckSpecialScence.other : @"";
    self.textrecheck.text = showname ? self.CheckSpecialScence.recheck : @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MaintainPlan * plan = [MaintainPlan maintainPlanInfoForID:self.planID];
    self.textproject_address.text = plan.project_address;
    self.textmanage_unit.text = [OrgInfo orgInfoFororgshortname:plan.org_id];
    
    // Do any additional setup after loading the view.
    self.scrollview.contentSize = CGSizeMake(790, 651);
//    [self.attachmentButton setHidden:YES];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableviewList.dataSource = self;
    self.tableviewList.delegate = self;
    //     scrollview 滑动到下面
    self.dataarray = [MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"3"];
    
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
//    id obj=[self.dataarray objectAtIndex:indexPath.row];
    MaintainCheckSpecial * special = (MaintainCheckSpecial *)self.dataarray[indexPath.row];
    if ([special.myid isEqualToString:self.specialID]) {
        self.specialID = @"";
    }
    self.CheckSpecialScence = [MaintainCheckSpecialScence MaintainCheckSpecialScenceforspecialID:special.myid];
    NSArray * photos = [CasePhoto casePhotos:self.CheckSpecialScence.myid];
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    for (id photo in photos) {
        [context deleteObject:photo];
    }
    if (self.CheckSpecialScence) {
        [context deleteObject:self.CheckSpecialScence];
    }
    [context deleteObject:special];
    [[AppDelegate App] saveContext];
    self.dataarray = [MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"3"];
    [self.tableviewList reloadData];
    [self BtnaddClick:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier  = @"CheckSpecialScencecell";
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
    self.CheckSpecialScence = [MaintainCheckSpecialScence MaintainCheckSpecialScenceforspecialID:self.specialID];
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
        self.CheckSpecialScence = [MaintainCheckSpecialScence MaintainCheckSpecialScenceforspecialID:self.CheckSpecial.myid];
        [self btnsaveData];
        self.dataarray =[MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"3"];
        [self.tableviewList reloadData];
        [self tableView:self.tableviewList didSelectRowAtIndexPath:self.selectedindexpath];
        return;
    }else{
        //新建表
        self.CheckSpecial = [MaintainCheckSpecial newDataObjectWithEntityName:@"MaintainCheckSpecial"];
        self.specialID = self.CheckSpecial.myid;
        self.CheckSpecial.maintain_plan_id = self.planID;
        self.CheckSpecial.type = @"3";
        self.CheckSpecialScence = [MaintainCheckSpecialScence newDataObjectWithEntityName:@"MaintainCheckSpecialScence"];
        self.CheckSpecialScence.special_check_id = self.specialID;
        [[AppDelegate App] saveContext];
        [self btnsaveData];
        
    }
    self.dataarray =[MaintainCheckSpecial allMaintainCheckSpecialforMaintain_planid:self.planID withtype:@"3"];
    [self.tableviewList reloadData];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self tableView:self.tableviewList didSelectRowAtIndexPath:indexPath];
}

- (IBAction)BtnaddClick:(id)sender {
    self.specialID = @"";
    self.CheckSpecial = nil;
    self.CheckSpecialScence = nil;
    [self zhanshiforspecialIDOrNot:nil];
    [self.tableviewList deselectRowAtIndexPath:self.selectedindexpath animated:NO];
}

- (IBAction)DeleteUserData:(id)sender {
    self.textUser.text = @"";
}

- (IBAction)Btntoattachment:(id)sender {
    if(self.CheckSpecialScence.myid.length >0){
        
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
    [next setValue:self.CheckSpecialScence.myid forKey:@"constructionId"];
    [self.navigationController pushViewController:next animated:YES];
}

- (IBAction)SelectDate:(id)sender {
    UITextField * textfield = (UITextField *)sender;
    self.Kselectedtag = textfield.tag;
    textfield.delegate = self;
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        DateSelectController *dsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
        dsVC.delegate = self;
        dsVC.pickerType = 1;
        dsVC.datePicker.maximumDate = [NSDate date];
        [dsVC showdate:self.textdate.text];
        CGRect frame= textfield.frame;
        if (textfield.tag == 555) {
            frame = CGRectMake(frame.origin.x+230, frame.origin.y, frame.size.width, frame.size.height);
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
