//
//  MaintainCheckSpecialFinish.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/8.
//

#import "MaintainCheckSpecialFinish.h"

@implementation MaintainCheckSpecialFinish
@dynamic  myid;
@dynamic  special_check_id;
@dynamic  project_address;
@dynamic  manage_unit;
@dynamic  remove_rank;
@dynamic  traffic_security_facility;
@dynamic  other;
@dynamic  finish_date;
@dynamic  check_director;
@dynamic  becheck_unit;
@dynamic  advice_date;
@dynamic  recheck;
@dynamic  acceptor;
@dynamic  accept_date;
@dynamic  isuploaded;


+(MaintainCheckSpecialFinish *)MaintainCheckSpecialFinishforspecialID:(NSString *)specialID{
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
