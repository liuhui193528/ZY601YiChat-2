//
//  ZYFile.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYImage.h"
@interface ZYFile : NSObject
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *image_url;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *fileDescription;
@property(nonatomic,copy)NSString *author;
@property(nonatomic,copy)NSString *tname;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *dtimes;
@property(nonatomic,copy)NSString *length;
+(ZYFile *)parserFileListWithDic:(NSDictionary *)dic;
@end




