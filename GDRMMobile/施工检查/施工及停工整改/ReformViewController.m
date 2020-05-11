//
//  ConstructionReformViewController.m
//  YUNWUMobile
//
//  Created by admin on 2020/4/7.
//施工整改 及停工整改

#import "ReformViewController.h"

#import "ListSelectViewController.h"
#import "MaintainPlan.h"
#import "OrgInfo.h"
#import "RoadSegment.h"
#import "Systype.h"
#import "UserPickerViewController.h"
#import "DateSelectController.h"
#import "FileCode.h"
//附件
#import "AttachmentViewController.h"
#import "CasePhoto.h"
static NSString *ShutdownReformTable = @"ShutdownReformTable";
static NSString *ConstructionReformTable = @"ConstructionReformTable";
static NSString * allReform      = @"Reform";

@interface ReformViewController ()

@property (nonatomic,retain) Reform * reform;
@property (nonatomic,retain) UIPopoverController *pickerPopover;

@property NSInteger timeselectedtag;
@property NSInteger Listselectedtag;

@end

@implementation ReformViewController

//@synthesize pdfFormatFileURL;
//@synthesize pdfFileURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    for (UIView * view in self.myscrollview.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField * textfield = (UITextField *)view;
            textfield.delegate = self;
        }
    }
    self.ReformtableView.delegate = self;
    self.ReformtableView.dataSource = self;
    self.myscrollview.contentSize = CGSizeMake(0,620);
    if(self.segueController.selectedSegmentIndex ==0){
        self.data = [[ConstructionReform getallReformAndSort] mutableCopy];
    }else{
        self.data = [[ShutdownReform getallReformAndSort] mutableCopy];
    }
    self.ReformtableView.delegate = self;
    self.ReformtableView.dataSource = self;
    if([self.data count]> 0){
        [self tableView:self.ReformtableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    //当从施工里面跳转时 将数据填充到这里
    if ( 1 ) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.reform = self.data[indexPath.row];
    [self loadinfo:self.reform];
    
    //所有控制表格中行高亮的代码都只在这里
    [self.ReformtableView deselectRowAtIndexPath:[self.ReformtableView indexPathForSelectedRow] animated:YES];
    [self.ReformtableView selectRowAtIndexPath:indexPath animated:nil scrollPosition:nil];
}
- (void)loadinfo:(Reform *)reform{
    if (self.reform) {
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"y年M月d日HH时"];
        self.textend_time.text= [formatter stringFromDate:self.reform.end_time];
        self.textre_time.text= [formatter stringFromDate:self.reform.re_time];
        self.textinspect_time.text = [formatter stringFromDate:self.reform.inspect_time];
        [formatter setDateFormat:@"y年M月d日HH时mm分"];
        self.textdate.text= [formatter stringFromDate:self.reform.date];
        [formatter setDateFormat:@"y年M月d日"];
        self.textrecord_date.text = [formatter stringFromDate:self.reform.record_date];
        self.textproject_name.text = self.reform.project_name;
        self.textserial_number.text = self.reform.serial_number;
        self.textunit_id.text = self.reform.unit_id;
        self.textorg_id.text = [[OrgInfo orgInfoForOrgID:self.reform.org_id] valueForKey:@"orgname"];
        //    检查单位   整改单位   暂无设置
        self.textname.text = self.reform.name;
        self.textroad.text = self.reform.road;
        self.textdirection.text = self.reform.direction;
        self.texttrouble.text = self.reform.trouble;
        //        self.reform.items = self.texttrouble.text;       舍弃的整改项目
        self.textrecipient.text = self.reform.recipient;
        self.textresult.text = self.reform.result;
        
        if ([self.reform.status isEqualToString:@"0"]) {
            self.textstatus.text = @"未整改";
        }else if ([self.reform.status isEqualToString:@"1"]) {
            self.textstatus.text = @"已整改";
        }else{
            self.textstatus.text = @"";
        }
        if (self.reform.station_start.length>0) {
            self.textkstation_start.text =[NSString stringWithFormat:@"%02d", self.reform.station_start.integerValue/1000];
            self.textmstation_start.text=[NSString stringWithFormat:@"%03d",self.reform.station_start.integerValue%1000];
        }
//        self.textkstation_end.text=[NSString stringWithFormat:@"%02d",self.reform.station_end.integerValue/1000];
//        self.textmstation_end.text=[NSString stringWithFormat:@"%03d",self.reform.station_end.integerValue%1000];
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除数据库数据            检查内容删除
     Reform * reformdelete = [self.data objectAtIndex:indexPath.row];
    
    NSArray * photos = [CasePhoto casePhotos:reformdelete.myid];
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    for (id photo in photos) {
        [context deleteObject:photo];
    }
    [context deleteObject:reformdelete];
    [self.data removeObjectAtIndex:indexPath.row];
    [[AppDelegate App] saveContext];
    //删除tableviewcell
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    [tableView endUpdates];
    [self MyscrollviewClear];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier  = @"ReformCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateFormat:@"M月d日HH时mm分"];
    Reform * reform = [self.data objectAtIndex:indexPath.row];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@ K%@+%@M",reform.project_name, [NSString stringWithFormat:@"%02d"],[NSString stringWithFormat:@"%03d",self.reform.station_start.integerValue%1000]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",reform.serial_number, reform.project_name];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@-%@ %@",[[formatter stringFromDate:reform.date] substringToIndex:4],reform.serial_number, reform.project_name];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",[formatter stringFromDate:reform.date],reform.road];
    cell.textLabel.backgroundColor=[UIColor clearColor];
    if (reform.isuploaded.boolValue) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (IBAction)segueChange:(id)sender {
    self.reform = nil;
    if(self.segueController.selectedSegmentIndex ==0){
        self.data = [[ConstructionReform getallReformAndSort] mutableCopy];
        [self.labelend_time setHidden:NO];
        [self.textend_time setHidden:NO];
        [self.labelrecipient setFrame:CGRectMake(365, 360, 80, 30)];
        [self.textrecipient setFrame:CGRectMake(430, 360, 200, 30)];
    }else{
        self.data = [[ShutdownReform getallReformAndSort] mutableCopy];
        [self.labelend_time setHidden:YES];
        [self.textend_time setHidden:YES];
        [self.labelrecipient setFrame:CGRectMake(20, 360, 80, 30)];
        [self.textrecipient setFrame:CGRectMake(100, 360, 200, 30)];
    }
    [self.ReformtableView reloadData];
    [self MyscrollviewClear];
    if([self.data count]> 0){
        [self tableView:self.ReformtableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
}
- (void)MyscrollviewClear{
    for (UIView * view in self.myscrollview.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            [view setValue:@"" forKey:@"text"];
        }
        if ([view isKindOfClass:[UITextView class]]) {
            [view setValue:@"" forKey:@"text"];
        }
    }
}

- (IBAction)Selectproject_name:(id)sender {
     //项目名称         //select project_name from maintainplan where org_id
    self.Listselectedtag = 1;
//    NSArray * array = [[MaintainPlan allMaintainPlan] valueForKey:@"project_name"];
//    NSArray * data = [array valueForKeyPath:@"@distinctUnionOfObjects.self"];
    [self showListSelect:sender WithData: [[[MaintainPlan allMaintainPlan] valueForKey:@"project_name"] valueForKeyPath:@"@distinctUnionOfObjects.self"]];
}
- (IBAction)Selectorg_id:(id)sender {
    //检查单位
    self.Listselectedtag = 2;
    [self showListSelect:sender WithData:[OrgInfo allOrgInfoforname]];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 66 || textField.tag == 67 || textField.tag == 68 || textField.tag == 69) {
        return YES;
    }
    return NO;
}

