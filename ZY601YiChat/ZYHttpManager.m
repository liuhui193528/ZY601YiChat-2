//
//  ZYHttpManager.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYHttpManager.h"

@implementation ZYHttpManager

//NO表示需要登陆  yes进好友界面
+(BOOL)isLogin
{
    //token为不为空
    if (GETTOKEN==nil)
    {
        //没值
        return NO;
    }
    NSDate *guoqiDate =[[NSUserDefaults standardUserDefaults]objectForKey:GUOQITIME];
    //过期
    if ([[NSDate date]compare:guoqiDate]==NSOrderedDescending)
    {
        return NO;
    }
    
    return YES;

}
+(void)setRegisterWithUrlName:(NSString *)name psw:(NSString *)psw trueName:(NSString *)trueName email:(NSString *)email completionBlock:(RequestBlock)block
{
    __block  ASIFormDataRequest *_request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:HOST]];
    [_request setPostValue:@"ST_R" forKey:@"command"];
    [_request setPostValue:name forKey:@"name"];
    [_request setPostValue:psw forKey:@"psw"];
    [_request setPostValue:trueName forKey:@"nickname"];
    [_request setPostValue:email forKey:@"email"];
    [_request setCompletionBlock:^{
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:_request.responseData options:NSJSONReadingAllowFragments error:nil];
        int result =[[dic objectForKey:@"result"]intValue];
        if (result ==1)
        {
            block(YES,nil);
        }
        else
        {
            block(NO,[dic objectForKey:@"error"]);
        }
        
    }];
    [_request setFailedBlock:^{
        block(NO,@"没有网");
    }];
    [_request startAsynchronous];
}
+(void)setLoginRequestWithName:(NSString *)name psw:(NSString *)psw completionBlock:(RequestBlock)block
{
    __block  ASIFormDataRequest *_request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:HOST]];
    [_request setPostValue:@"ST_L" forKey:@"command"];
    [_request setPostValue:name forKey:@"name"];
    [_request setPostValue:psw forKey:@"psw"];
    [_request setCompletionBlock:^{
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:_request.responseData options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"----%@",dic);
        int result =[[dic objectForKey:@"result"]intValue];
        if (result ==1)
        {
            //存数据
            
            NSString *token =[dic objectForKey:@"access_token"];
            [[NSUserDefaults standardUserDefaults]setObject:token forKey:ACCESSTOKEN];
            //过期时间
            NSDate *date =[NSDate dateWithTimeIntervalSinceNow:[[dic objectForKey:@"time"]floatValue]];
            [[NSUserDefaults standardUserDefaults]setObject:date forKey:GUOQITIME];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            block(YES,nil);
        }
        else
        {
            block(NO,[dic objectForKey:@"error"]);
        }
//
    }];
    [_request setFailedBlock:^{
        block(NO,@"没有网");
    }];
    [_request startAsynchronous];
}
+(void)getPersonInfoRquestWithCompletionBlock:(void(^)(ZYUser *user))block
{
    __block  ASIFormDataRequest *_request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:HOST]];
    [_request setPostValue:@"ST_GPI" forKey:@"command"];
    [_request setPostValue:GETTOKEN forKey:@"access_token"];
  
    [_request setCompletionBlock:^{
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:_request.responseData options:NSJSONReadingAllowFragments error:nil];
        if (dic!=nil)
        {
            ZYUser *user =[ZYUser parserUserWithDic:[dic objectForKey:@"data"]];
            block(user);
        }
        //
    }];
    [_request setFailedBlock:^{
        block(nil);
    }];
    [_request startAsynchronous];
}
+(void)uploadImgRequestWithImage:(UIImage *)img completionBlock:(RequestBlock)block
{
    NSString *urlString =[NSString stringWithFormat:@"%@?command=ST_H&access_token=%@",HOST,GETTOKEN];
    __block  ASIFormDataRequest *_request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    
  
    
    [_request setPostBody:(NSMutableData *)UIImageJPEGRepresentation(img, 1)];
    [_request setCompletionBlock:^{
           NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:_request.responseData options:NSJSONReadingAllowFragments error:nil];
        if ([dic objectForKey:@"info"]!=nil)
        {
            block(YES,nil);
        }
        else
        {
             block(NO,@"上传失败");
        }
    }];
    [_request setFailedBlock:^{
        block(NO,@"没有网");
    }];
    [_request startAsynchronous];
}
+(void)outLoginRequestWithCompletionBlock:(RequestBlock)block
{
    NSString *urlString =[NSString stringWithFormat:HOST];
    __block  ASIFormDataRequest *_request =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    [_request setPostValue:@"ST_LO" forKey:@"command"];
     [_request setPostValue:GETTOKEN forKey:@"access_token"];
    
       [_request setCompletionBlock:^{
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:_request.responseData options:NSJSONReadingAllowFragments error:nil];
        if ([dic objectForKey:@"info"]!=nil)
        {
            block(YES,nil);
        }
        else
        {
            block(NO,[dic objectForKey:@"error"]);
        }
    }];
    [_request setFailedBlock:^{
        block(NO,@"没有网");
    }];
    [_request startAsynchronous];
}
+(void)getNewsListDataRequestWithCompletionBlock:(ArrayBlock)block
{
    __block ASIHTTPRequest *_request    =[ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1:8080/st/news/news_list.json"]];
    
    [_request setCompletionBlock:^{
        
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:_request.responseData options:NSJSONReadingAllowFragments error:nil];
        NSArray *listArray =[dic objectForKey:@"news_list"];
        NSMutableArray *newsArr =[NSMutableArray array];
        for (NSDictionary *dict in listArray)
        {
             ZYNews *n =[ZYNews parserNewsListWithDic:dict];
            [newsArr addObject:n];
        }
        block(newsArr,nil);
        
    }];
    [_request setFailedBlock:^{
        block(nil,@"没有数据");
    }];
    [_request startAsynchronous];
}
+(void)getNewsInfoDataRequestWithSourceUrl:(NSString *)urlStirng CompletionBlock:(void(^)(ZYNewsInfo *info))block
{
//    NSLog(@"-----%@",urlStirng);
    __block ASIHTTPRequest *_request    =[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://127.0.0.1:8080%@",urlStirng]]];
    
    [_request setCompletionBlock:^{
        
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:_request.responseData options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"-----%@",dic);
        //返回出来一个新闻详情的对象[包含有新闻model的对象 俩数组(数据  评论)]
        ZYNewsInfo *info =[ZYNewsInfo parserNewsInfoWithDic:dic];
        block(info);
        
    }];
    [_request setTimeOutSeconds:30];
    [_request setFailedBlock:^{
    }];
    [_request startAsynchronous];
}
+(void)getFileListRequestWithCompletionBlock:(void(^)(NSMutableArray *pubArr,NSMutableArray *perArr))block
{
    
    __block ASIHTTPRequest *_request =[ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?command=ST_F_FL&access_token=%@",HOST,GETTOKEN]]];
    
    [_request setCompletionBlock:^{
        
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:_request.responseData options:NSJSONReadingAllowFragments error:nil];
        //包含两个数组 公共资源 个人资源
        NSDictionary *dict =[dic objectForKey:@"filelist"];
        //公共资源
        NSArray *pubs =[dict objectForKey:@"pub_file"];
        NSMutableArray *pubArray =[NSMutableArray array];
        for (NSDictionary *pubDic in pubs)
        {
            ZYFile *f =[ZYFile parserFileListWithDic:pubDic];
            [pubArray addObject:f];
        }
        
        //个人资源
        NSArray *pers =[dict objectForKey:@"per_file"];
        NSMutableArray *perArray =[NSMutableArray array];
        for (NSDictionary *pubDic in pers)
        {
            ZYFile *f =[ZYFile parserFileListWithDic:pubDic];
            [perArray addObject:f];
        }
        block(pubArray,perArray);
        
    }];
    [_request setTimeOutSeconds:30];
    [_request setFailedBlock:^{
    }];
    [_request startAsynchronous];
}
@end









