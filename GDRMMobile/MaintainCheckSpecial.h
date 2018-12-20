//
//  MaintainCheckSpecial.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import <CoreData/CoreData.h>

@interface MaintainCheckSpecial : NSManagedObject

//专项检查那张表
@property (nonatomic,retain) NSString * type;
//检查人员
@property (nonatomic,retain) NSString * name;
//检查时间
@property (nonatomic,retain) NSDate   * date;

@property (nonatomic,retain) NSString * maintain_plan_id;

@property (nonatomic,retain) NSString * myid;
@property (nonatomic,retain) NSNumber * isuploaded;

+(NSArray *)allMaintainCheckSpecialforMaintain_planid:(NSString *)planID withtype:(NSString *)type;
+(MaintainCheckSpecial *)MaintainCheckSpecialforMyid:(NSString *)myid;
@end
