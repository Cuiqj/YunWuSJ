//
//  LawViewController.m
//  GDRMMobile
//
//  Created by yu hongwu on 12-2-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LawViewController.h"

@interface LawViewController ()

@property (nonatomic ,retain) NSString * current_sel_show_string;
@end
@implementation LawViewController
@synthesize tvAttechment;
@synthesize docview;
@synthesize tvMainList;
int current_sel;



-(void)viewDidLoad{
    NSString *imagePath=[[NSBundle mainBundle] pathForResource:@"shenqing-bg1" ofType:@"png"];
    self.view.layer.contents=(id)[[UIImage imageWithContentsOfFile:imagePath] CGImage];
    
    [self.tvAttechment selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    [self.tvMainList selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    current_sel = 0;
    self.current_sel_show_string = @"法律/国家/";
    NSString *mainBundleDirectory = [[NSBundle mainBundle] pathForResource:@"法律/国家/中华人民共和国道路交通安全法.pdf" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:mainBundleDirectory];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.docview.scalesPageToFit = YES;
    
    [self.docview loadRequest:request];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setTvAttechment:nil];
    [self setDocview:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableView.tag) {
        case 1001:
            return 3;
            break;
        case 1002:
            switch (current_sel) {
                case 0:
                    return 3;
                    break;
                case 1:
                    return 3;
                    break;
                case 2:
                    return 13;
                    break;
                default:
                    break;
            }
        default:
            return -1;
            break;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *result;
    switch (tableView.tag) {
        case 1001:
            switch (indexPath.row) {
                case 0:
                    result=@"国家法律法规";
                    break;
                case 1:
                    result=@"交通部法规";
                    break;
                case 2:
                    result=@"广东省规定";
                    break;
                default:
                    break;
            }
            break;
        case 1002: 
            switch (current_sel) {
                case 0:
                    //国家法律
                    switch (indexPath.row) {
                        case 0:
                            result=@"中华人民共和国道路交通安全法";
                            break;
                        case 1:
                            result=@"中华人民共和国公路法";
                            break;
                        case 2:
                            result=@"中华人民共和国行政许可法";
                            break;
                        default:
                            break;
                    }
                    break;
                case 1:
                    //部委法规     交通部法规
                    switch (indexPath.row) {
                        case 0:
                            result=@"超限运输车辆行驶公路管理规定";
                            break;
                        case 1:
                            result=@"公路安全保护条例";
                            break;
                        case 2:
                            result=@"路政管理规定";
                            break;
                            
                        default:
                            
                            break;
                    }
                    break;
                case 2:
                    //广东法规
                    switch (indexPath.row) {
                        case 0:
                            result=@"关于印发《广东交通集团高速公路服务区管理办法》的通知";
                            break;
                        case 1:
                            result=@"关于印发交通行政执法风纪等5个规范的通知";
                            break;
                        case 2:
                            result=@"关于印发交通行政执法忌语和交通行政执法禁令的通知";
                            break;
                        case 3:
                            result=@"关于印发路政文明执法管理工作规范的通知";
                            break;
                        case 4:
                            result=@"广东省道路交通安全条例";
                            break;
                        case 5:
                            result=@"广东省公路条例";
                            break;
                        case 6:
                            result=@"广东省交通运输厅广东省公安厅关于印发广东省全面实施高速公路全路网治超工作方案的通知";
                            break;
                        case 7:
                            result=@"广东省路政档案管理办法";
                            break;
                        case 8:
                            result=@"广东省路政许可实施办法";
                            break;
                        case 9:
                            result=@"损坏公路路产赔补偿标准";
                            break;
                        case 10:
                            result=@"新广告标牌设施办法";
                            break;
                        case 11:
                            result=@"关于印发广东省路桥建设发展有限公司云梧分公司超限车辆管控方案_（试行）的通知";
                            break;
                        case 12:
                            result=@"增补公路路产赔偿项目标准";
                            break;
                        default:
                            break;
                            
                    }
                    break;
                default:
                    break;
            }
        default:
            break;
    }
    cell.textLabel.text=result;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //选择列表项
    switch (tableView.tag) {
        case 1001:
            current_sel= indexPath.row;
            if(current_sel == 0){
                self.current_sel_show_string = @"法律/国家/";
            }
            if(current_sel == 1){
                self.current_sel_show_string = @"法律/交通/";
            }
            if(current_sel == 2){
                self.current_sel_show_string = @"法律/广东省/";
            }
            [tvAttechment reloadData];
            break;
        case 1002:{
            if (indexPath) {
                UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                NSString *result = [NSString stringWithFormat:@"%@%@.pdf",self.current_sel_show_string,cell.textLabel.text];
                NSString
                *mainBundleDirectory = [[NSBundle mainBundle] pathForResource:result ofType:nil];
                NSURL *url = [NSURL fileURLWithPath:mainBundleDirectory];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                self.docview.scalesPageToFit = YES;
                
                [self.docview loadRequest:request];
            }
        }
            break;
        default:
            break;
    }
    
}


@end
