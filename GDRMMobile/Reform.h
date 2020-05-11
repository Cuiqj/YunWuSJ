//
//  Reform.h
//  YUNWUMobile
//
//  Created by admin on 2020/4/13.
//

#import "BaseManageObject.h"

@interface Reform : BaseManageObject
@property (nonatomic, retain) NSString * myid;
//流水号
@property (nonatomic, retain) NSString * serial_number;
//项目名称 select project_name from maintainplan
@property (nonatomic, retain) NSString * project_name;
//检查单位  select name,id from orginfo
@property (nonatomic, retain) NSString * org_id;
//整改单位
@property (nonatomic, retain) NSString * unit_id;
//检查人
@property (nonatomic, retain) NSString * name;
//发现日期
@property (nonatomic, retain) NSDate * date;
//路段   select name from roadsegment          //where org_id in (select id from dbo.f_GetParent_Orgid
@property (nonatomic, retain) NSString * road;
//方向    select type_value from systype where code_name='方向'    and org_id={@user.org_id}
@property (nonatomic, retain) NSString * direction;
//开始桩号
@property (nonatomic, retain) NSString * station_start;
//结束桩号
@property (nonatomic, retain) NSString * station_end;
//隐患情况
@property (nonatomic, retain) NSString * trouble;
//截止时间
@property (nonatomic, retain) NSDate * end_time;
//签收人
@property (nonatomic, retain) NSString * recipient;
//签收时间
@property (nonatomic, retain) NSDate * re_time;
//整改项目
@property (nonatomic, retain) NSString * items;
//整改结果
@property (nonatomic, retain) NSString * result;
//检查时间
@property (nonatomic, retain) NSDate * inspect_time;
//下发时间
@property (nonatomic, retain) NSDate * record_date;
//整改状态     select '未整改',0 text    已整改，1
@property (nonatomic, retain) NSString * status;

@property (nonatomic, retain) NSNumber * isuploaded;
+(Reform *)getReformby:(NSString * )myid;
+(NSArray *)getallReformAndSort;

//控制递加项目流水号
+ (NSInteger)maxserial_number;
@end
