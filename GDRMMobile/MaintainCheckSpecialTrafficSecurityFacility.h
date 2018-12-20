//
//  MaintainCheckSpecialTrafficSecurityFacility.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/8.
//

#import <CoreData/CoreData.h>

@interface MaintainCheckSpecialTrafficSecurityFacility : NSManagedObject


//主键id；not null
@property (nonatomic,retain) NSString * myid;

//关联专项检查主表id
@property (nonatomic,retain) NSString * special_check_id;

//方向（取主表）
@property (nonatomic,retain) NSString * direction;

//开始桩号（取主表）    int
@property (nonatomic,retain) NSNumber * stake_start;

//结束桩号（取主表）    int
@property (nonatomic,retain) NSNumber * stake_end;

//交安设施专项项目
@property (nonatomic,retain) NSString * special_item;

//施工单位（取主表）
@property (nonatomic,retain) NSString * construct_org;

//施工负责人（取主表）
@property (nonatomic,retain) NSString * construct_name;

//施工开始时间（默认取主表；可编辑；不能反作用主表）    开始时间
@property (nonatomic,retain) NSDate   * constr_start;

//施工结束时间（默认取主表；可编辑；不能反作用主表）     预计结束
@property (nonatomic,retain) NSDate   * constr_end;

//备注
@property (nonatomic,retain) NSString * remark;


@property (nonatomic,retain) NSNumber * isuploaded;

+(MaintainCheckSpecialTrafficSecurityFacility *)MaintainCheckSpecialTrafficSecurityFacilityforspecialID:(NSString *)specialID;


@end
