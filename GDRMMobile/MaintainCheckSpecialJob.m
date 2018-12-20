//
//  MaintainCheckSpecialJob.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import "MaintainCheckSpecialJob.h"

@implementation MaintainCheckSpecialJob

@dynamic myid;
@dynamic special_check_id;
@dynamic project_address;
@dynamic manage_unit;
@dynamic scene_manage_1;
@dynamic scene_manage_2;
@dynamic scene_manage_3;
@dynamic scene_manage_4;
@dynamic machine_material_1;
@dynamic machine_material_2;
@dynamic machine_material_3;
@dynamic machine_material_4;
@dynamic security_equipment_1;
@dynamic security_equipment_2;
@dynamic security_equipment_3;
@dynamic security_equipment_4;
@dynamic maintain_construct_1;
@dynamic maintain_construct_2;
@dynamic maintain_construct_3;
@dynamic maintain_construct_4;
@dynamic maintain_construct_5;
@dynamic maintain_construct_6;
@dynamic maintain_construct_7;
@dynamic maintain_construct_8;
@dynamic maintain_construct_9;
@dynamic other;
@dynamic finish_date;
@dynamic check_director;
@dynamic becheck_unit;
@dynamic advice_date;
@dynamic recheck;
@dynamic acceptor;
@dynamic accept_date;
@dynamic isuploaded;

+(MaintainCheckSpecialJob *)MaintainCheckSpecialJobforspecialID:(NSString *)specialID{
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
