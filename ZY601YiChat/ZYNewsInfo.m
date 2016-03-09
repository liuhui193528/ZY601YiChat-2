//
//  ZYNewsInfo.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYNewsInfo.h"

@implementation ZYNewsInfo
-(void)dealloc
{
    [_datas release];
    [_comments release];
    [_newsInfo release];
    [super dealloc];
}
+(ZYNewsInfo *)parserNewsInfoWithDic:(NSDictionary *)dic
{
    ZYNewsInfo *info =[[[ZYNewsInfo alloc]init]autorelease];
    //数据
    info.datas =[NSMutableArray array];
    NSArray *dataArray =[dic objectForKey:@"data"];
    for (NSDictionary *dict in dataArray)
    {
        ZYData *data =[ZYData parserNewsInfoDataWithDic:dict];
        [info.datas addObject:data];
    }
    //评论
    info.comments =[NSMutableArray array];
    NSArray *commentArray =[dic objectForKey:@"comments"];
    for (NSDictionary *commentdic in commentArray)
    {
        ZYComment *c =[ZYComment parserNewsInfoCommentWithDic:commentdic];
        [info.comments addObject:c];
    }
    info.newsInfo =[ZYNews parserNewsListWithDic:[dic objectForKey:@"info"]];
    
    return info;
}
@end
