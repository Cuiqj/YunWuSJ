//
//  AtonementNotice.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-11-15.
//
//

#import "OrgInfo.h"
#import "UserInfo.h"

#import "AtonementNotice.h"
#import "Systype.h"

@implementation AtonementNotice

@dynamic myid;
@dynamic caseinfo_id;
@dynamic citizen_name;
@dynamic code;
@dynamic date_send;
@dynamic check_organization;
@dynamic case_desc;
@dynamic witness;
@dynamic pay_reason;
@dynamic pay_mode;
@dynamic organization_id;
@dynamic remark;
@dynamic isuploaded;

- (NSString *) signStr{
    if (![self.caseinfo_id isEmpty]) {
        return [NSString stringWithFormat:@"caseinfo_id == %@", self.caseinfo_id];
    }else{
        return @"";
    }
}

+ (NSArray *)AtonementNoticesForCase:(NSString *)caseID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"caseinfo_id==%@",caseID];
    fetchRequest.predicate = predicate;
    fetchRequest.entity    = entity;
    return [context executeFetchRequest:fetchRequest error:nil];
}

- (NSString *)organization_info{
//    NSString*s1=[[self.organization_id stringByReplacingOccurrencesOfString:@"一中队" withString:@""] stringByReplacingOccurrencesOfString :@"二中队" withString:@""];
    [AtonementNotice newDataObjectWithEntityName:@""];
//    return  [[s1 stringByReplacingOccurrencesOfString:@"三中队" withString:@""] stringByReplacingOccurrencesOfString :@"四中队" withString:@""];
    NSString *currentUserID=[[NSUserDefaults standardUserDefaults] stringForKey:USERKEY];
    NSString * organization_info = [[OrgInfo orgInfoForOrgID:[UserInfo userInfoForUserID:currentUserID].organization_id] valueForKey:@"orgname"];
    if ([organization_info isEqualToString:@"广东省公路管理局云梧高速公路路政大队路政一中队"]) {
        return @"广东省公路管理局云梧高速公路路政大队一中队";
    }
    return organization_info;
}

- (NSString *)bank_name{
    return @"广东省路桥建设发展有限公司云梧分公司";
//    return [[Systype typeValueForCodeName:@"交款地点"] objectAtIndex:0];
//    NSString  * all = [[Systype typeValueForCodeName:@"交款地点"] objectAtIndex:0];
//    return
//    [all stringByReplacingOccurrencesOfString: self.bank_namehead withString:@""];
}
- (NSString *)bank_namehead{
    NSString * full = [[Systype typeValueForCodeName:@"交款地点"] objectAtIndex:0];
    return  [full substringToIndex:10];
}
-(NSString *)new_case_desc{
    NSArray *temp=[self.case_desc componentsSeparatedByString:@"分"];
    return [temp objectAtIndex:1];
}
-(NSString *)new_pay_reason{
    return self.pay_reason;
    //    NSArray *temp=[self.pay_reason componentsSeparatedByString:@"根据"];
    //    NSString * ss=[temp objectAtIndex:1];
    //    NSArray *temp2=[ss componentsSeparatedByString:@"的规定"];
    //    return [temp2 objectAtIndex:0];
}
-(NSString*)pay_mode2{
    NSString *s1 = [[self.pay_mode stringByReplacingOccurrencesOfString:@"元" withString:@""]  stringByReplacingOccurrencesOfString:@"元整" withString:@""];
    return [[s1 stringByReplacingOccurrencesOfString:@"整" withString:@""]  stringByReplacingOccurrencesOfString:@"元整" withString:@""];
}
@end
