//
//  ViewController.m
//  jingdong
//
//  Created by Dong on 2016/11/7.
//  Copyright © 2016年 jingdong. All rights reserved.
//

#import "ViewController.h"
#import "YDBannerView.h"
// 屏幕宽高
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
// 字体
#define FONT_SIZE [UIFont systemFontOfSize:14]

@interface ViewController ()

@property (nonatomic,strong) YDBannerView *ydbannerview;

@end

@implementation ViewController

-(YDBannerView *)ydbannerview
{
    if (!_ydbannerview) {
        _ydbannerview = [[YDBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    }
    return _ydbannerview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //imageStyle:YDBannerImageName   imageStyle 有两种模式，一种是图片名字读取，一种是图片路径url读取
    
    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg", nil];
    [self.ydbannerview setImages:imageArray imageStyle:YDBannerImageName];
    
    [self.view addSubview:self.ydbannerview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
