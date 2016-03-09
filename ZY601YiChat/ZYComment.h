//
//  ZYComment.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYComment : NSObject
//评论内容
@property(nonatomic,copy)NSString *info;
//用户名称
@property(nonatomic,copy)NSString *name;
+(ZYComment *)parserNewsInfoCommentWithDic:(NSDictionary *)dic;
@end