- (IBAction)Selectunit_id:(id)sender {
    //整改单位      //select project_name from maintainplan where org_id
    self.Listselectedtag = 3;
    NSArray * data = [[[MaintainPlan allMaintainPlan] valueForKey:@"construct_org"] valueForKeyPath:@"@distinctUnionOfObjects.self"];
    [self showListSelect:sender WithData:data];
}
-(void)showListSelect:(UITextField *)sender WithData:(NSArray *)data{
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        ListSelectViewController *listPicker=[self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectPoPover"];
        listPicker.delegate = self;
        listPicker.data     = data;
        listPicker.preferredContentSize = CGSizeMake(300, 300);
        if (self.Listselectedtag ==2) {
            listPicker.preferredContentSize = CGSizeMake(450, 300);
        }else if(self.Listselectedtag ==6) {
                listPicker.preferredContentSize = CGSizeMake(200, 200);
        }else if(self.Listselectedtag ==4 ||self.Listselectedtag ==5) {
            listPicker.preferredContentSize = CGSizeMake(200, 200);
        }
        self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:listPicker];
        CGRect rect         = sender.frame;
        [self.pickerPopover presentPopoverFromRect:rect inView:self.myscrollview permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        listPicker.pickerPopover = self.pickerPopover;
    }
}
- (void)setSelectData:(NSString *)data{
    switch (self.Listselectedtag) {
        case 6:
            self.textstatus.text = data;
            break;
        case 1:
            self.textproject_name.text = data;
            break;
        case 2:
            self.textorg_id.text  = data;
            break;
        case 3:
            self.textunit_id.text = data;
            break;
        case 4:
            self.textroad.text = data;
            break;
        case 5:
            self.textdirection.text = data;
            break;
        default:
            break;
    }
}
- (IBAction)selectoad:(id)sender {
    // 路段  select name from roadsegment where org_id in
    self.Listselectedtag = 4;
//    NSArray * data = [ valueForKeyPath:@"@distinctUnionOfObjects.self"];
    [self showListSelect:sender WithData:[[RoadSegment allRoadSegments] valueForKey:@"name"]];
}
- (IBAction)Selectdirection:(id)sender {
    //方向 Items="select type_value from systype where code_name='方向' and org_id
    self.Listselectedtag = 5;
    [self showListSelect:sender WithData:[Systype typeValueForCodeName:@"方向"]];
}

