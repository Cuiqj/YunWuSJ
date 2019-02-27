//
//  RoadSegmentDirection.m
//  YUNWUMobile
//
//  Created by admin on 2019/2/26.
//

#import "RoadSegmentDirection.h"

@implementation RoadSegmentDirection

@dynamic direction;
@dynamic roadsegment_id;
@dynamic myid;

+(NSArray *)roadsegmentdirection:(NSString *)roadsegment_id{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
     NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    fetchRequest.entity    = entity;
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"roadsegment_id == %@",roadsegment_id]];
    return [context executeFetchRequest:fetchRequest error:nil];
}
@end
