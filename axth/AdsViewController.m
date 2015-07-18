//
//  AdsViewController.m
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

#import "AdsViewController.h"

@interface AdsViewController ()
{
    UIImage *_image;
    NSUInteger _pageIndex;
}
@end

@implementation AdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id) initWithImageName:(NSString *)imageName atIndex:(NSUInteger)index
{
    if ((self=[super init])) {
        _image=[UIImage imageNamed:imageName];
        _pageIndex=index;
    }
    return self;
}
-(void)loadView
{
    self.view=[[UIImageView alloc] initWithImage:_image];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