- (IBAction)Selectname:(id)sender {
    //检查人
    UITextField * textfield = (UITextField *)sender;
    CGRect frame = textfield.frame;
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        UserPickerViewController *acPicker=[[UserPickerViewController alloc] init];
        acPicker.delegate=self;
        self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:acPicker];
        [self.pickerPopover setPopoverContentSize:CGSizeMake(140, 200)];
        [self.pickerPopover presentPopoverFromRect:frame inView:self.myscrollview permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
        acPicker.pickerPopover=self.pickerPopover;
    }
}
-(void)setUser:(NSString *)name andUserID:(NSString *)userID{
    if ([self.textname.text containsString:[NSString stringWithFormat:@"%@、",name]]) {
        self.textname.text = [self.textname.text stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@、",name] withString:@""];
    }else if ([self.textname.text containsString:[NSString stringWithFormat:@"、%@",name]]){
        self.textname.text = [self.textname.text stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"、%@",name] withString:@""];
    }else if ([self.textname.text containsString:[NSString stringWithFormat:@"%@",name]]){
        self.textname.text = @"";
    }else{
        if (self.textname.text.length>0) {
            self.textname.text = [NSString stringWithFormat:@"%@、%@",self.textname.text,name];
        }else{
            self.textname.text = name;
        }
    }
    
}
- (IBAction)Selectdate:(id)sender {
    UITextField * textfield = (UITextField *)sender;
    self.timeselectedtag = textfield.tag;
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        DateSelectController *dsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
        dsVC.delegate = self;
        dsVC.pickerType = 1;
        dsVC.textFieldTag = (NSInteger)textfield.tag;
        dsVC.datePicker.maximumDate = [NSDate date];
        CGRect frame= textfield.frame;
        self.pickerPopover = [[UIPopoverController alloc] initWithContentViewController:dsVC];
        [self.pickerPopover presentPopoverFromRect:frame inView:self.myscrollview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        dsVC.dateselectPopover = self.pickerPopover;
    }
}
-(void)setDate:(NSDate *)date forcheckdate:(NSString *)check;{
    //发现日期  222     //截止时间  223     //签收时间  224     //检查时间  225
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"y年M月d日HH时"];
    switch (self.timeselectedtag) {
        case 222:
            [formatter setDateFormat:@"y年M月d日HH时mm分"];
            self.textdate.text = [formatter stringFromDate:date];
            break;
        case 223:
            self.textend_time.text = [formatter stringFromDate:date];
            break;
        case 224:
            self.textre_time.text = [formatter stringFromDate:date];
            break;
        case 225:
            self.textinspect_time.text = [formatter stringFromDate:date];
            break;
        case 226:
            //记录时间
            [formatter setDateFormat:@"y年M月d日"];
            self.textrecord_date.text = [formatter stringFromDate:date];
            break;
        default:
            break;
    }
}

