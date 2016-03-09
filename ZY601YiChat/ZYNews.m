//
//  ZYNews.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYNews.h"

@implementation ZYNews
-(void)dealloc
{
    [_ID release];
    [_time release];
    [_images release];
    [_source release];
    [_auther release];
    [_channel release];
    [_type release];
    [_source_url release];
    [_intro release];
    [_readtimes release];
    [super dealloc];
    
}
+(ZYNews *)parserNewsListWithDic:(NSDictionary *)dic
{
    ZYNews *n =[[[ZYNews alloc]init]autorelease];
    n.ID =[dic objectForKey:@"id"];
    n.type =[dic objectForKey:@"type"];
    n.source =[dic objectForKey:@"source"];
    n.source_url =[dic objectForKey:@"source_url"];
     n.intro =[dic objectForKey:@"intro"];
    n.time =[dic objectForKey:@"time"];
    n.auther =[dic objectForKey:@"auther"];
    n.channel =[dic objectForKey:@"channel"];
     n.news_title =[dic objectForKey:@"news_title"];
    n.images =[NSMutableArray array];
    NSArray *arr =[dic objectForKey:@"images"];
    for (NSDictionary *imgDic in arr)
    {
        ZYImage *img =[ZYImage parserImageWithDic:imgDic];
        [n.images addObject:img];
    }
    return n;
    
}
@end




