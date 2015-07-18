//
//  QRViewController
//  axth
//
//  Created by xiebinyi on 15/3/26.
//  Copyright (c) 2015年 bjbl. All rights reserved.
//
// ┏┓　　　┏┓
// ┏┛┻━━━┛┻┓
// ┃　　　　　　　┃
// ┃　　　━　　　┃
// ┃　┳┛　┗┳　┃
// ┃　　　　　　　┃
// ┃　　　┻　　　┃
// ┃　　　　　　　┃
// ┗━┓　　　┏━┛
// ┃　　　┃ 神兽保佑
// ┃　　　┃ 代码无BUG！
// ┃　　　┗━━━┓
// ┃　　　　　　　┣┓
// ┃　　　　　　　┏┛
// ┗┓┓┏━┳┓┏┛
// ┃┫┫　┃┫┫

#import <AudioToolbox/AudioToolbox.h>

#import "MainViewController.h"

#import "QRViewController.h"

@interface QRViewController ()


@end

@implementation QRViewController

#pragma mark - View Controller Methods

- (void)dealloc {
    [self.capture.layer removeFromSuperlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
    
    [self.view bringSubviewToFront:self.scanRectView];
    [self.view bringSubviewToFront:self.decodedLabel];
    [self.view bringSubviewToFront:self.bar_goMain];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.capture.delegate = self;
    self.capture.layer.frame = self.view.bounds;
    
    CGAffineTransform captureSizeTransform = CGAffineTransformMakeScale(320 / self.view.frame.size.width, 480 / self.view.frame.size.height);
    self.capture.scanRect = CGRectApplyAffineTransform(self.scanRectView.frame, captureSizeTransform);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return toInterfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;

    if ([self IsValidateURL:result.text]==1) {
        UIAlertView *mBoxView = [[UIAlertView alloc]
                                 initWithTitle:@"是否打开链接?"
                                 message:result.text
                                 delegate:self
                                 cancelButtonTitle:@"关闭"
                                 otherButtonTitles:@"确定", nil];
        [mBoxView show];

    }
    else{
        UIAlertView *mBoxView = [[UIAlertView alloc]
                                 initWithTitle:@"扫描结果"
                                 message:result.text
                                 delegate:nil
                                 cancelButtonTitle:@"关闭"
                                 otherButtonTitles:nil, nil];
        [mBoxView show];

     }

         
    // Vibrate
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [self.capture stop];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.capture start];
    });
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   if(buttonIndex==1)
   {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:alertView.message]];
   }
}



-(BOOL)IsValidateURL:(NSString *)urlString {
  
    NSError *error;
    //http+:[^\\s]* 这是检测网址的正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http+:[^\\s]*" options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        
        if (firstMatch) {
            return TRUE;
        }else{
            return FALSE;
        }
    }else{
        return FALSE;
    }
}

- (void)myTip:(NSString *)Msg
{
    UIAlertView *mBoxView=[[UIAlertView alloc]
                           initWithTitle:@"提示"
                           message:Msg
                           delegate:nil
                           cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [mBoxView show];
}
- (void)BaseTip:(NSString *)Msg Title:(NSString *)Title
{
    if([Title length]==0)
    {
        Title=@"提示";
    }
    // NSLog(@"hello");
    UIAlertView *mBoxView=[[UIAlertView alloc]
                           initWithTitle:Title
                           message:Msg
                           delegate:self
                           cancelButtonTitle:@"关闭" otherButtonTitles:nil, nil];
    [mBoxView show];
}
- (IBAction)gotoMainView:(UIBarButtonItem *)sender {
    
           //切换进入主窗体
    MainViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
    [controller initWebView];
    //将这个ViewController设置为当前的ViewController
    [self presentViewController:controller  animated:NO completion:nil];
    
}
@end
