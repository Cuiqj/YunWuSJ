//
//  InspectionConstruction.m
//  GDRMMobile
//
//  Created by yu hongwu on 14-8-18.
//
//

#import "InspectionConstruction.h"
#import "CasePhoto.h"

@implementation InspectionConstruction

@dynamic inspectiondate;
@dynamic timestart1;
@dynamic timeend1;
@dynamic timeend2;
@dynamic weather1;
@dynamic stationstart1;
@dynamic stationend1;
@dynamic inspectionor1;
@dynamic timestart2;
@dynamic weather2;
@dynamic stationstart2;
@dynamic stationend2;
@dynamic inspectionor2;
@dynamic myid;
@dynamic isuploaded;

@dynamic org_id;
@dynamic personnel_class1;
@dynamic personnel_class2;

//只保持id
- (NSString *) signStr{
    if (![self.myid isEmpty]) {
        return [NSString stringWithFormat:@"%@", self.myid];
    }else{
        return @"";
    }
}


+ (InspectionConstruction *)inspectionConstructionOneRecordInfoForID:(NSString *)ID{
    if(ID==nil) return nil;
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSSortDescriptor *sort=[[NSSortDescriptor alloc] initWithKey:@"inspectiondate" ascending:NO];
    fetchRequest.sortDescriptors=[NSArray arrayWithObjects:sort, nil];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"myid == %@ ",ID]];
    NSMutableArray  * arr =  [context executeFetchRequest:fetchRequest error:nil];
    if(arr.count>0){
        return [[context executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
    }
    else{
        return nil;
    }
}

+ (NSArray *)inspectionConstructionInfoForID:(NSString *)inspectionConstructionID{
    NSManagedObjectContext *context=[[AppDelegate App] managedObjectContext];
    NSEntityDescription *entity=[NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    NSSortDescriptor *sort=[[NSSortDescriptor alloc] initWithKey:@"inspectiondate" ascending:NO];
    fetchRequest.sortDescriptors=[NSArray arrayWithObjects:sort, nil];
//    NSSortDescriptor * sortSecond = [[NSSortDescriptor alloc] initWithKey:@"timestart1" ascending:NO];
//    fetchRequest.sortDescriptors=[NSArray arrayWithObjects:sortSecond, nil];
    [fetchRequest setEntity:entity];
    if ([inspectionConstructionID isEmpty]) {
        [fetchRequest setPredicate:nil];
    } else {
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"myid == %@ ",inspectionConstructionID]];
    }
    return [context executeFetchRequest:fetchRequest error:nil];
}

