//
//  ViewController.m
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
// ┗┻┛　┗┻┛

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UIWebViewDelegate>
{
    UIActivityIndicatorView* activityIndicatorView;
    UIView* opaqueview;
        
}


- (IBAction)btnShare:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

-(void)initWebView;

@end
