//
//  MaintainCheckSpecialFinish.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/8.
//

#import <CoreData/CoreData.h>

@interface MaintainCheckSpecialFinish : NSManagedObject

@property(nonatomic,retain) NSString * myid;

//关联专项检查主表id
@property(nonatomic,retain) NSString * special_check_id;

//路段名称（取主表）
@property(nonatomic,retain) NSString * project_address;

//管理单位
@property(nonatomic,retain) NSString * manage_unit;

//撤除顺序检查结果
@property(nonatomic,retain) NSString * remove_rank;

//交通安全设施检查结果
@property(nonatomic,retain) NSString * traffic_security_facility;

//其他
@property(nonatomic,retain) NSString * other;

//应完成时间
@property(nonatomic,retain) NSDate   * finish_date;

//复查验证情况
@property(nonatomic,retain) NSString * recheck;

@property(nonatomic,retain) NSNumber * isuploaded;



//检查负责人
@property(nonatomic,retain) NSString * check_director;
//受检单位
@property(nonatomic,retain) NSString * becheck_unit;
//整改意见填写日期
@property(nonatomic,retain) NSDate   * advice_date;
//验收人
@property(nonatomic,retain) NSString * acceptor;
//验收日期
@property(nonatomic,retain) NSDate   * accept_date;


+(MaintainCheckSpecialFinish *)MaintainCheckSpecialFinishforspecialID:(NSString *)specialID;


@end
