//
//  InspectionTotalViewController.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/8.
//

#import "InspectionTotalViewController.h"
#import "InspectionTotal.h"
#import "Inspection.h"
#import "ListSelectViewController.h"

@interface InspectionTotalViewController ()
@property (nonatomic,retain) InspectionTotal * inspectiontotal;

@property (nonatomic,retain) UIPopoverController * pickerPopover;
@end

@implementation InspectionTotalViewController
- (void)btnShowDataforNSString:(NSString *)showname{
    self.textdaily_event.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.daily_event.intValue] : @"";
    self.textpersonnel_class.text = showname ? self.inspectiontotal.personnel_class : @"";
    self.textmileage_before_trans.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.mileage_before_trans.intValue] : @"";
    self.textmileage_after_trans.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.mileage_after_trans.intValue] : @"";
    self.textinspect_people_num.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.inspect_people_num.intValue] : @"";
    self.textinspect_times.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.inspect_times.intValue] : @"";
//    6
    self.texttraffic_accident.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.traffic_accident.intValue] : @"";
    self.textroadasset_case.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.roadasset_case.intValue] : @"";
    self.textclear_barrier.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.clear_barrier.intValue] : @"";
    self.texthelp_trouble_car.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.help_trouble_car.intValue] : @"";
    self.textcheck_bridge.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.check_bridge.intValue] : @"";
//    10
    self.textcheck_job_site.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.check_job_site.intValue] : @"";
    self.textcorrect_violate.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.correct_violate.intValue] : @"";
    self.textexhort_passerby.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.exhort_passerby.intValue] : @"";
    self.textexhort_car.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.exhort_car.intValue] : @"";
    self.textresume_railing.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.resume_railing.intValue] : @"";
//    16
    self.textcheck_service.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.check_service.intValue] : @"";
    self.textfind_illegal.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.find_illegal.intValue] : @"";
    self.textalter_illegal.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.alter_illegal.intValue] : @"";
    self.textshunt.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.shunt.intValue] : @"";
    self.textclean_bridge_misc.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.clean_bridge_misc.intValue] : @"";
//    20
    self.textconstruction_note.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.construction_note.intValue] : @"";
    self.textstop_note.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.stop_note.intValue] : @"";
    self.textfind_illegal_con.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.find_illegal_con.intValue] : @"";
    self.textremove_illegal_con.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.remove_illegal_con.intValue] : @"";
    self.textfind_illegal_adv.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.find_illegal_adv.intValue] : @"";
//    26
    self.textremove_illegal_adv.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.remove_illegal_adv.intValue] : @"";
    self.textother_illegal.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.other_illegal.intValue] : @"";
    self.textpropaganda.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.propaganda.intValue] : @"";
    self.textget_facilities.text = showname ? [NSString stringWithFormat:@"%d",self.inspectiontotal.get_facilities.intValue] : @"";
    for (UITextField * textfield in [self.scrollview subviews]) {
        if ([textfield isKindOfClass:[UITextField class]]) {
            textfield.placeholder = @"不填默认为0";
            if ([textfield.text isEqualToString:@"0"]) {
                textfield.text = @"";
            }
        }
    }
    self.textpersonnel_class.placeholder = @"班别";
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"本班次巡查汇总信息";
    self.scrollview.frame = CGRectMake(0, 0, 1024, 520);
    self.scrollview.contentSize = CGSizeMake(1024, 525);
    
    self.textpersonnel_class.tag = 555;
    self.textpersonnel_class.delegate = self;
    
    
//    self.textmileage_before_trans.delegate = self;
//    self.textmileage_after_trans.delegate = self;
//    监听不行，只要输入就会触发方法    比如 输入345 在输入3的时候会触发 4、5的时候也都会触发
//    [self.textmileage_after_trans addTarget:self  action:@selector(textFieldafterDidChange:)
//         forControlEvents:UIControlEventEditingChanged];
//    [self.textmileage_before_trans addTarget:self  action:@selector(textFieldbeforeDidChange:)
//                           forControlEvents:UIControlEventEditingChanged];
    self.inspectiontotal = [InspectionTotal InspectionTotalforinspectionid:self.inspectionID];
    [self btnShowDataforNSString:@"展示"];
    //交班公里数测试    是否大于接班公里数
