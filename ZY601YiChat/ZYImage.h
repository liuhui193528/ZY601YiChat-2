//
//  ZYImage.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYImage : NSObject

@property(nonatomic,copy)NSString *height;
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *width;

+(ZYImage *)parserImageWithDic:(NSDictionary *)dic;
@end
