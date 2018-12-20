//
//  RescueRecord.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/13.
//

#import "RescueRecord.h"

@implementation RescueRecord

@dynamic myid;
@dynamic org_id;
@dynamic sa_car;
@dynamic notice_time;
@dynamic arrival_time;
@dynamic ac_car;
@dynamic crew;
@dynamic charge;
@dynamic sa_person;
@dynamic patrol_person;
@dynamic end_time;
@dynamic situation;
@dynamic remark;
@dynamic isuploaded;

+(RescueRecord *)RescueRecordformyID:(NSString *)myID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"myid==%@",myID];
    fetchRequest.predicate=predicate;
    fetchRequest.entity=entity;
    NSArray *fetchResult=[context executeFetchRequest:fetchRequest error:nil];
    if (fetchResult.count>0) {
        return [fetchResult objectAtIndex:0];
    } else {
        return nil;
    }
}

+(NSArray *)allRescueRecordArray{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSSortDescriptor *sort=[[NSSortDescriptor alloc] initWithKey:@"notice_time" ascending:NO];
    fetchRequest.sortDescriptors=[NSArray arrayWithObjects:sort, nil];
    [fetchRequest setEntity:entity];
    return [context executeFetchRequest:fetchRequest error:nil];
}


@end
