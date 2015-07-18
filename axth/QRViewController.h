//
//  QRViewController.h
//  axth
//
//  Created by xiebinyi on 15/3/27.
//  Copyright (c) 2015年 bjbl. All rights reserved.
//

#import <ZXingObjC/ZXingObjC.h>
#import "UIKit/UIKit.h"

@interface QRViewController : UIViewController <ZXCaptureDelegate>

@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, weak) IBOutlet UIView *scanRectView;
@property (nonatomic, weak) IBOutlet UILabel *decodedLabel;

@property (weak, nonatomic) IBOutlet UINavigationBar *bar_goMain;
- (IBAction)gotoMainView:(UIBarButtonItem *)sender;

@end
