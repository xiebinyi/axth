//
//  ViewController.m
//  axth
//
//  Created by xiebinyi on 15/3/26.
//  Copyright (c) 2015年 bjbl. All rights reserved.
//
// ┏┓　　　┏┓
// ┏┛┻━━━┛┻┓
// ┃　　      ┃
// ┃　　　━　　　┃
// ┃　┳┛　┗┳　┃
// ┃　　　　　　　┃
// ┃　　　┻　　　┃/Users/WorkSpace/Baidu-Frontia-iOS-2/demo/FrontiaDemo/lib_third
// ┃　　　　　　　┃
// ┗━┓　　　┏━┛
// ┃　　　┃ 神兽保佑
// ┃　　　┃ 代码无BUG！
// ┃　　　┗━━━┓
// ┃　　　　　　　┣┓
// ┃　　　　　　　┏┛
// ┗┓┓┏━┳┓┏┛
// ┃┫┫　┃┫┫
// ┗┻┛　┗┻┛



#import <Frontia/FrontiaAuthorization.h>
#import <Frontia/Frontia.h>
#import <Frontia/FrontiaStorage.h>
#import <Frontia/FrontiaStorageDelegate.h>
#import <Frontia/FrontiaPush.h>
#import <Frontia/FrontiaPersonalStorage.h>
#import <Frontia/FrontiaPersonalStorageDelegate.h>
#import <Frontia/FrontiaQuery.h>
#import <Frontia/FrontiaFile.h>
#import <Frontia/FrontiaData.h>
#import <Frontia/FrontiaUser.h>
#import <Frontia/FrontiaRole.h>
#import <Frontia/FrontiaACL.h>
#import <Frontia/FrontiaLBSDelegate.h>

#import "MainViewController.h"
#import "JSONKit.h"
#import "QRViewController.h"

typedef NS_ENUM(NSInteger, CMDMessageFrom) {
    CMDMessageFromPCS,
    CMDMessageFromBCS,
    CMDMessageFromBSS,
    CMDMessageFromPUSH
};

#define APP_KEY @"Xg9Pps5gQ7NA3Wa6uYmgoldz"   //你自己的应用api key


@interface MainViewController (){
    NSString *HomeLink;
    NSString *IMSI_NO;
    
    NSString *accessToken;
    CMDMessageFrom messageFrom;
    
    NSString *WX_KEY;
    
}
@end

static NSString* cursor;

@implementation MainViewController

UIAlertView *myAlert=nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HomeLink= @"http://abc.bjblerp.com:52560/Home/Index/";
    IMSI_NO= [self getSerialinumber];
    WX_KEY=@"wx6265e30c5e828d1d";
    ////////////////////////////////////////////WebView SET///////////////////////////////////////////
    [self initWebView];    
    ////////////////////////////////////////////WebView SET////////////////////////////////////////////
    
    _titleImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [_titleImageView addGestureRecognizer:singleTap];
    
}
-(void)initWebView
{
    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:1 diskCapacity:1 diskPath:nil];
    [NSURLCache setSharedURLCache:cache];
    [_webView setBackgroundColor:[UIColor clearColor]];
    [_webView   setUserInteractionEnabled: YES ];  //是否支持交互
    [_webView   setDelegate: self ];  //委托
    [_webView   setOpaque: NO ];  //透明
    [self.view  addSubview : _webView];  //加载到自己的view
    [_webView setScalesPageToFit:YES]; //自动缩放以适应屏幕
    [self OpenUrl:[HomeLink stringByAppendingString:IMSI_NO]];


}
//Title 点击 返回首页
- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer {
    
    [self OpenUrl:[HomeLink stringByAppendingString:IMSI_NO]];
}


///////////////////////////////////////////////////


