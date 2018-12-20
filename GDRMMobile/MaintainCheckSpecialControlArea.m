//
//  MaintainCheckSpecialControlArea.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import "MaintainCheckSpecialControlArea.h"

@implementation MaintainCheckSpecialControlArea

@dynamic  myid;
@dynamic  special_check_id;
@dynamic  project_address;
@dynamic  manage_unit;
@dynamic  zone_length_1;
@dynamic  zone_length_2;
@dynamic  zone_length_3;
@dynamic  zone_length_4;
@dynamic  zone_length_5;
@dynamic  zone_length_6;
@dynamic  facility_lay_1;
@dynamic  facility_lay_2;
@dynamic  facility_lay_3;
@dynamic  facility_lay_4;
@dynamic  facility_lay_5;
@dynamic  facility_lay_6;
@dynamic  other_regulation_1;
@dynamic  other_regulation_2;
@dynamic  other_regulation_3;
@dynamic  other_regulation_4;
@dynamic  other;
@dynamic  finish_date;
@dynamic  check_director;
@dynamic  becheck_unit;
@dynamic  advice_date;
@dynamic  recheck;
@dynamic acceptor;
@dynamic accept_date;
@dynamic isuploaded;

+(MaintainCheckSpecialControlArea *)MaintainCheckSpecialControlAreaforspecialID:(NSString *)specialID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"special_check_id==%@",specialID];
    fetchRequest.predicate=predicate;
    fetchRequest.entity=entity;
    NSArray *fetchResult=[context executeFetchRequest:fetchRequest error:nil];
    if (fetchResult.count>0) {
        return [fetchResult objectAtIndex:0];
    } else {
        return nil;
    }
}


@end
