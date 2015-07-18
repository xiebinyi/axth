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

#import "ViewController.h"
#import "AdsViewController.h"
#import "MainViewController.h"



@interface ViewController ()
{
    NSArray* _imageNames;
}
@end

@implementation ViewController


//禁止转屏
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}
- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}
//禁止转屏

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ////////////////////////////////////////////ScrollView SET////////////////////////////////////////////
    _imageNames=@[@"APP_00.png",@"APP_01.png",@"APP_02.png",@"APP_03.png"];
    
    self.dataSource=self;
    [self setViewControllers: @[[[AdsViewController alloc] initWithImageName:_imageNames[0] atIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
    ////////////////////////////////////////////ScrollView SET////////////////////////////////////////////
}





-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(AdsViewController *)viewController{
    
    AdsViewController* ctrl=(AdsViewController*)pageViewController.viewControllers[0];

    
    if(viewController.pageIndex==[_imageNames count]-1)
    {
        //切换进入主窗体
        MainViewController * controller = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
        //将这个ViewController设置为当前的ViewController
        [self presentViewController:controller animated:NO completion:nil];
        
        return nil;

    }
    else{
        if(ctrl.pageIndex==viewController.pageIndex+1)
        {
            return nil;
        }
        else
        {
        return [[AdsViewController alloc] initWithImageName:_imageNames[viewController.pageIndex+1] atIndex:viewController.pageIndex+1];
        }
     
    }
}
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(AdsViewController *)viewController
{
    AdsViewController* ctrl=(AdsViewController*)pageViewController.viewControllers[0];

    if(viewController.pageIndex==0)
    {
        return nil;
    }
    else{
        if(ctrl.pageIndex==viewController.pageIndex+1)
        {
            return nil;
        }
        else
        {
            return [[AdsViewController alloc] initWithImageName:_imageNames[viewController.pageIndex-1] atIndex:viewController.pageIndex-1];
        }
    }
}

-(NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [_imageNames count];
}
-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    AdsViewController* ctrl=(AdsViewController*)pageViewController.viewControllers[0];
    return ctrl.pageIndex;
}



///////////////////////////////////////////////////

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
