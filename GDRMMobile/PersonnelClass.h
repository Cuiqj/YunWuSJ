//
//  PersonnelClass.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/14.
//班别表 A班 B班 C班 D班 桥涵组

#import <CoreData/CoreData.h>

@interface PersonnelClass : NSManagedObject
//编号
@property(nonatomic,retain) NSString * myid;
//机构编号
@property(nonatomic,retain) NSString * org_id;
//班别
@property(nonatomic,retain) NSString * class_name;
//起始责任桩号
@property(nonatomic,retain) NSNumber * duty_station_start;
//末尾责任桩号
@property(nonatomic,retain) NSNumber * duty_station_end;

+ (NSArray *)allPersonnelClass;

+ (NSString *)ClassNameforPersonnelClassMyID:(NSString *)MyID;

+ (NSString *)name:(NSString *)name forPersonnelClassMyID:(NSString *)MyID;
@end
