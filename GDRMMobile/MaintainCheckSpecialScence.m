//
//  MaintainCheckSpecialScence.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import "MaintainCheckSpecialScence.h"

@implementation MaintainCheckSpecialScence
@dynamic  myid;
@dynamic  special_check_id;
@dynamic  project_address;
@dynamic  manage_unit;
@dynamic  lay_rank;
@dynamic  sign_1;
@dynamic  sign_2;
@dynamic  sign_3;
@dynamic  sign_4;
@dynamic  sign_5;
@dynamic  sign_6;
@dynamic  sign_7;
@dynamic  lighting_facility;
@dynamic  workspace_doorway;
@dynamic  tunnel_construct;
@dynamic  other;
@dynamic  finish_date;
@dynamic  check_director;
@dynamic  becheck_unit;
@dynamic  advice_date;
@dynamic  recheck;
@dynamic  acceptor;
@dynamic  accept_date;
@dynamic  isuploaded;


+(MaintainCheckSpecialScence *)MaintainCheckSpecialScenceforspecialID:(NSString *)specialID{
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
