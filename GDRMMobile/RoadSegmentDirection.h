//
//  RoadSegmentDirection.h
//  YUNWUMobile
//
//  Created by admin on 2019/2/26.
//

#import <CoreData/CoreData.h>

@interface RoadSegmentDirection : NSManagedObject

@property (nonatomic, strong) NSString * direction;
@property (nonatomic, strong) NSString * myid;
@property (nonatomic, strong) NSString * roadsegment_id;

+(NSArray *)roadsegmentdirection:(NSString *)roadsegment_id;

@end