- (IBAction)Selectstatus:(id)sender {
    //整改状态
    self.Listselectedtag = 6;
    [self showListSelect:sender WithData:@[@"未整改",@"已整改"]];
}

- (IBAction)fujianBtnClick:(id)sender {
    if ([self allowedpush]) {
        UIStoryboard *board            = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        AttachmentViewController *next = [board instantiateViewControllerWithIdentifier:@"AttachmentViewController"];
        [next setValue:self.reform.myid forKey:@"constructionId"];
        [self.navigationController pushViewController:next animated:YES];
    }
}

- (IBAction)BtnSaveClick:(id)sender {
    if (self.reform) {
        [self SaveReformData];
    }else{
        if(self.segueController.selectedSegmentIndex == 0){
            self.reform = [ConstructionReform newDataObjectWithEntityName:NSStringFromClass([ConstructionReform class])];
        }else{
            self.reform = [ShutdownReform newDataObjectWithEntityName:NSStringFromClass([ShutdownReform class])];
        }
        NSString *currentUserID=[[NSUserDefaults standardUserDefaults] stringForKey:USERKEY];
        NSString *orgID = [UserInfo userInfoForUserID:currentUserID].organization_id;
        NSString *currentOrgID=[[NSUserDefaults standardUserDefaults] stringForKey:ORGKEY];
        if(currentOrgID.length >0){
            self.reform.org_id = currentOrgID;
        }else{
            self.reform.org_id = orgID;
        }
        [self SaveReformData];
        [self.data insertObject:self.reform atIndex:0];
        [self.ReformtableView reloadData];
    }
}
- (void)SaveReformData{
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"y年M月d日HH时"];
    self.reform.end_time = [formatter dateFromString:self.textend_time.text];
    self.reform.re_time = [formatter dateFromString:self.textend_time.text];
    self.reform.inspect_time = [formatter dateFromString:self.textend_time.text];
    [formatter setDateFormat:@"y年M月d日HH时mm分"];
    self.reform.date= [formatter dateFromString:self.textdate.text];
    [formatter setDateFormat:@"y年M月d日"];
    self.reform.record_date = [formatter dateFromString:self.textrecord_date.text];
    self.reform.project_name = self.textproject_name.text;
    self.reform.serial_number = self.textserial_number.text;
    if (self.textorg_id.text.length>0) {
        self.reform.org_id = [OrgInfo orgInfoFororgOrgid:self.textorg_id.text];
    }
    self.reform.unit_id = self.textunit_id.text;
    self.reform.name = self.textname.text;
    self.reform.road = self.textroad.text;
    self.reform.direction = self.textdirection.text;
    self.reform.station_start = [NSString stringWithFormat:@"%@%@",self.textkstation_start.text,self.textmstation_start.text];
