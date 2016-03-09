//
//  ZYButton.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYFile.h"
/*
 按钮标题
 1.下载
 2.进度
 3.继续下载
 4.查看
 */

typedef NS_ENUM(NSInteger,ZYButtonStatus){
    //下载
    ZYButtonDownloadNomal =0,
    //进度
    ZYButtonDownloading,
    //继续下载
    ZYButtonPause,
    //查看
    ZYButtonCompletion,
};
@interface ZYButton : UIButton
{
    //按钮上面的布
    UIView *_coverView;
}
//
@property(nonatomic,retain)ZYFile *file;
@property(nonatomic,assign)float progress;
//描述对应的枚举 setter方法
@property(nonatomic,assign)ZYButtonStatus buttonStatus;
@end






