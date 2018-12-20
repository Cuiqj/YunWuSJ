//
//  PersonnelClass.m
//  YUNWUMobile
//
//  Created by admin on 2018/11/14.
//

#import "PersonnelClass.h"

@implementation PersonnelClass
@dynamic myid;
@dynamic org_id;
@dynamic class_name;
@dynamic duty_station_end;
@dynamic duty_station_start;


+ (NSArray *)allPersonnelClass{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:nil];
    return [context executeFetchRequest:fetchRequest error:nil];
}
+ (NSString *)ClassNameforPersonnelClassMyID:(NSString *)MyID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"myid == %@",MyID]];
    NSArray *temp=[context executeFetchRequest:fetchRequest error:nil];
    if (temp.count>0) {
        id obj=[temp objectAtIndex:0];
        //return [obj name];
        return [obj valueForKey:@"class_name"];
    } else {
        return @"";
    }
}

+ (NSString *)name:(NSString *)name forPersonnelClassMyID:(NSString *)MyID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"myid == %@",MyID]];
    NSArray *temp=[context executeFetchRequest:fetchRequest error:nil];
    if (temp.count>0) {
        id obj=[temp objectAtIndex:0];
        //return [obj name];
        return [obj valueForKey:name];
    } else {
        return @"";
    }
}



@end
