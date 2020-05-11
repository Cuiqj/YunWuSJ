//
//  ResultReform.m
//  YUNWUMobile
//
//  Created by admin on 2020/4/16.
//

#import "ResultReform.h"

@implementation ResultReform

@dynamic myid;
@dynamic lochus_code;
@dynamic liushuihao;
@dynamic year;
@dynamic lastroad;
@dynamic lastdirection;


+(ResultReform *)getResultReformbyid:(NSString * )myid{
    if(myid==nil) return nil;
    NSManagedObjectContext *context = [[ AppDelegate  App ] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context ];
    NSFetchRequest *fetchRequest    = [[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"myid==%@",myid];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    NSMutableArray  * arr = [context executeFetchRequest:fetchRequest error:nil];
    if(arr.count>0)
        return [arr objectAtIndex:0];
    else
        return nil;
}


@end
