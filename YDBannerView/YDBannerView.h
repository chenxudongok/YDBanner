//
//  ZYBannerView.h
//  ZYmall
//
//  Created by 陈煜 on 16/4/6.
//  Copyright © 2016年 陈煜. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZYBannerImageStyle) {
    YDBannerImageURL,
    YDBannerImageName
};


@interface YDBannerView : UIView


/**
 *  @author 陈煜, 16-04-06 09:04:31
 *
 *  设置图片组
 *
 *  @param images 图片组
 */
-(void)setImages:(NSMutableArray *)images imageStyle:(ZYBannerImageStyle)imageStyle;

@end
