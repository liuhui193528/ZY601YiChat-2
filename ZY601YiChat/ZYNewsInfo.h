//
//  ZYNewsInfo.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYNews.h"
#import "ZYData.h"
#import "ZYComment.h"

@interface ZYNewsInfo : NSObject
//新闻详情页对应的对象
//评论的数组
@property(nonatomic,retain)NSMutableArray *comments;
//数据的数组
@property(nonatomic,retain)NSMutableArray *datas;
//news对象
@property(nonatomic,retain)ZYNews *newsInfo;
+(ZYNewsInfo *)parserNewsInfoWithDic:(NSDictionary *)dic;
@end