//    self.reform.station_end = [NSString stringWithFormat:@"%@%@",self.textkstation_end.text,self.textmstation_end.text];
    self.reform.trouble = self.texttrouble.text;
    //self.reform.items = self.texttrouble.text;舍弃的整改项目
    self.reform.recipient = self.textrecipient.text;
    self.reform.result = self.textresult.text;
    if ([self.textstatus.text isEqualToString:@"未整改"]) {
        self.reform.status = @"0";
    }else if ([self.textstatus.text isEqualToString:@"已整改"]) {
        self.reform.status = @"1";
    }
    [[AppDelegate App] saveContext];
}

- (BOOL)allowedpush{
    if(self.reform.myid.length >0){
        return YES;
        
    }else{
        __weak typeof(self)weakself = self;
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择通知记录，再选择附件"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [ac addAction:cancelAction];
        [weakself.navigationController presentViewController:ac animated:YES completion:nil];
    }
    return NO;
}
- (IBAction)printClick:(id)sender {
    if ([self allowedpush]) {
//        if([[NSString stringWithUTF8String:object_getClassName(self.reform)] isEqualToString:@"ConstructionReform"]){
//            //施工打印
//        [self printReformAndName:@"施工通知"];
        [self SaveReformData];
         //配置一些reform表里面没有的数据
        [self returnNsmanagedobjectforReform];
        //去打印
        [self printReformAndName:nil];
       
        
//        }else if([[NSString stringWithUTF8String:object_getClassName(self.reform)] isEqualToString:@"ShutdownReform"]){
//            //停工打印
//            [self printReformAndName:@"停工通知"];
//        }
    }
}
- (void)printReformAndName:(NSString *)name{
    UIStoryboard *board                           = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ReformPDFViewController * next = [board instantiateViewControllerWithIdentifier:@"ReformPDFViewController"];
    NSLog(@"%@",[self docPathallileName]);
//    next.inspectionConstructionPDFID = self.reform.myid;
    [self toFullPDFWithPath:[self docPathallileName]];
    [self toFormedPDFWithPath:[self docPathallileName]];
//    if (pdfFileURL == nil) {
//        pdfFileURL = [NSURL fileURLWithPath:[self docPathallileName]];
//    }if (pdfFormatFileURL == nil) {
//        pdfFormatFileURL = [NSURL fileURLWithPath:[self docPathallileName]];
//    }
    NSString * finaladdstr;
    if(self.segueController.selectedSegmentIndex == 0){
        finaladdstr = @"施工通知";
    }else if(self.segueController.selectedSegmentIndex == 1){
        finaladdstr = @"停工通知";
    }
    [next setValue:[NSString stringWithFormat:@"%@/%@打印.pdf",[self docPathallileName],finaladdstr]  forKey:@"pdfFilePath"];
    [next setValue:[NSString stringWithFormat:@"%@/%@套打.pdf",[self docPathallileName],finaladdstr]  forKey:@"pdfFormFilePath"];
//    next.slefdeletegate = self;
    [next setValue:self forKey:@"delegate"];
    [self.navigationController pushViewController:next animated:YES];
}
-(NSString *)docPathallileName{
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[arrayPaths objectAtIndex:0];
    NSString *filePath  = [NSString stringWithFormat:@"%@/Reform/%@",path,self.reform.myid];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return filePath;
}

