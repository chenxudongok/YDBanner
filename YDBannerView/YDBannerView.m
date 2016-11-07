//
//  ZYBannerView.m
//  ZYmall
//
//  Created by 陈煜 on 16/4/6.
//  Copyright © 2016年 陈煜. All rights reserved.
//

#import "YDBannerView.h"

// 屏幕宽高
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
// 字体
#define FONT_SIZE [UIFont systemFontOfSize:14]


@interface YDBannerView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollview;

@property (nonatomic,strong) UIView *pageview;

@property (nonatomic,strong) UILabel *pagelable;

@property (nonatomic,strong) NSMutableString *pagestr;

@end

@implementation YDBannerView

#pragma mark - 懒加载

-(UIScrollView *)scrollview
{
    if (!_scrollview) {
        _scrollview = [[UIScrollView alloc]initWithFrame:self.frame];
        _scrollview.pagingEnabled = YES;
        _scrollview.showsVerticalScrollIndicator = NO;
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.delegate = self;
    }
    return _scrollview;
}

-(UIView *)pageview
{
    if (!_pageview) {
        _pageview = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-50, SCREEN_WIDTH-50, 40, 40)];
        _pageview.backgroundColor = [UIColor colorWithRed:0.200 green:0.173 blue:0.294 alpha:0.500];
        _pageview.layer.cornerRadius = 20;
        _pageview.layer.masksToBounds = YES;
    }
    return _pageview;
}

-(UILabel *)pagelable
{
    if (!_pagelable) {
        _pagelable = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
        _pagelable.textColor = [UIColor whiteColor];
        _pagelable.textAlignment = NSTextAlignmentCenter;
        _pagelable.font = FONT_SIZE;
    }
    return _pagelable;
}



/**
 *  @author 陈煜, 16-04-06 09:04:31
 *
 *  设置图片组
 *
 *  @param images 图片组
 */
-(void)setImages:(NSMutableArray *)images imageStyle:(ZYBannerImageStyle)imageStyle;
{
    
    [self addSubview:self.scrollview];
    
    [self.scrollview setContentSize:CGSizeMake([images count]*SCREEN_WIDTH, 0)];
    
    for (int i = 0; i<[images count]; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, self.frame.size.width, self.frame.size.height)];
        switch (imageStyle) {
            case YDBannerImageURL:
            {
                // 此处添加 SDWebImage
                //[imageview sd_setImageWithURL:images[i]];
            }
                break;
            case YDBannerImageName:
            {
                [imageview setImage:[UIImage imageNamed:(images[i])]];
            }
                break;
            default:
                break;
        }
        [self.scrollview addSubview:imageview];
    }
    self.pagestr = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"1/%lu",(unsigned long)[images count]]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.pagestr];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 1)];
    self.pagelable.attributedText = str;
    [self.pageview addSubview:self.pagelable];

    [self addSubview:self.pageview];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    
    if (offset < 0) {
        return;
    }
    
    [self.pagestr replaceCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%d",(int)(scrollView.contentOffset.x/scrollView.frame.size.width+1.5)]];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.pagestr];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 1)];
    self.pagelable.attributedText = str;
    
    NSLog(@"%f",scrollView.contentOffset.x/scrollView.frame.size.width*M_PI);
    self.pageview.layer.transform = CATransform3DMakeRotation(scrollView.contentOffset.x/scrollView.frame.size.width*M_PI, 0, 1, 0);
    
    self.pageview.layer.zPosition = 400;
    
    self.pagelable.layer.transform = CATransform3DMakeRotation(scrollView.contentOffset.x/scrollView.frame.size.width*M_PI, 0, 1, 0);
    
    for(int i=0;i<scrollView.subviews.count;i++)
    {
        NSLog(@"%d",i);
        UIImageView *subimageview = scrollView.subviews[i];
        if((offset-(self.scrollview.frame.size.width*i))>0)
        {
            subimageview.transform = CGAffineTransformMakeTranslation((offset-(self.scrollview.frame.size.width*i))/2,0);
        }
    }
}



@end