//    [self.textmileage_after_trans addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"text"] && object == self.textmileage_after_trans) {
//        NSLog(@"textField3 - 输入框内容改变,当前内容为: %@",self.textmileage_after_trans.text);
//    }else{
//        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
//    }
//}
//-(void)dealloc{
//    [self.self.textmileage_after_trans removeObserver:self forKeyPath:@"text" context:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.textmileage_after_trans || textField == self.textmileage_before_trans) {
        if ([self.textmileage_after_trans.text intValue] <= [self.textmileage_before_trans.text intValue]) {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"交班公里数必须大于接班公里数" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)BtnSaveClick:(id)sender {
    if ([self.textmileage_after_trans.text intValue] <= [self.textmileage_before_trans.text intValue]) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"交班公里数必须大于接班公里数,否则不能保存" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    self.inspectiontotal = [InspectionTotal InspectionTotalforinspectionid:self.inspectionID];
    if (self.inspectiontotal == nil) {
        self.inspectiontotal = [InspectionTotal newDataObjectWithEntityName:@"InspectionTotal"];
        self.inspectiontotal.inspectionid = self.inspectionID;
        Inspection * inspection = [Inspection Inspectionforinspectionid:self.inspectionID];
        self.inspectiontotal.car_num = inspection.carcode;
        self.inspectiontotal.inspect_date = inspection.date_inspection;
    }
//    if (self.inspectiontotal.isuploaded.boolValue) {
//        [self isuploadFinished];
//        return;
//    }
    self.inspectiontotal.daily_event = @(self.textdaily_event.text.intValue);
//    1
    self.inspectiontotal.personnel_class = self.textpersonnel_class.text;
    self.inspectiontotal.mileage_before_trans = @(self.textmileage_before_trans.text.intValue);
    self.inspectiontotal.mileage_after_trans = @(self.textmileage_after_trans.text.intValue);
    self.inspectiontotal.inspect_people_num = @(self.textinspect_people_num.text.intValue);
    self.inspectiontotal.inspect_times = @(self.textinspect_times.text.intValue);
//    6
    self.inspectiontotal.traffic_accident = @(self.texttraffic_accident.text.intValue);
    self.inspectiontotal.roadasset_case = @(self.textroadasset_case.text.intValue);
    self.inspectiontotal.clear_barrier = @(self.textclear_barrier.text.intValue);
    self.inspectiontotal.help_trouble_car = @(self.texthelp_trouble_car.text.intValue);
    self.inspectiontotal.check_bridge = @(self.textcheck_bridge.text.intValue);
//    10
    self.inspectiontotal.check_job_site = @(self.textcheck_job_site.text.intValue);
    self.inspectiontotal.correct_violate = @(self.textcorrect_violate.text.intValue);
    self.inspectiontotal.exhort_passerby = @(self.textexhort_passerby.text.intValue);
    self.inspectiontotal.exhort_car = @(self.textexhort_car.text.intValue);
    self.inspectiontotal.resume_railing = @(self.textresume_railing.text.intValue);
//    16
    self.inspectiontotal.check_service = @(self.textcheck_service.text.intValue);
    self.inspectiontotal.find_illegal = @(self.textfind_illegal.text.intValue);
    self.inspectiontotal.alter_illegal = @(self.textalter_illegal.text.intValue);
    self.inspectiontotal.shunt = @(self.textshunt.text.intValue);
    self.inspectiontotal.clean_bridge_misc = @(self.textclean_bridge_misc.text.intValue);
//    20
    self.inspectiontotal.construction_note = @(self.textconstruction_note.text.intValue);
    self.inspectiontotal.stop_note = @(self.textstop_note.text.intValue);
    self.inspectiontotal.find_illegal_con = @(self.textfind_illegal_con.text.intValue);
    self.inspectiontotal.remove_illegal_con = @(self.textremove_illegal_con.text.intValue);
    self.inspectiontotal.find_illegal_adv = @(self.textfind_illegal_adv.text.intValue);
//    26
    self.inspectiontotal.remove_illegal_adv = @(self.textremove_illegal_adv.text.intValue);
    self.inspectiontotal.other_illegal = @(self.textother_illegal.text.intValue);
    self.inspectiontotal.propaganda = @(self.textpropaganda.text.intValue);
    self.inspectiontotal.get_facilities = @(self.textget_facilities.text.intValue);
    [[AppDelegate App] saveContext];
}
- (void)isuploadFinished{
    __weak typeof(self)weakself = self;
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"已上传数据，不能更改"  preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:cancelAction];
    [weakself.navigationController presentViewController:ac animated:YES completion:nil];
}

- (IBAction)BtnEmptyClick:(id)sender {
//    if (self.inspectiontotal.isuploaded.boolValue) {
//        [self isuploadFinished];
//        return;
//    }
    
    if (self.inspectiontotal) {
        NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
        [context deleteObject:self.inspectiontotal];
    }
    [[AppDelegate App] saveContext];
    [self btnShowDataforNSString:nil];
}

- (IBAction)textpersonnel_class_Click:(id)sender {
    [self showListSelect:sender WithData:[NSArray arrayWithObjects:@"A班",@"B班",@"C班",@"D班", nil]];
}
-(void)showListSelect:(UITextField *)sender WithData:(NSArray *)data{
//    __weak typeof(self)weakself = self;
    ListSelectViewController *listPicker=[self.storyboard instantiateViewControllerWithIdentifier:@"ListSelectPoPover"];
    listPicker.delegate = self;
    listPicker.data     = data;
    self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:listPicker];
    CGRect rect         = sender.frame;
    [self.pickerPopover presentPopoverFromRect:rect inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
    listPicker.pickerPopover = self.pickerPopover;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 555) {
        [self textpersonnel_class_Click:self.textpersonnel_class];
        return NO;
    }
    return YES;
}
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    if (textField == self.textmileage_after_trans) {
//        if(self.textmileage_before_trans.text.intValue >self.textmileage_after_trans.text.intValue){
//            return NO;
//        }
//    }
//    return YES;
//}

- (void)setSelectData:(NSString *)data{
    self.textpersonnel_class.text = data;
    self.inspectiontotal.personnel_class = data;
}



@end