//id假设为1的CaseProveInfo的图片都放置在InspectionConstruction/1目录下
- (NSString *)inspection_photo0{
    NSArray *array     = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 0) return nil;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[pathArray objectAtIndex:0];
    NSString *photoPath=[NSString stringWithFormat:@"InspectionConstruction/%@",self.myid];
    photoPath=[documentPath stringByAppendingPathComponent:photoPath];
    NSString *filePath=[photoPath stringByAppendingPathComponent:((CasePhoto*)[array objectAtIndex:0]).photo_name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo1{
    NSArray *array     = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 1) return nil;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[pathArray objectAtIndex:0];
    NSString *photoPath=[NSString stringWithFormat:@"InspectionConstruction/%@",self.myid];
    photoPath=[documentPath stringByAppendingPathComponent:photoPath];
    NSString *filePath=[photoPath stringByAppendingPathComponent:((CasePhoto*)[array objectAtIndex:1]).photo_name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo2{
    NSArray *array     = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 2) return nil;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[pathArray objectAtIndex:0];
    NSString *photoPath=[NSString stringWithFormat:@"InspectionConstruction/%@",self.myid];
    photoPath=[documentPath stringByAppendingPathComponent:photoPath];
    NSString *filePath=[photoPath stringByAppendingPathComponent:((CasePhoto*)[array objectAtIndex:2]).photo_name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo3{
    NSArray *array     = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 3) return nil;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[pathArray objectAtIndex:0];
    NSString *photoPath=[NSString stringWithFormat:@"InspectionConstruction/%@",self.myid];
    photoPath=[documentPath stringByAppendingPathComponent:photoPath];
    NSString *filePath=[photoPath stringByAppendingPathComponent:((CasePhoto*)[array objectAtIndex:3]).photo_name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo4{
    NSArray *array     = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 4) return nil;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[pathArray objectAtIndex:0];
    NSString *photoPath=[NSString stringWithFormat:@"InspectionConstruction/%@",self.myid];
    photoPath=[documentPath stringByAppendingPathComponent:photoPath];
    NSString *filePath=[photoPath stringByAppendingPathComponent:((CasePhoto*)[array objectAtIndex:4]).photo_name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo5{
    NSArray *array     = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 5) return nil;
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath=[pathArray objectAtIndex:0];
    NSString *photoPath=[NSString stringWithFormat:@"InspectionConstruction/%@",self.myid];
    photoPath=[documentPath stringByAppendingPathComponent:photoPath];
    NSString *filePath=[photoPath stringByAppendingPathComponent:((CasePhoto*)[array objectAtIndex:5]).photo_name];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo_remark0{
    NSArray *array       = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 0) return nil;
    CasePhoto *casePhoto = [array objectAtIndex:0];
    NSLog(@"%@",casePhoto.remark);
    if(casePhoto.remark != nil && ![casePhoto.remark isEmpty]){
        return casePhoto.remark;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo_remark1{
    NSArray *array       = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 1) return nil;
    CasePhoto * casePhoto = [array objectAtIndex:1];
    if(casePhoto.remark != nil && ![casePhoto.remark isEmpty]){
        return casePhoto.remark;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo_remark2{
    NSArray *array       = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 2) return nil;
    CasePhoto *casePhoto = [array objectAtIndex:2];
    if(casePhoto.remark != nil && ![casePhoto.remark isEmpty]){
        return casePhoto.remark;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo_remark3{
    NSArray *array       = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 3) return nil;
    CasePhoto *casePhoto = [array objectAtIndex:3];
    if(casePhoto.remark != nil && ![casePhoto.remark isEmpty]){
        return casePhoto.remark;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo_remark4{
    NSArray *array       = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 4) return nil;
    CasePhoto *casePhoto = [array objectAtIndex:4];
    if(casePhoto.remark != nil && ![casePhoto.remark isEmpty]){
        return casePhoto.remark;
    }else{
        return nil;
    }
}
- (NSString *)inspection_photo_remark5{
    NSArray *array       = [[CasePhoto casePhotos:self.myid]mutableCopy];
    if([array count] <= 5) return nil;
    CasePhoto *casePhoto = [array objectAtIndex:5];
    if(casePhoto.remark != nil && ![casePhoto.remark isEmpty]){
        return casePhoto.remark;
    }else{
        return nil;
    }
}
- (NSString *)stationstart1_text{
    NSString *local = @"K";
    if(self.stationstart1 != nil){
        local           = [local stringByAppendingString:[NSString stringWithFormat:@"%d", self.stationstart1.integerValue/1000]];
    }
    local = [local stringByAppendingString:@"+"];
    if(self.stationstart1 != nil){
        local = [local stringByAppendingString:[NSString stringWithFormat:@"%d",self.stationstart1.integerValue%1000]];
    }
    local = [local stringByAppendingString:@"M"];
    return local;
}
- (NSString *)stationend1_text{
    NSString *local = @"K";
    if(self.stationstart1 != nil){
        local           = [local stringByAppendingString:[NSString stringWithFormat:@"%d", self.stationend1.integerValue/1000]];
    }
    local = [local stringByAppendingString:@"+"];
    if(self.stationstart1 != nil){
        local = [local stringByAppendingString:[NSString stringWithFormat:@"%d",self.stationend1.integerValue%1000]];
    }
    local = [local stringByAppendingString:@"M"];
    return local;
}
- (NSString *)stationstart2_text{
    if ([self.stationstart2 integerValue]>0 && [self.stationend2 integerValue]>0) {
        
    }else{
        return @"";
    }
    NSString *local = @"K";
    if(self.stationstart1 != nil){
        local           = [local stringByAppendingString:[NSString stringWithFormat:@"%d", self.stationstart2.integerValue/1000]];
    }
    local = [local stringByAppendingString:@"+"];
    if(self.stationstart1 != nil){
        local = [local stringByAppendingString:[NSString stringWithFormat:@"%d",self.stationstart2.integerValue%1000]];
    }
    local = [local stringByAppendingString:@"M"];
    return local;
}
- (NSString *)stationend2_text{
    if ([self.stationstart2 integerValue]>0 && [self.stationend2 integerValue]>0) {
        
    }else{
        return @"";
    }
    NSString *local = @"K";
    if(self.stationstart1 != nil){
        local           = [local stringByAppendingString:[NSString stringWithFormat:@"%d", self.stationend2.integerValue/1000]];
    }
    local = [local stringByAppendingString:@"+"];
    if(self.stationstart1 != nil){
        local = [local stringByAppendingString:[NSString stringWithFormat:@"%d",self.stationend2.integerValue%1000]];
    }
    local = [local stringByAppendingString:@"M"];
    return local;
}
-(NSString *)middlestring{
    if ([self.stationstart2 integerValue]>0 &&[self.stationend2 integerValue]>0) {
        return @"至";
    }
    return @"";
}


@end