//显示进度滚轮指示器
-(void)webViewDidStartLoad:(UIWebView *)webView{
    if(myAlert==nil){
        myAlert =[[UIAlertView alloc]initWithTitle:nil
                                           message: @"正在读取数据..."
                                          delegate:self
                                 cancelButtonTitle:nil
                                 otherButtonTitles:nil];
        
        UIActivityIndicatorView *activityView =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityView.frame= CGRectMake(120.f, 48.0f, 37.0f, 37.0f);
        [myAlert addSubview:activityView];
        [activityView startAnimating];
        [myAlert show];
    }
}

//消除滚动轮指示器
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [myAlert dismissWithClickedButtonIndex:0 animated:YES];
    
}


-(void) OpenUrl:(NSString *)urlAddress
{
    
    NSURL *url=[NSURL URLWithString:urlAddress];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
    
}


-(NSString *)getSerialinumber{
    
    NSString *IMEI=@"";
    
    #if !TARGET_IPHONE_SIMULATOR
    
        IMEI= @"11111111";
    
    #else
    
        IMEI= @"000000000";
    
    #endif
    
    return IMEI;
    
}


//Java 回调
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *rURL=[[request URL] absoluteString];
    //二维码
    if ([rURL hasPrefix:@"axth:callqr"]) {
     
        //切换进入主窗体
        QRViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"qrview"];
        //将这个ViewController设置为当前的ViewController
        [self presentViewController:controller animated:NO completion:nil];
        
        return NO;
    }
    //电话
    if ([rURL hasPrefix:@"axth:calltel"]) {
        
        NSString *telnum=[rURL substringWithRange:NSMakeRange(13,[rURL length]-13)];
        NSString *baseURL=[NSString stringWithFormat:@"tel://%@",telnum];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:baseURL]];
        
        return NO;
    }
     //QQ
    if ([rURL hasPrefix:@"axth:callqq"]) {
        
        NSString *qqnum=[rURL substringWithRange:NSMakeRange(12,[rURL length]-12)];
        NSString *baseURL=[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqnum];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:baseURL]];
        return NO;
    }
   
    return true;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    UIAlertView *connectionError = [[UIAlertView alloc] initWithTitle:@"提示！" message:@"Error connecting to page.  Please check your 3G and/or Wifi settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [connectionError show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnShare:(UIButton *)sender {
    

    //  分享平台
    [Frontia initWithApiKey:APP_KEY];
    //FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION
    NSArray *sharePlatforms = @[FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_SESSION,FRONTIA_SOCIAL_SHARE_PLATFORM_WEIXIN_TIMELINE,FRONTIA_SOCIAL_SHARE_PLATFORM_EMAIL,FRONTIA_SOCIAL_SHARE_PLATFORM_SMS];
    [[Frontia getShare] registerWeixinAppId:WX_KEY];
    //[[Frontia getShare] registerQQAppId:QQ_KEY enableSSO:NO];
    FrontiaShare *share = [Frontia getShare];
    
    //授权取消回调函数
    FrontiaShareCancelCallback onCancel = ^(){
        NSLog(@"OnCancel: share is cancelled");
    };
    
    //授权失败回调函数
    FrontiaShareFailureCallback onFailure = ^(int errorCode, NSString *errorMessage){
        NSLog(@"OnFailure: %d  %@", errorCode, errorMessage);
    };
    
    //授权成功回调函数
    FrontiaSingleShareResultCallback onResult = ^(){
        NSLog(@"OnResult: share success");
    };
    
    FrontiaShareContent *content=[[FrontiaShareContent alloc] init];
    content.url = @"http://abc.bjblerp.com:81/AXTH/index.html";
    content.title = @"安信泰华";
    content.description = @"安信泰华（北京）商业有限公司是一家致力于有机食品、保健食品、环保产品推广以及有机食品、餐饮连锁店建设的综合商业服务平台.";
    //content.imageObj = @"icon.png";
    
    
    [share showShareMenuWithShareContent:content displayPlatforms:sharePlatforms supportedInterfaceOrientations:UIInterfaceOrientationMaskPortrait isStatusBarHidden:NO targetViewForPad:sender cancelListener:onCancel failureListener:onFailure resultListener:onResult];


}


@end
