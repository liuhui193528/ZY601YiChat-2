//
//  ZYDownloadManager.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYFile.h"
#import "ZYHeader.h"

//负责下载
@interface ZYDownloadManager : NSObject<ASIProgressDelegate>
{
    ASIHTTPRequest *_request;
}
@property(nonatomic,retain)ZYFile *file;
-(id)initWithFile:(ZYFile *)file;
//开始下载
-(void)startDownload;
//暂停
-(void)stopDownload;
//检测是否终端下载
-(BOOL)isDownload;
@end




