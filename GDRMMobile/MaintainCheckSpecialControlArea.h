//
//  MaintainCheckSpecialControlArea.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import <CoreData/CoreData.h>

@interface MaintainCheckSpecialControlArea : NSManagedObject


@property (nonatomic,retain) NSString * myid;

//专项检查主表id    关联checkspecial
@property (nonatomic,retain) NSString * special_check_id;

//路段名称（取主表）
@property (nonatomic,retain) NSString * project_address;

//管理单位
@property (nonatomic,retain) NSString * manage_unit;

//警告区检查结果
@property (nonatomic,retain) NSString * zone_length_1;

//上游过渡区检查结果
@property (nonatomic,retain) NSString * zone_length_2;

//缓冲区检查结果
@property (nonatomic,retain) NSString * zone_length_3;

//工作区检查结果
@property (nonatomic,retain) NSString * zone_length_4;

//下游过渡区检查结果
@property (nonatomic,retain) NSString * zone_length_5;

//终止区检查结果
@property (nonatomic,retain) NSString * zone_length_6;

//作业区最前端检查结果
@property (nonatomic,retain) NSString * facility_lay_1;

//警告区内的标志检查结果
@property (nonatomic,retain) NSString * facility_lay_2;

//窄路标志检查结果
@property (nonatomic,retain) NSString * facility_lay_3;

//锥形交通路标、线形诱导标检查结果
@property (nonatomic,retain) NSString * facility_lay_4;

//护栏检查结果
@property (nonatomic,retain) NSString * facility_lay_5;

//恢复路段限速标志检查结果
@property (nonatomic,retain) NSString * facility_lay_6;

//工程车辆出入口检查结果
@property (nonatomic,retain) NSString * other_regulation_1;
//同一行车方向相邻施工作业控制区的间距检查结果
@property (nonatomic,retain) NSString * other_regulation_2;

//多车道施工检查结果
@property (nonatomic,retain) NSString * other_regulation_3;

//匝道上布置施工作业控制区检查结果
@property (nonatomic,retain) NSString * other_regulation_4;

//其他
@property (nonatomic,retain) NSString * other;

//复查验证情况
@property (nonatomic,retain) NSString * recheck;

//应完成时间
@property (nonatomic,retain) NSDate   * finish_date;

//检查负责人
@property (nonatomic,retain) NSString * check_director;
//受检单位
@property (nonatomic,retain) NSString * becheck_unit;
//整改意见填写日期
@property (nonatomic,retain) NSDate   * advice_date;
//验收人
@property (nonatomic,retain) NSString * acceptor;
//验收日期
@property (nonatomic,retain) NSDate   * accept_date;


@property (nonatomic,retain) NSNumber * isuploaded;

+(MaintainCheckSpecialControlArea *)MaintainCheckSpecialControlAreaforspecialID:(NSString *)specialID;


@end
