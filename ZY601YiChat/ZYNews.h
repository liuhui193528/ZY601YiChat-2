//
//  ZYNews.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYImage.h"

@interface ZYNews : NSObject

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *channel;

@property(nonatomic,copy)NSString *news_title;
@property(nonatomic,copy)NSString *intro;
@property(nonatomic,copy)NSString *source_url;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *source;
@property(nonatomic,copy)NSString *readtimes;
@property(nonatomic,copy)NSString *auther;

@property(nonatomic,retain)NSMutableArray *images;

+(ZYNews *)parserNewsListWithDic:(NSDictionary *)dic;


@end
