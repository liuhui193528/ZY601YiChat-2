//
//  ZYData.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYImage.h"
//新闻详情界面的数据
@interface ZYData : NSObject
//1.文字   2.图片
@property(nonatomic,copy)NSString *dataType;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,retain)ZYImage *image;
+(ZYData *)parserNewsInfoDataWithDic:(NSDictionary *)dic;
@end




