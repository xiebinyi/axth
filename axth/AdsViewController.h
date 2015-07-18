//
//  AdsViewController.h
//  axth
//
//  Created by xiebinyi on 15/3/27.
//  Copyright (c) 2015年 bjbl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsViewController : UIViewController
@property(nonatomic,readonly) NSUInteger pageIndex;
-(id) initWithImageName:(NSString*)imageName atIndex:(NSUInteger)index;
@end
