//
//  InspectionOutViewController.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-9-13.
//
//

#import "InspectionOutViewController.h"
#import "InspectionPath.h"
#import "Global.h"
#import  "ListSelectViewController.h"
#import "Systype.h"

@interface InspectionOutViewController ()
@property (nonatomic,retain) NSArray             *itemArray;
@property (nonatomic,retain) NSArray             *detailArray;
@property (nonatomic,retain) UIPopoverController *pickerPopover;
- (NSString *)resultTextFromPickerView:(UIPickerView *)pickerView selectedRow:(NSInteger)row inComponent:(NSInteger)component;
@end

@implementation InspectionOutViewController
@synthesize itemArray;
@synthesize detailArray;
@synthesize inputView;
@synthesize tableCheckItems;
@synthesize pickerCheckItemDetails;
@synthesize textDetail;
@synthesize textDeliver;
@synthesize textEndDate;
@synthesize textMile;
@synthesize pickerPopover;
@synthesize delegate;

- (void)awakeFromNib{
    [super awakeFromNib];
    self.preferredContentSize = CGSizeMake(540.0, 620.0);
}
- (void)viewDidLoad{
//    选择巡查路线隐藏            以后PC端自动生成
    [self.RoadLabel setHidden:YES];
    [self.textroad setHidden:YES];
    self.KmLabel.frame = CGRectMake(self.TimerLabel.frame.origin.x+100, self.TimerLabel.frame.origin.y, self.TimerLabel.frame.size.width, self.TimerLabel.frame.size.height);
    self.textMile.frame = CGRectMake(self.textEndDate.frame.origin.x+100, self.textEndDate.frame.origin.y, self.textEndDate.frame.size.width, self.textEndDate.frame.size.height);
    self.TimerLabel.frame = self.RoadLabel.frame;
    self.textEndDate.frame = CGRectMake(self.textroad.frame.origin.x, self.textroad.frame.origin.y, self.textroad.frame.size.width+100, self.textroad.frame.size.height);

    
    NSArray *checkItems=[CheckItems allCheckItemsForType:2];
    NSMutableArray *tempMutableArray=[[NSMutableArray alloc] initWithCapacity:checkItems.count];
    for (CheckItems *checkItem in checkItems) {
        TempCheckItem *tempItem=[[TempCheckItem alloc] init];
        tempItem.checkText   = checkItem.checktext;
        tempItem.remarkText  = checkItem.remark;
        tempItem.checkResult = checkItem.remark;
        tempItem.itemID      = checkItem.myid;
        [tempMutableArray addObject:tempItem];
    }
    self.itemArray=[NSArray arrayWithArray:tempMutableArray];
    [super viewDidLoad];
    
    [self.textroad addTarget:self action:@selector(textTouch:) forControlEvents:UIControlEventTouchDown];
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTextDeliver:nil];
    [self setTextEndDate:nil];
    [self setTextMile:nil];
    [self setItemArray:nil];
    [self setDetailArray:nil];
    [self setPickerPopover:nil];
    [self setInputView:nil];
    [self setTableCheckItems:nil];
    [self setPickerCheckItemDetails:nil];
    [self setTextDetail:nil];
    [self setDelegate:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifer=@"CheckItemCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifer];
    id obj=[self.itemArray objectAtIndex:indexPath.row];
    cell.textLabel.text=[obj checkText];
    cell.detailTextLabel.text=[obj remarkText];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *checkItemID=[[self.itemArray objectAtIndex:indexPath.row] valueForKey:@"itemID"];
    self.detailArray=[CheckItemDetails detailsForItem:checkItemID];
    if ([self.inputView isHidden]) {
        [UIView beginAnimations:@"inputViewShow" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.5];
        [self.inputView setHidden:NO];
        [self.inputView setAlpha:1.0];
        [self.view bringSubviewToFront:self.inputView];
        CGFloat height      = self.inputView.frame.origin.y-self.tableCheckItems.frame.origin.y-5;
        CGRect newRect      = self.tableCheckItems.frame;
        newRect.size.height = height;
        [self.tableCheckItems setFrame:newRect];
        [UIView commitAnimations];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
    self.textDetail.text=[tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text;
    [self.pickerCheckItemDetails reloadAllComponents];
    //[self.pickerCheckItemDetails selectRow:0 inComponent:0 animated:NO];
    //self.textDetail.text=[self resultTextFromPickerView:self.pickerCheckItemDetails selectedRow:0 inComponent:0];
}

#pragma mark - pickerview delegate & datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.detailArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    id obj=[self.detailArray objectAtIndex:row];
    return [obj caption];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.textDetail.text=[self resultTextFromPickerView:pickerView selectedRow:row inComponent:component];
}

#pragma mark - IBActions
- (IBAction)btnCancel:(UIBarButtonItem *)sender {
    [self.delegate addObserverToKeyBoard];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)btnSave:(UIBarButtonItem *)sender {
    BOOL isBlank = NO;
    for (UITextField *textField in self.view.subviews) {
        if ([textField isKindOfClass:[UITextField class]]) {
            if ([textField.text isEmpty] && textField != self.textroad) {
                isBlank = YES;
            }
        }
    }
    if (!isBlank) {
        NSString *inspectionID=[[NSUserDefaults standardUserDefaults] valueForKey:INSPECTIONKEY];
        NSArray *temp=[Inspection inspectionForID:inspectionID];
        if (temp.count>0) {
            Inspection *inspection=[temp objectAtIndex:0];
            NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            [formatter setLocale:[NSLocale currentLocale]];
            //[formatter setTimeZone:[NSTimeZone systemTimeZone]];
            inspection.time_end=[formatter dateFromString:self.textEndDate.text];
            if (!inspection.yjsj) {
                inspection.yjsj = inspection.time_end;
            }
            inspection.inspection_milimetres=@(self.textMile.text.floatValue);
            
            inspection.isdeliver=@(YES);
            inspection.delivertext = self.textDeliver.text;
            NSString *description=@"";
            NSArray *recordArray=[InspectionRecord recordsForInspection:inspectionID];
            for (int i             = 0; i<recordArray.count; i++) {
                InspectionRecord *record=[recordArray objectAtIndex:i];
                //description=[description stringByAppendingFormat:@"（%d）%@\r\n",i+1,record.remark];
                description=[description stringByAppendingFormat:@"%@\n", record.remark];
            }
            inspection.inspection_description = description;
            NSString *pathString              = @"";
            NSArray *pathArray                = [InspectionPath pathsForInspection:inspectionID];
            for (InspectionPath *path in pathArray) {
                if ([pathString isEmpty]) {
                    pathString = path.stationname;
                } else {
                    pathString = [pathString stringByAppendingFormat:@"--%@",path.stationname];
                }
            }
            if (![pathString isEmpty]) {
                pathString = [[NSString alloc] initWithFormat:@"，途经：%@",pathString];
            }
            [formatter setDateFormat:DATE_FORMAT_HH_MM_COLON];
            pathString                  = [[NSString alloc] initWithFormat:@"%@出发%@，%@结束巡查",[formatter stringFromDate:inspection.time_start],pathString,[formatter stringFromDate:inspection.time_end]];
            inspection.inspection_place = pathString;
            inspection.inspection_place = self.textroad.text;
            [[AppDelegate App] saveContext];
        }
        for (TempCheckItem *checkItem in self.itemArray) {
            InspectionOutCheck *outCheck=[InspectionOutCheck newDataObjectWithEntityName:@"InspectionOutCheck"];
            outCheck.inspectionid = inspectionID;
            outCheck.checktext    = checkItem.checkText;
            outCheck.remark       = checkItem.remarkText;
            outCheck.checkresult  = checkItem.checkResult;
            [[AppDelegate App] saveContext];
        }
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:INSPECTIONKEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self.delegate popBackToMainView];
        [self dismissModalViewControllerAnimated:NO];
    }
}

