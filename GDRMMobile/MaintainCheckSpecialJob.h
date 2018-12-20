//
//  MaintainCheckSpecialJob.h
//  YUNWUMobile
//
//  Created by admin on 2018/11/7.
//

#import <CoreData/CoreData.h>

@interface MaintainCheckSpecialJob : NSManagedObject

@property (nonatomic,retain) NSString * myid;
//关联专项检查MaintainCheckSpecial主表id
@property (nonatomic,retain) NSString * special_check_id;
//路段名称（取主表）
@property (nonatomic,retain) NSString * project_address;
//管理单位
@property (nonatomic,retain) NSString * manage_unit;

//现场管理和作业人员检查结果
//施工作业、管理的人员穿着带有反光标志的桔红色工作服
@property (nonatomic,retain) NSString * scene_manage_1;
//      应用车辆将作业人员接送到施工作业控制区内
@property (nonatomic,retain) NSString * scene_manage_2;
//     作业人员不得在施工作业控制区外活动
@property (nonatomic,retain) NSString * scene_manage_3;
//      在桥梁栏杆外侧和桥梁墩台进行养护维修作业时，作业人员必须系安全带
@property (nonatomic,retain) NSString * scene_manage_4;

// 机械、物料检查结果;
//养护施工机械设备、建筑材料，应堆放、摆放在工作区内
@property (nonatomic,retain) NSString * machine_material_1;
//    工程车辆应在下游过渡区内进出施工作业区
@property (nonatomic,retain) NSString * machine_material_2;
//     施工养护现场废料应及时清理，废料堆 放不得超出工作区，散落到工作区外行 车道上应及时清除
@property (nonatomic,retain) NSString * machine_material_3;
//    施工机械的操作应注意过往车辆，不得超出工作区外，妨碍正常行驶的车辆安全运行
@property (nonatomic,retain) NSString * machine_material_4;

//作业安全设施检查结果
//施工标志、禁止超车标志、限速标志、窄路标志、线形诱导标等标志应保持结 构完好，表层整洁，无明显污垢和破损，保持良好的反光效果
@property (nonatomic,retain) NSString * security_equipment_1;
//带有动力装置或可移动装置（拖车）的 安全防护设施，颜色应为醒目黄色，装有黄色施工警告灯号，其后部有醒目的 标志牌
@property (nonatomic,retain) NSString * security_equipment_2;
//夜间养护抢修作业时，应设置照明设施，照明必须满足作业要求，覆盖整个工作区域
@property (nonatomic,retain) NSString * security_equipment_3;
//进行养护施工作业时应顺着交通流方向设置安全设施
@property (nonatomic,retain) NSString * security_equipment_4;

//路面养护施工作业
//必须按作业控制区交通控制标志设置 相关的渠化装置和标志， 指派专人负责、维持交通
@property (nonatomic,retain) NSString * maintain_construct_1;

//可能发生山体滑坡、塌方、泥石流等路段 养护施工作业
//应设专人观察险情，严防安全事故发生
@property (nonatomic,retain) NSString * maintain_construct_2;

//高路堤路肩、陡边坡等路段养护施工作 业
//采取防滑坠落措施，并注意防备危岩、 浮石滚落
@property (nonatomic,retain) NSString * maintain_construct_3;

//视距条件较差或坡度较大的路段进行 养护施工作业
//设专人指挥交通，作业控制区应增加有关设施
@property (nonatomic,retain) NSString * maintain_construct_4;

//同一弯道
//不得同时设置两个或两个以上养护施 工作业控制区
@property (nonatomic,retain) NSString * maintain_construct_5;

//桥梁栏杆外和桥梁墩台进行养护施工 作业
//应设置悬挂式吊篮等防护设施，夜间须设置警示信号
@property (nonatomic,retain) NSString * maintain_construct_6;

//特大桥的养护施工作业
//应根据需要设施限载标志
@property (nonatomic,retain) NSString * maintain_construct_7;

//养护维修明洞和半山洞前
//应清除山体边坡或洞顶危石
@property (nonatomic,retain) NSString * maintain_construct_8;

//隧道内养护施工作 业
//应定期测量隧道内一氧化碳浓度或烟 尘浓度,当浓度高于规定允许浓度时， 应通知作业人员及时撤离，并开启通风 设备进行通风
@property (nonatomic,retain) NSString * maintain_construct_9;

//其他检查结果
@property (nonatomic,retain) NSString * other;

//应完成时间
@property (nonatomic,retain) NSDate   * finish_date;

//复查验证情况
@property (nonatomic,retain) NSString * recheck;

//是否已上传
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



+(MaintainCheckSpecialJob *)MaintainCheckSpecialJobforspecialID:(NSString *)specialID;


@end
