//
//  TrafficRecord.h
//  GDRMMobile
//
//  Created by coco on 13-7-8.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BaseManageObject.h"

@interface TrafficRecord : BaseManageObject
//巡查日志id
@property (nonatomic, retain) NSString * inspection_id;
//所属单位
@property (nonatomic, retain) NSString * org_id;
//发生时间
@property (nonatomic, retain) NSDate   * happentime;
//肇事车辆     的车牌号码
@property (nonatomic, retain) NSString * car;
//事故处理人
@property (nonatomic, retain) NSString * tra_name;
//车型
@property (nonatomic, retain) NSString * car_type;
//交通状况
@property (nonatomic, retain) NSString * traffic_flow;
//事故来源      //消息来源
@property (nonatomic, retain) NSString * infocome;
//（方向）
@property (nonatomic, retain) NSString * direction;
//（位置）
@property (nonatomic, retain) NSString * place;
//事故类型
@property (nonatomic, retain) NSString * property;
//事故性质
@property (nonatomic, retain) NSString * case_type;
//事故类别
@property (nonatomic, retain) NSString * case_sort;
//事故原因
@property (nonatomic, retain) NSString * case_reason;
//事故封道情况
@property (nonatomic, retain) NSString * seal_road;
//天气
@property (nonatomic, retain) NSString * weather;
//拯救处理时间（开始）
@property (nonatomic, retain) NSDate * save_starttime;
//拯救处理时间（结束）
@property (nonatomic, retain) NSDate * save_endtime;
//事故处理时间（开始）
@property (nonatomic, retain) NSDate * handle_starttime;
//事故处理时间（结束
@property (nonatomic, retain) NSDate * handle_endtime;
//其他部门到达时间
@property (nonatomic, retain) NSDate * other_arrivetime;
//事故班组
@property (nonatomic, retain) NSString * accident_class;
//轻伤人数
@property (nonatomic, retain) NSNumber * fleshwound_sum;
//重伤人数
@property (nonatomic, retain) NSNumber * badwound_sum;
//死亡人数
@property (nonatomic, retain) NSNumber * death_sum;
//损坏车辆数
@property (nonatomic, retain) NSNumber * badcar_sum;
//桩号
@property (nonatomic, retain) NSNumber * station;          //K00+000M
@property (nonatomic, retain) NSNumber * station_end;       //K00+000M
//事故地点。
@property (nonatomic, retain) NSString * location;
//收费站名称
@property (nonatomic, retain) NSString * tollstation;
//匝道出口
@property (nonatomic, retain) NSString * ramp;
@property (nonatomic, retain) NSString * myid;

//损失金额
@property (nonatomic, retain) NSNumber * lost;
//索赔方式
@property (nonatomic, retain) NSString * paytype;

////备注
@property (nonatomic, retain) NSString * remark;

@property (nonatomic, retain) NSNumber * isuploaded;
////是否拯救处理
@property (nonatomic, strong) NSNumber * iszj;
////是否事故处理
@property (nonatomic, strong) NSNumber * issg;




@property (nonatomic, retain) NSString * clend;
@property (nonatomic, retain) NSString *  clstart;
@property (nonatomic, retain) NSString * fix;
//是否结案
@property (nonatomic, retain) NSString * isend;
//巡查记录ID
@property (nonatomic, retain) NSString * rel_id;
//封道情况
@property (nonatomic, retain) NSString * roadsituation;
//事故分类
@property (nonatomic, retain) NSString * type;
//伤亡情况
@property (nonatomic, retain) NSString * wdsituation;
//拯救处理开始时间
@property (nonatomic, retain) NSDate * zjend;
//拯救处理开始时间
@property (nonatomic, retain) NSDate   * zjstart;

+(NSArray*)allTrafficRecord;
+(TrafficRecord*)trafficRecordForID:(NSString*)ID;


@end