- (NSURL *)toFormedPDFWithPath:(NSString *)filePath{
    if (![filePath isEmpty]) {
        if(self.segueController.selectedSegmentIndex == 0){
            [self LoadPaperSettings:ConstructionReformTable];
            filePath = [NSString stringWithFormat:@"%@/施工通知",filePath];
        }else if(self.segueController.selectedSegmentIndex == 1){
            [self LoadPaperSettings:ShutdownReformTable];
            filePath = [NSString stringWithFormat:@"%@/停工通知",filePath];
        }
        ResultReform * result = [ResultReform getResultReformbyid:self.reform.myid];
        NSString *formatFilePath = [NSString stringWithFormat:@"%@套打.pdf",filePath];
        CGRect pdfRect           = CGRectMake(0.0, 0.0, paperWidth, paperHeight);
        UIGraphicsBeginPDFContextToFile(formatFilePath, CGRectZero, nil);
        UIGraphicsBeginPDFPageWithInfo(pdfRect, nil);
        if(self.segueController.selectedSegmentIndex == 0){
//            [self drawStaticTable:ConstructionReformTable];
            [self drawDateTable:ConstructionReformTable withDataModel:self.reform];
            [self drawDateTable:ConstructionReformTable withDataModel:result];
        }else if(self.segueController.selectedSegmentIndex == 1){
//            [self drawStaticTable:ShutdownReformTable];
            [self drawDateTable:ShutdownReformTable withDataModel:self.reform];
            [self drawDateTable:ShutdownReformTable withDataModel:result];
        }
        UIGraphicsEndPDFContext();
        return [NSURL fileURLWithPath:formatFilePath];
    }
    return nil;
}
- (NSURL *)toFullPDFWithPath:(NSString *)filePath{
    if (![filePath isEmpty]) {
        if(self.segueController.selectedSegmentIndex == 0){
            [self LoadPaperSettings:ConstructionReformTable];
            filePath = [NSString stringWithFormat:@"%@/施工通知",filePath];
        }else if(self.segueController.selectedSegmentIndex == 1){
            [self LoadPaperSettings:ShutdownReformTable];
            filePath = [NSString stringWithFormat:@"%@/停工通知",filePath];
        }
        ResultReform * result = [ResultReform getResultReformbyid:self.reform.myid];
        NSString *allfilePath = [NSString stringWithFormat:@"%@打印.pdf",filePath];
        CGRect pdfRect = CGRectMake(0.0, 0.0, paperWidth, paperHeight);
        UIGraphicsBeginPDFContextToFile(allfilePath, CGRectZero, nil);
        UIGraphicsBeginPDFPageWithInfo(pdfRect, nil);
        if(self.segueController.selectedSegmentIndex == 0){
            [self drawStaticTable:ConstructionReformTable];
            [self drawDateTable:ConstructionReformTable withDataModel:self.reform];
            [self drawDateTable:ConstructionReformTable withDataModel:result];
        }else if(self.segueController.selectedSegmentIndex == 1){
            [self drawStaticTable:ShutdownReformTable];
            [self drawDateTable:ShutdownReformTable withDataModel:self.reform];
            [self drawDateTable:ShutdownReformTable withDataModel:result];
        }
        UIGraphicsEndPDFContext();
        return [NSURL fileURLWithPath:allfilePath];
    }
    return nil;
}
- (void )returnNsmanagedobjectforReform{
    ResultReform * result = [ResultReform getResultReformbyid:self.reform.myid];
    if (result) {
        
    }else{
        result = [ResultReform newDataObjectWithEntityName:@"ResultReform"];
    }
    NSNumber * serial_digit;
    if(self.segueController.selectedSegmentIndex == 0){
        FileCode * file = [FileCode fileCodeWithfile_code:@"施工整改通知书编号"];
        result.lochus_code = file.lochus_code;
        serial_digit= file.serial_digit;
    }else if(self.segueController.selectedSegmentIndex == 1){
        FileCode * file = [FileCode fileCodeWithfile_code:@"停工整改通知书编号"];
        result.lochus_code = file.lochus_code;
        serial_digit= file.serial_digit;
    }
    for (int i = 0 ; i < [serial_digit integerValue]; i++) {
        if (self.reform.serial_number.length >0) {
            if (self.reform.serial_number.length >i) {
                result.liushuihao = self.reform.serial_number;
            }else{
                result.liushuihao = [NSString stringWithFormat:@"0%@",result.liushuihao];
            }
        }else{
            result.liushuihao = @"";
        }
    }
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"y年M月d日HH时mm分"];
    result.year = [[[formatter stringFromDate:self.reform.date] substringToIndex:4]substringFromIndex:2];
    result.lastroad = [[[self.reform.road stringByReplacingOccurrencesOfString:@"高速" withString:@""] stringByReplacingOccurrencesOfString:@"公路" withString:@""]stringByReplacingOccurrencesOfString:@"路段" withString:@""];
    result.lastdirection = [[self.reform.direction stringByReplacingOccurrencesOfString:@"往" withString:@""]stringByReplacingOccurrencesOfString:@"方向" withString:@""];
    result.myid = self.reform.myid;
    if (self.reform.station_start.length>0) {
        result.station_start_K =[NSString stringWithFormat:@"%02d", self.reform.station_start.integerValue/1000];
        result.station_start_M=[NSString stringWithFormat:@"%03ld",self.reform.station_start.integerValue%1000];
    }
    [[AppDelegate App] saveContext];
}




