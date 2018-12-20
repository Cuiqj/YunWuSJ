//
//  HomePageController.h
//  GDRMMobile
//
//  Created by yu hongwu on 12-2-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrgSyncViewController.h"
#import "LoginViewController.h"
#import "LogoutViewController.h"

@interface HomePageController : UIViewController<UINavigationControllerDelegate,OrgSetDelegate,UserSetDelegate,LogOutDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelOrgShortName;
@property (weak, nonatomic) IBOutlet UILabel *labelCurrentUser;
@property (weak, nonatomic) IBOutlet UIButton *UIGouzhaowujianchabutton;
- (IBAction)btnLogOut:(UIBarButtonItem *)sender;
- (IBAction)btnServicesCheck:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *CarcheckBtn;
- (IBAction)btnCarcheck:(id)sender;
- (IBAction)btnYZDN:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnToMapView;
//车辆检查
@property (weak, nonatomic) IBOutlet UIButton *CheckCar;
@property (weak, nonatomic) IBOutlet UIButton *UnderBridegeCheck;
- (IBAction)UnderBridegeCheckClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *TrafficRescueButton;
@property (weak, nonatomic) IBOutlet UIButton *YingJIBaoZhangButton;

@end