- (IBAction)btnOK:(UIBarButtonItem *)sender {
    NSIndexPath *index=[self.tableCheckItems indexPathForSelectedRow];
    TempCheckItem *item=[self.itemArray objectAtIndex:index.row];
    item.remarkText = self.textDetail.text;
    [self.tableCheckItems beginUpdates];
    [self.tableCheckItems reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableCheckItems endUpdates];
    [self.tableCheckItems selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (IBAction)btnDismiss:(UIBarButtonItem *)sender {
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionCurveEaseInOut
                    animations:^{
                        [self.inputView setAlpha:0.0];
                        [self.view sendSubviewToBack:self.inputView];
                        CGRect newRect      = self.tableCheckItems.frame;
                        newRect.size.height = 440;
                        [self.tableCheckItems setFrame:newRect];
                    }
                    completion:^(BOOL finished){
                        [self.inputView setHidden:YES];
                    }];
}

- (IBAction)textTouch:(UITextField *)sender {
    //时间选择
    if ([self.pickerPopover isPopoverVisible]) {
        [self.pickerPopover dismissPopoverAnimated:YES];
    } else {
        if([sender isEqual: self.textEndDate]){
            DateSelectController *datePicker=[self.storyboard instantiateViewControllerWithIdentifier:@"datePicker"];
            datePicker.delegate   = self;
            datePicker.pickerType = 1;
            [datePicker showdate:self.textEndDate.text];
            self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:datePicker];
            [self.pickerPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            datePicker.dateselectPopover = self.pickerPopover;
        }
        else if ([sender isEqual: self.textroad]){
            ListSelectViewController *listselectPop=[[ListSelectViewController alloc] init];
            listselectPop.data=[Systype typeValueForCodeName:@"巡查日常路线"];
            listselectPop.delegate = self;
            self.pickerPopover=[[UIPopoverController alloc] initWithContentViewController:listselectPop];
            [self.pickerPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
            listselectPop.pickerPopover = self.pickerPopover;
            
        }
    }
}
- (void)setSelectData:(NSString *)data{
    self.textroad.text = data;
}
- (NSString *)resultTextFromPickerView:(UIPickerView *)pickerView selectedRow:(NSInteger)row inComponent:(NSInteger)component{
    NSString *resultText=[pickerView.delegate pickerView:pickerView titleForRow:row forComponent:component];
    if (resultText.integerValue>0) {
        NSString *temp  = self.textDetail.text;
        NSCharacterSet *leftCharSet=[NSCharacterSet characterSetWithCharactersInString:@"（("];
        NSRange range=[temp rangeOfCharacterFromSet:leftCharSet options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) {
            NSInteger index = range.location+1;
            NSString *header=[temp substringToIndex:index];
            NSCharacterSet *rightCharSet=[NSCharacterSet characterSetWithCharactersInString:@")）"];
            range=[temp rangeOfCharacterFromSet:rightCharSet];
            NSString *tail;
            if (range.location != NSNotFound) {
                tail=[temp substringFromIndex:range.location];
            } else {
                tail=[temp substringFromIndex:index];
            }
            resultText=[NSString stringWithFormat:@"%@%d%@",header,resultText.integerValue,tail];
        }
    }
    return resultText;
}


- (void)setDate:(NSString *)date{
    self.textEndDate.text = date;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}
@end
