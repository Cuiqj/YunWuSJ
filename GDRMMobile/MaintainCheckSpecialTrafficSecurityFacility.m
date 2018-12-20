//
//  MaintainCheckSpecialTrafficSecurityFacility.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/8.
//

#import "MaintainCheckSpecialTrafficSecurityFacility.h"

@implementation MaintainCheckSpecialTrafficSecurityFacility
@dynamic  myid;
@dynamic  special_check_id;
@dynamic  direction;
@dynamic  stake_start;
@dynamic  stake_end;
@dynamic  special_item;
@dynamic  construct_org;
@dynamic  construct_name;
@dynamic  constr_start;
@dynamic  constr_end;
@dynamic  remark;
@dynamic  isuploaded;

+(MaintainCheckSpecialTrafficSecurityFacility *)MaintainCheckSpecialTrafficSecurityFacilityforspecialID:(NSString *)specialID{
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
