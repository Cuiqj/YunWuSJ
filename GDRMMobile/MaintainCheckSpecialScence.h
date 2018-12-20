//
//  MaintainCheckSpecialScence.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import <CoreData/CoreData.h>

@interface MaintainCheckSpecialScence : NSManagedObject
//主键id；not null
@property (nonatomic,retain) NSString * myid;

//专项检查主表id
@property (nonatomic,retain) NSString * special_check_id;

//路段名称（取主表）
@property (nonatomic,retain) NSString * project_address;

//管理单位
@property (nonatomic,retain) NSString * manage_unit;

//摆放顺序检查结果
@property (nonatomic,retain) NSString * lay_rank;

//标志牌检查结果1
@property (nonatomic,retain) NSString * sign_1;

//标志牌检查结果2
@property (nonatomic,retain) NSString * sign_2;

//标志牌检查结果3
@property (nonatomic,retain) NSString * sign_3;

//标志牌检查结果4
@property (nonatomic,retain) NSString * sign_4;

//标志牌检查结果5
@property (nonatomic,retain) NSString * sign_5;

//标志牌检查结果6
@property (nonatomic,retain) NSString * sign_6;

//标志牌检查结果7
@property (nonatomic,retain) NSString * sign_7;

//照明设施检查结果
@property (nonatomic,retain) NSString * lighting_facility;

//工作区出入口检查结果
@property (nonatomic,retain) NSString * workspace_doorway;

//隧道内施工检查结果
@property (nonatomic,retain) NSString * tunnel_construct;

//其他
@property (nonatomic,retain) NSString * other;

//应完成时间
@property (nonatomic,retain) NSDate   * finish_date;

//复查验证情况
@property (nonatomic,retain) NSString * recheck;

@property (nonatomic,retain) NSNumber * isuploaded;



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



+(MaintainCheckSpecialScence *)MaintainCheckSpecialScenceforspecialID:(NSString *)specialID;

@end
