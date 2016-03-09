//
//  ZYHttpManager.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ZYHeader.h"
#import "ZYUser.h"
#import "ZYNews.h"
#import "ZYNewsInfo.h"
#import "ZYFile.h"

//一参此次请求是否成功  2参是错误信息
typedef void(^RequestBlock)(BOOL result,NSString *errorMessage);

typedef void(^ArrayBlock)(NSMutableArray *array,NSString *errorMessage);

@interface ZYHttpManager : NSObject


//判断有没有登录
+(BOOL)isLogin;
//注册
+(void)setRegisterWithUrlName:(NSString *)name psw:(NSString *)psw trueName:(NSString *)trueName email:(NSString *)email completionBlock:(RequestBlock)block;
//登录
+(void)setLoginRequestWithName:(NSString *)name psw:(NSString *)psw completionBlock:(RequestBlock)block;
//获取个人信息
+(void)getPersonInfoRquestWithCompletionBlock:(void(^)(ZYUser *user))block;
//上传头像
+(void)uploadImgRequestWithImage:(UIImage *)img completionBlock:(RequestBlock)block;
//退出登录
+(void)outLoginRequestWithCompletionBlock:(RequestBlock)block;
//拿新闻列表数据
+(void)getNewsListDataRequestWithCompletionBlock:(ArrayBlock)block;
//拿新闻详情页
+(void)getNewsInfoDataRequestWithSourceUrl:(NSString *)urlStirng CompletionBlock:(void(^)(ZYNewsInfo *info))block;
//拿文件资源
+(void)getFileListRequestWithCompletionBlock:(void(^)(NSMutableArray *pubArr,NSMutableArray *perArr))block;
@end






