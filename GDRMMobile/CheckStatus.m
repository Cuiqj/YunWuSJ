//
//  CheckStatus.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-8-23.
//
//

#import "CheckStatus.h"


@implementation CheckStatus

@dynamic checktype_id;
@dynamic remark;
@dynamic statusname;
+ (NSArray *)statusForCheckType:(NSString *)typeID{
//    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
//    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
//    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
//    [fetchRequest setEntity:entity];
//    if ([typeID isEmpty]) {
//        fetchRequest.predicate=nil;
//    } else {
//        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"checktype_id==%@",typeID];
//       [fetchRequest setPredicate:predicate];
//    }
//    return [context executeFetchRequest:fetchRequest error:nil];
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"CheckStatus" inManagedObjectContext:context];
    fetchRequest.entity=entity;
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"checktype_id==%@",typeID];
    fetchRequest.predicate=predicate;
    return [context executeFetchRequest:fetchRequest error:nil];
}
+ (NSArray *)statusForCheckTypewww:(NSString *)typeID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    if ([typeID isEmpty]) {
        fetchRequest.predicate=nil;
    } else {
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"checktype_id==%@",typeID];
        [fetchRequest setPredicate:predicate];
    }
    return [context executeFetchRequest:fetchRequest error:nil];
}
@end
