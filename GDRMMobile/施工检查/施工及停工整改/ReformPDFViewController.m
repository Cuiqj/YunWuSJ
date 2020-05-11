//
//  ShutdownReformViewController.m
//  YUNWUMobile
//
//  Created by admin on 2020/4/7.
//停工整改

#import "ReformPDFViewController.h"

@interface ReformPDFViewController ()

@end

@implementation ReformPDFViewController

@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.uiButtonPrintFull setHidden:NO];
//    [self.uiButtonPrintForm setHidden:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnDeleteDoc:(id)sender {
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"警告" message:@"将删除当前文书并返回施工通知页面，是否继续?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.pdfFilePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:self.pdfFilePath error:nil];
            delegate.pdfFileURL = nil;
        }
        NSString *formatFilePath = [NSString stringWithFormat:@"%@.format.pdf", self.pdfFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:formatFilePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:formatFilePath error:nil];
            delegate.pdfFormatFileURL = nil;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (NSString *)CreatepdfFormatFileURL{
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[arrayPaths objectAtIndex:0];
    NSString *filePath  = [path stringByAppendingPathComponent:@"Reform"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
//    return [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.format.pdf",self.reform.myid]];
    return nil;
}

@end
