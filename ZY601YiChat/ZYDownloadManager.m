//
//  ZYDownloadManager.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYDownloadManager.h"
@implementation ZYDownloadManager
-(void)dealloc
{
    [_file release];
    [super dealloc];
}
-(id)initWithFile:(ZYFile *)file
{
    if (self =[super init])
    {
        self.file =file;
    }
    return self;
}
-(void)startDownload
{
    _request =[ASIHTTPRequest requestWithURL:[NSURL URLWithString:self.file.url]];
    //断点
    _request.downloadProgressDelegate =self;
    //完成路径
    _request.downloadDestinationPath =[NSString setDirectoryPath:@"Files" filePath:self.file.tname];
    _request.temporaryFileDownloadPath =[NSString setDirectoryPath:@"FilesCaches" filePath:self.file.tname];
    NSLog(@"----%@",[NSString setDirectoryPath:@"FilesCaches" filePath:self.file.tname]);
    //断点打开
    _request.allowResumeForFileDownloads =YES;
    [_request setTimeOutSeconds:30];
    [_request startAsynchronous];
}
-(void)stopDownload
{
    //清空代理
    [_request clearDelegatesAndCancel];
    _request =nil;
}
-(BOOL)isDownload
{
    if (_request==nil)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}
- (void)setProgress:(float)newProgress
{
    //告诉当前按钮下载进度 更新coverView
    NSMutableDictionary *dic =[[NSMutableDictionary alloc]initWithCapacity:0];
    NSNumber *number =[NSNumber numberWithFloat:newProgress];
    [dic setObject:number forKey:@"newPro"];
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"gengxinla" object:dic];
    //帮当前self传递过去 拿着self上面的file属性去和zybutton上面的file匹配 就能避免所有的按钮都收到通知之后多余操作
    [[NSNotificationCenter defaultCenter]postNotificationName:@"gengxinla" object:self userInfo:dic];
}
@end






