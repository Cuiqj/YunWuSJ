//
//  RescueRecord.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/13.
//

#import <CoreData/CoreData.h>

@interface RescueRecord : NSManagedObject

@property (nonatomic,retain) NSString * myid;
//公司名称
@property (nonatomic,retain) NSString * org_id;
//上面不用了改为下面字段
@property (nonatomic,retain) NSString * company;

//拯救车牌
@property (nonatomic,retain) NSString * sa_car;
//  通知时间
@property (nonatomic,retain) NSDate   * notice_time;
//  到达时间
@property (nonatomic,retain) NSDate   * arrival_time;
//事故车牌
@property (nonatomic,retain) NSString * ac_car;
//司乘人姓名电话
@property (nonatomic,retain) NSString * crew;
//收费
@property (nonatomic,retain) NSNumber * charge;
//拯救人员
@property (nonatomic,retain) NSString * sa_person;
//巡查人员
@property (nonatomic,retain) NSString * patrol_person;
//处理结束时间
@property (nonatomic,retain) NSDate   * end_time;
//现场救援情况
@property (nonatomic,retain) NSString * situation;
//备注
@property (nonatomic,retain) NSString * remark;

@property (nonatomic,retain) NSNumber * isuploaded;




+(NSArray *)allRescueRecordArray;
+(RescueRecord *)RescueRecordformyID:(NSString *)myID;

@end
