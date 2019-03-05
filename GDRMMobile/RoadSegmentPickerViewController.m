//
//  RoadSegmentPickerViewController.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-9-19.
//
//

#import "RoadSegmentPickerViewController.h"
#import "Systype.h"
#import "Sfz.h"

#import "RoadSegmentDirection.h"

@interface RoadSegmentPickerViewController ()
@property (nonatomic,retain) NSArray *data;
@end

@implementation RoadSegmentPickerViewController
@synthesize data = _data;
@synthesize pickerPopover = _pickerPopover;
@synthesize pickerState = _pickerState;

- (void)viewWillAppear:(BOOL)animated{
    if(self.roadsegment_id.length != 0 && self.pickerState == kRoadSide){
        self.data = [RoadSegmentDirection roadsegmentdirection:self.roadsegment_id];
    }else{
        switch (self.pickerState) {
            case kRoadSegment:
                self.data=[RoadSegment allRoadSegmentsForCaseView];
                break;
            case kRoadSide:
                self.data = nil;
                break;
            case kRoadPlace:
                self.data=[Systype typeValueForCodeName:@"位置"];
                break;
            case kShoufz:
                self.data=[Sfz allShoufzName];
                break;
            case kZadao:
                self.data=[self.delegate getZadao];
                break;
            default:
                break;
        }
    }
    [super viewWillAppear:animated];
}
- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)viewDidUnload{
    [self setData:nil];
    [self setPickerPopover:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (self.pickerState==kRoadSegment) {
//        原来显示name现在地点改了
        cell.textLabel.text=[[self.data objectAtIndex:indexPath.row] valueForKey:@"place_prefix1"];
    } else if(self.pickerState==kShoufz) {
        cell.textLabel.text=[[self.data objectAtIndex:indexPath.row] valueForKey:@"sfz_name"];
    }else if(self.pickerState==kRoadSide){
        cell.textLabel.text=[[self.data objectAtIndex:indexPath.row] valueForKey:@"direction"];
    }
    else{
        if(self.data.count>indexPath.row)
          cell.textLabel.text=[self.data objectAtIndex:indexPath.row];
    }
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.pickerState) {
        case kRoadSegment:
            [self.delegate setRoadSegment:[[self.data objectAtIndex:indexPath.row] valueForKey:@"myid"] roadName:[[self.data objectAtIndex:indexPath.row] valueForKey:@"place_prefix1"]];
            break;
        case kRoadPlace:
        case kZadao:
            [self.delegate setRoadPlace:[self.data objectAtIndex:indexPath.row]];
            break;
        case kRoadSide:
            [self.delegate setRoadSide:[[self.data objectAtIndex:indexPath.row] valueForKey:@"direction"]];
            break;
        case kShoufz:
            if([self.addroadsegment_id_shoufeizhan isEqualToString:@"收费站"]){
                [self.delegate setRoadSide:[[self.data objectAtIndex:indexPath.row]valueForKey:@"sfz_name"]];
                break;
            }
            [self.delegate setShoufz:[[self.data objectAtIndex:indexPath.row]valueForKey:@"sfz_name"] sfzID:[[self.data objectAtIndex:indexPath.row]valueForKey:@"myid"]];
            break;
        default:
            break;
    }
    [self.pickerPopover dismissPopoverAnimated:YES];
}

@end
