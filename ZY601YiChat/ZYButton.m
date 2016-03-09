//
//  ZYButton.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYButton.h"
#import "ZYDownloadManager.h"
@implementation ZYButton
-(void)dealloc
{
    [_file release];
    [super dealloc];
}
//代码构建对象调用
//-(id)init
//xib拖拽
- (void)awakeFromNib {
    
    //通知(每一个按钮都有一个自身的通知)
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(downLoadProgress:) name:@"gengxinla" object:nil];
    
    _coverView =[[UIView alloc]initWithFrame:self.frame];
    _coverView.backgroundColor =[UIColor redColor];
    _coverView.alpha =0.3;
    _coverView.userInteractionEnabled =NO;
    [self addSubview:_coverView];
    [_coverView release];
}
//检测到有进度更新的时候通知触发该方法
-(void)downLoadProgress:(NSNotification *)info
{
    ZYDownloadManager *manager =(ZYDownloadManager *)info.object;
    //
    if (manager.file ==self.file)
    {
        //点击的按钮找到了
        NSDictionary *dic =info.userInfo;
        NSNumber *number =[dic objectForKey:@"newPro"];
        self.progress =[number floatValue];
    }
    
    /*
     {name = gengxinla; object = <ZYDownloadManager: 0x797aaf50>; userInfo = {
     newPro = 1;
     }}
     
     */
}
-(void)setProgress:(float)progress
{
    _progress =progress;
    //设置
    CGRect rect =_coverView.frame;
    
    //设置y>>>>>+
    rect.origin.y =progress*60;
    
    //高度
    rect.size.height =(1-progress)*60;
    _coverView.frame =rect;
    //确保每一次进度更新的时候都能触发到👇的方法
    self.buttonStatus =ZYButtonDownloading;
    if (self.progress>=1)
    {
        self.buttonStatus =ZYButtonCompletion;
    }
 
}

-(void)setButtonStatus:(ZYButtonStatus)buttonStatus
{
    _buttonStatus =buttonStatus;
    switch (buttonStatus) {
        case ZYButtonDownloadNomal:
        {
            [self setTitle:@"下载" forState:UIControlStateNormal];
        }
            break;
            //正在下载中
        case ZYButtonDownloading:
        {
            NSString *proString =[NSString stringWithFormat:@"%.2f%%",self.progress*100];
            [self setTitle:proString forState:UIControlStateNormal];
        }
            break;
            case ZYButtonPause:
        {
             [self setTitle:@"继续下载" forState:UIControlStateNormal];
        }
            break;
            
             case ZYButtonCompletion:
        {
            [self setTitle:@"查看" forState:UIControlStateNormal];
        }
            break;

        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 //系统调用
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
