//
//  ZYUser.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYUser : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *email;
@property(nonatomic,copy)NSString *headerurl;
+(ZYUser *)parserUserWithDic:(NSDictionary *)dic;
@end




