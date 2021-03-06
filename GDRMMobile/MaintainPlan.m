//
//  MaintianPlan.m
//  GDRMMobile
//
//  Created by xiaoxiaojia on 17/1/12.
//
//

#import "MaintainPlan.h"


@implementation MaintainPlan

@dynamic myid;
@dynamic project_name;
@dynamic construct_org;
@dynamic org_principal;
@dynamic date_start;
@dynamic date_end;
@dynamic project_address;
@dynamic close_desc;
@dynamic tel_number;
@dynamic remark;
@dynamic station_start;
@dynamic station_end;
@dynamic realy_end_time;
@dynamic is_finish;
@dynamic project_direction;
@dynamic org_id;


+(NSArray *)allMaintainPlan{
    NSManagedObjectContext *moc=  [[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity= [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSSortDescriptor *sort=[[NSSortDescriptor alloc] initWithKey:@"date_start" ascending:NO];
    request.sortDescriptors=[NSArray arrayWithObjects:sort, nil];
    [request setEntity:entity];
    [request setPredicate:nil];
    return [moc executeFetchRequest:request error:nil];
}
+(NSString*)maintainPlanNameForID:(NSString*)maintainID{
    NSManagedObjectContext *moc=  [[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity= [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSPredicate *predicate= [NSPredicate predicateWithFormat: @"myid==%@",maintainID ];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSArray*dataarray=[moc executeFetchRequest:request error:nil];
    if(dataarray.count>0)
    return [[dataarray objectAtIndex:0] valueForKey:@"project_name"];
    else
        return @"无";
}

+(MaintainPlan*)maintainPlanInfoForID:(NSString*)maintainID{
    NSManagedObjectContext *moc=  [[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity= [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSPredicate *predicate= [NSPredicate predicateWithFormat: @"myid==%@",maintainID ];
    [request setEntity:entity];
    [request setPredicate:predicate];
    NSArray*dataarray=[moc executeFetchRequest:request error:nil];
    if(dataarray.count>0)
        return [dataarray objectAtIndex:0] ;
    else
        return nil;
}
@end
