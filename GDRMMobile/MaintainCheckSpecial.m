//
//  MaintainCheckSpecial.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import "MaintainCheckSpecial.h"

@implementation MaintainCheckSpecial
@dynamic type;
@dynamic name;
@dynamic date;
@dynamic maintain_plan_id;
@dynamic myid;
@dynamic isuploaded;

+(NSArray *)allMaintainCheckSpecialforMaintain_planid:(NSString *)planID withtype:(NSString *)type{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSSortDescriptor *sort=[[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    fetchRequest.sortDescriptors=[NSArray arrayWithObjects:sort, nil];
    [fetchRequest setEntity:entity];
    if ([planID isEmpty]) {
        [fetchRequest setPredicate:nil];
    } else {
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"maintain_plan_id == %@ && type = %@ ",planID,type]];
    }
    return [context executeFetchRequest:fetchRequest error:nil];
}

+(MaintainCheckSpecial *)MaintainCheckSpecialforMyid:(NSString *)myid{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"myid==%@",myid];
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
