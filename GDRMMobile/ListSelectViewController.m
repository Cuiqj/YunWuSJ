//
//  ListSelectViewController.m
//  GDRMMobile
//
//  Created by 高 峰 on 13-7-13.
//
//

#import "ListSelectViewController.h"
#import "PersonnelClass.h"

@interface ListSelectViewController ()

@end

@implementation ListSelectViewController
@synthesize data;
@synthesize delegate;
@synthesize pickerPopover;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.arraytype isEqualToString:@"班别数组选择"]) {
        self.data = [PersonnelClass allPersonnelClass];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *CellIdentifier = @"ListSelectPopoverCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString * textname;
    if(!cell){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([self.arraytype isEqualToString:@"班别数组选择"]){
            NSString * station_start = [PersonnelClass name:@"duty_station_start" forPersonnelClassMyID:[[self.data objectAtIndex:indexPath.row] valueForKey:@"myid"]];
            NSString * station_end = [PersonnelClass name:@"duty_station_end" forPersonnelClassMyID:[[self.data objectAtIndex:indexPath.row] valueForKey:@"myid"]];
            NSString * station = [NSString stringWithFormat:@"K%02ld+%03ldM至K%02ld+%03ldM",station_start.integerValue/1000,station_start.integerValue%1000,station_end.integerValue/1000,station_end.integerValue%1000];
            textname = [NSString stringWithFormat:@"%@ %@",[[self.data objectAtIndex:indexPath.row] valueForKey:@"class_name"],station];
//            [[self.data objectAtIndex:indexPath.row] valueForKey:@"class_name"];
            cell.textLabel.text = textname;
        }else{
            cell.textLabel.text=[self.data objectAtIndex:indexPath.row];
        }
    }else{
        if ([self.arraytype isEqualToString:@"班别数组选择"]) {
            NSString * station_start = [PersonnelClass name:@"duty_station_start" forPersonnelClassMyID:[[self.data objectAtIndex:indexPath.row] valueForKey:@"myid"]];
            NSString * station_end = [PersonnelClass name:@"duty_station_end" forPersonnelClassMyID:[[self.data objectAtIndex:indexPath.row] valueForKey:@"myid"]];
            NSString * station = [NSString stringWithFormat:@"K%02ld+%03ldM至K%02ld+%03ldM",station_start.integerValue/1000,station_start.integerValue%1000,station_end.integerValue/1000,station_end.integerValue%1000];
            textname = [NSString stringWithFormat:@"%@ %@",[[self.data objectAtIndex:indexPath.row] valueForKey:@"class_name"],station];
            cell.textLabel.text = textname;
        }else{
            cell.textLabel.text=[self.data objectAtIndex:indexPath.row];
        }
    }
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.delegate respondsToSelector:@selector(setSelectData:)]) {
        [self.delegate setSelectData:[self.data objectAtIndex:indexPath.row]];
    } else if ([self.delegate respondsToSelector:@selector(listSelectPopover:selectedIndexPath:)]) {
        [self.delegate listSelectPopover:self selectedIndexPath:indexPath];
    }
    if ([self.delegate respondsToSelector:@selector(setSelectData: addNSString:)]) {
        [self.delegate setSelectData:[[self.data objectAtIndex:indexPath.row] valueForKey:@"class_name"] addNSString:[[self.data objectAtIndex:indexPath.row] valueForKey:@"myid"]];
    }
    [self.pickerPopover dismissPopoverAnimated:YES];
}

@end
