//
//  TrafficRescueViewController.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/13.
//

#import "TrafficRescueViewController.h"
#import "UserInfo.h"
#import "OrgInfo.h"
#import "DateSelectController.h"
#import "UserPickerViewController.h"
#import "RescueRecord.h"
#import "AttachmentViewController.h"
#import "Systype.h"

#import "ListSelectViewController.h"
@interface TrafficRescueViewController ()
@property (nonatomic,retain) NSString * specialID;
@property (nonatomic,retain) NSArray * dataarray;

@property (nonatomic,retain) RescueRecord * rescuerecord;
@property (nonatomic,retain) UIPopoverController *pickerPopover;
@property (nonatomic,retain) NSIndexPath * selectedindexpath;

@property NSInteger Kselectedtag;


@end

@implementation TrafficRescueViewController


//保存数据
- (void)btnsaveData{
    //    无公司名称
    self.rescuerecord.org_id = [[OrgInfo orgInfoForSelected] valueForKey:@"myid"];
    self.rescuerecord.company = self.textorg_id.text;
    self.rescuerecord.patrol_person = self.textpatrol_person.text;
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:Date_version_yyyy];
    self.rescuerecord.notice_time = [dateformatter dateFromString:self.textnotice_time.text];
    self.rescuerecord.arrival_time = [dateformatter dateFromString:self.textarrival_time.text];
    self.rescuerecord.end_time = [dateformatter dateFromString:self.textend_time.text];
    [[AppDelegate App] saveContext];
    self.rescuerecord.sa_car = self.textsa_car.text;
    self.rescuerecord.ac_car = self.textac_car.text;
    self.rescuerecord.crew = self.textcrew.text;
    self.rescuerecord.charge = @(self.textcharge.text.integerValue);
    self.rescuerecord.sa_person = self.textsa_person.text;
    self.rescuerecord.situation = self.textviewsituation.text;
    self.rescuerecord.remark = self.textviewremark.text;
    [[AppDelegate App] saveContext];
}
//展示空或者加载内容
- (void)zhanshiforspecialIDOrNot:(NSString *)showname{
//    self.textorg_id.text = [[Systype typeValueForCodeName:@"拯救公司名称"] objectAtIndex:0];
    NSDateFormatter * dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setLocale:[NSLocale currentLocale]];
    [dateformatter setDateFormat:Date_version_yyyy];
    self.textnotice_time.text = showname ? [dateformatter stringFromDate:self.rescuerecord.notice_time] :@"";
    self.textarrival_time.text = showname ? [dateformatter stringFromDate:self.rescuerecord.arrival_time] :@"";
    self.textend_time.text = showname ? [dateformatter stringFromDate:self.rescuerecord.end_time] :@"";
    self.textorg_id.text = showname ? self.rescuerecord.company : @"";
    self.textsa_car.text = showname ? self.rescuerecord.sa_car : @"";
    self.textac_car.text = showname ? self.rescuerecord.ac_car : @"";
    self.textcrew.text = showname ? self.rescuerecord.crew : @"";
    self.textcharge.text = showname ? [NSString stringWithFormat:@"%ld",self.rescuerecord.charge.integerValue] : @"";
    self.textsa_person.text = showname ? self.rescuerecord.sa_person : @"";
    self.textpatrol_person.text = showname ? self.rescuerecord.patrol_person : @"";
    self.textviewsituation.text = showname ? self.rescuerecord.situation : @"";
    self.textviewremark.text = showname ? self.rescuerecord.remark : @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交通救援记录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableviewList.dataSource = self;
    self.tableviewList.delegate = self;
    CGRect frame = self.tableviewList.frame;
    self.tableviewList.frame = CGRectMake(frame.origin.x, frame.origin.y, 240, frame.size.height);
    [self.view addSubview:self.tableviewList];
   
    self.dataarray = [RescueRecord allRescueRecordArray];
    self.textnotice_time.tag = 555;
    self.textarrival_time.tag = 666;
    self.textend_time.tag = 777;
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
    RescueRecord * rescue = (RescueRecord *)self.dataarray[indexPath.row];
    self.specialID = @"";
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    [context deleteObject:obj];
    [[AppDelegate App] saveContext];
    self.dataarray = [RescueRecord allRescueRecordArray];
    [self.tableviewList reloadData];
    [self BtnaddClick:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier  = @"Trafficrescuecell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:Date_version_yyyy];
    RescueRecord * rescue = self.dataarray[indexPath.row];
    cell.textLabel.text = [formatter stringFromDate:rescue.notice_time];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    if (rescue.isuploaded.boolValue) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.rescuerecord = (RescueRecord *)self.dataarray[indexPath.row];
    self.specialID = self.rescuerecord.myid;
    self.selectedindexpath = indexPath;
    [self zhanshiforspecialIDOrNot:@"显示"];
    //所有控制表格中行高亮的代码都只在这里
    [self.tableviewList deselectRowAtIndexPath:[self.tableviewList indexPathForSelectedRow] animated:YES];
    [self.tableviewList selectRowAtIndexPath:indexPath animated:nil scrollPosition:nil];
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
        [dsVC showdate:self.textnotice_time.text];
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
        self.textnotice_time.text = [formator stringFromDate:date];
    }else if (self.Kselectedtag == 666){
        self.textarrival_time.text = [formator stringFromDate:date];
    }else if (self.Kselectedtag == 777){
        self.textend_time.text = [formator stringFromDate:date];
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

- (IBAction)SelectCompany:(id)sender {
    ListSelectViewController *listPicker=[self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectPoPover"];
    listPicker.delegate = self;
    listPicker.data     = [Systype typeValueForCodeName:@"拯救公司名称"];
    self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:listPicker];
    UITextField * textfield = (UITextField * )sender;
    CGRect rect         = CGRectMake(textfield.frame.origin.x,textfield.frame.origin.y,textfield.frame.size.width/3 ,textfield.frame.size.height);
    listPicker.preferredContentSize =CGSizeMake(280, 200);
    [self.pickerPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    listPicker.pickerPopover = self.pickerPopover;
   
}
- (void)setSelectData:(NSString *)data{
    self.textorg_id.text = data;
}

-(void)setUser:(NSString *)name andUserID:(NSString *)userID{
    if (self.textpatrol_person.text.length>0) {
        self.textpatrol_person.text = [NSString stringWithFormat:@"%@、%@",self.textpatrol_person.text,name];
    }else{
        self.textpatrol_person.text = name;
    }
}

- (IBAction)BtnDeleteUserData:(id)sender {
    self.textpatrol_person.text = @"";
}

- (IBAction)BtnSaveClick:(id)sender {
    if(self.textnotice_time.text.length>0 && self.textarrival_time.text.length>0){
        if (self.specialID.length >0) {
            self.rescuerecord = [RescueRecord RescueRecordformyID:self.specialID];
            [self btnsaveData];
            [self.tableviewList reloadData];
            [self tableView:self.tableviewList didSelectRowAtIndexPath:self.selectedindexpath];
            return;
        }else{
            //新建表
            self.rescuerecord = [RescueRecord newDataObjectWithEntityName:@"RescueRecord"];
            self.specialID = self.rescuerecord.myid;
            NSString *currentUserID=[[NSUserDefaults standardUserDefaults] stringForKey:USERKEY];
            //  广东粤运交通拯救有限公司
            self.rescuerecord.org_id = [[OrgInfo orgInfoForOrgID:[UserInfo userInfoForUserID:currentUserID].organization_id] valueForKey:@"orgname"];
            //路段名称
            [self btnsaveData];
            [[AppDelegate App] saveContext];
        }
        self.dataarray =[RescueRecord allRescueRecordArray];
        [self.tableviewList reloadData];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self tableView:self.tableviewList didSelectRowAtIndexPath:indexPath];
    }else{
        __weak typeof(self)weakself = self;
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择通知时间或到达时间，再保存！"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:cancelAction];
        [weakself.navigationController presentViewController:ac animated:YES completion:nil];
        return;
    }
}

- (IBAction)BtnaddClick:(id)sender {
    self.specialID = @"";
    self.rescuerecord = nil;
    [self zhanshiforspecialIDOrNot:nil];
    [self.tableviewList deselectRowAtIndexPath:self.selectedindexpath animated:NO];
}

- (IBAction)BtnFuJianClick:(id)sender {
    if(self.rescuerecord.myid.length >0 && self.rescuerecord){
        UIStoryboard *board            = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        AttachmentViewController *next = [board instantiateViewControllerWithIdentifier:@"AttachmentViewController"];
        [next setValue:self.rescuerecord.myid forKey:@"constructionId"];
        [self.navigationController pushViewController:next animated:YES];
    }else{
        __weak typeof(self)weakself = self;
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择交通救援记录，再选择附件"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:cancelAction];
        [weakself.navigationController presentViewController:ac animated:YES completion:nil];
        return;
    }
}
    
@end
