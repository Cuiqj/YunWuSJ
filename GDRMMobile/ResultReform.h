//
//  ResultReform.h
//  YUNWUMobile
//
//  Created by admin on 2020/4/16.
//

#import <CoreData/CoreData.h>

@interface ResultReform : NSManagedObject

@property (nonatomic, retain) NSString * myid;
@property (nonatomic, retain) NSString * lochus_code;
@property (nonatomic, retain) NSString * liushuihao;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSString * lastroad;
@property (nonatomic, retain) NSString * lastdirection;
@property (nonatomic, retain) NSString * station_start_K;
@property (nonatomic, retain) NSString * station_start_M;


+(ResultReform *)getResultReformbyid:(NSString * )myid;
@end