//新增流水号自动+1
- (IBAction)addReform:(id)sender {
    self.reform = nil;
    [self MyscrollviewClear];
    if (self.segueController.selectedSegmentIndex == 0) {
        self.textserial_number.text = [self addConstructionReformserial_number];
    }else if (self.segueController.selectedSegmentIndex == 1) {
        self.textserial_number.text = [self addShutdownReformserial_number];
    }
    [self.ReformtableView deselectRowAtIndexPath:[self.ReformtableView indexPathForSelectedRow] animated:YES];
}
- (NSString *)addConstructionReformserial_number{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:line_Date_version_yyyy];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
    NSString *yearString=[dateString substringToIndex:4];
    NSInteger caseMark3InCoreData = [ConstructionReform maxserial_number];
    NSInteger caseMark3InDefaults=[[NSUserDefaults standardUserDefaults] stringForKey:@"ConstructionReformserial_number"].integerValue;
    NSString *caseMark3           = [[NSString alloc] initWithFormat:@"%d",MAX(caseMark3InDefaults, caseMark3InCoreData)+1];
    NSString *oldCaseMark2=[[NSUserDefaults standardUserDefaults] stringForKey:@"CaseMark2"];
    if(yearString.integerValue>oldCaseMark2.integerValue) {
        caseMark3=@"1";
        [[NSUserDefaults standardUserDefaults] setObject:yearString forKey:@"CaseMark2"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:caseMark3 forKey:@"ConstructionReform"];
    [[NSUserDefaults standardUserDefaults] synchronize];
//    self.textCasemark3.text = caseMark3;
    return caseMark3;
}
- (NSString *)addShutdownReformserial_number{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:line_Date_version_yyyy];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSString *dateString=[dateFormatter stringFromDate:[NSDate date]];
    NSString *yearString=[dateString substringToIndex:4];
    NSInteger caseMark3InCoreData = [ShutdownReform maxserial_number];
    NSInteger caseMark3InDefaults=[[NSUserDefaults standardUserDefaults] stringForKey:@"ShutdownReformserial_number"].integerValue;
    NSString *caseMark3           = [[NSString alloc] initWithFormat:@"%d",MAX(caseMark3InDefaults, caseMark3InCoreData)+1];
    NSString *oldCaseMark2=[[NSUserDefaults standardUserDefaults] stringForKey:@"CaseMark2"];
    if(yearString.integerValue>oldCaseMark2.integerValue) {
        caseMark3=@"1";
        [[NSUserDefaults standardUserDefaults] setObject:yearString forKey:@"CaseMark2"];
    }
    [[NSUserDefaults standardUserDefaults] setObject:caseMark3 forKey:@"ShutdownReformserial_number"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //    self.textCasemark3.text = caseMark3;
    return caseMark3;
}



@end
