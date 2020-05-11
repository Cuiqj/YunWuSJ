//
//  Reform.m
//  YUNWUMobile
//
//  Created by admin on 2020/4/13.
//

#import "Reform.h"

@implementation Reform
@dynamic myid;
@dynamic serial_number;
@dynamic project_name;
@dynamic org_id;
@dynamic unit_id;
@dynamic name;
@dynamic date;
@dynamic road;
@dynamic direction;
@dynamic station_start;
@dynamic station_end;
@dynamic trouble;
@dynamic end_time;
@dynamic recipient;
@dynamic re_time;
@dynamic items;
@dynamic result;
@dynamic inspect_time;
@dynamic record_date;
@dynamic status;
@dynamic isuploaded;

+(Reform *)getReformby:(NSString * )myid{
    if(myid==nil) return nil;
    NSManagedObjectContext *context = [[ AppDelegate  App ] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context ];
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"myid==%@",myid];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSMutableArray  * arr = [context executeFetchRequest:fetchRequest error:nil];
    if(arr.count>0)
        return [[context executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
    else
        return nil;
}
+(NSArray *)getallReformAndSort{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSError *error = nil;
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fecthRequest=[[NSFetchRequest alloc] init];
    [fecthRequest setEntity:entity];
    //NSPredicate *predicate=[NSPredicate predicateWithFormat:@"is_unvarying > 0"];
    NSSortDescriptor *sortDescriptor=[[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    //[fecthRequest setPredicate:predicate];
    [fecthRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    return [context executeFetchRequest:fecthRequest error:&error];
    
}
+ (NSInteger)maxserial_number{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *request=[[NSFetchRequest alloc] init];
    [request setEntity:entity];
//    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"case_type_id == 11"];
//    request.predicate=predicate;
    NSExpression *keyPathExpression = [NSExpression expressionForKeyPath:@"serial_number"];
    NSExpression *maxCaseMark3Expression = [NSExpression expressionForFunction:@"max:"
                                                                     arguments:[NSArray arrayWithObject:keyPathExpression]];
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"maxserial_number"];
    [expressionDescription setExpression:maxCaseMark3Expression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    [request setPropertiesToFetch:@[expressionDescription]];
    [request setResultType:NSDictionaryResultType];
    NSArray *objects = [context executeFetchRequest:request error:nil];
    if (objects.count > 0) {
        return [[[objects objectAtIndex:0] valueForKey:@"maxserial_number"] integerValue];
    } else {
        return 0;
    }
}


@end
