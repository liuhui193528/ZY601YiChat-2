//
//  ZYImage.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYImage.h"

@implementation ZYImage
+(ZYImage *)parserImageWithDic:(NSDictionary *)dic
{
    ZYImage *_img =[[[ZYImage alloc]init]autorelease];
    _img.height =[dic objectForKey:@"height"];
    _img.width =[dic objectForKey:@"width"];
    //dic>>>url  dic>>>source
    NSString *urlString =[dic objectForKey:@"url"];
    if (urlString==nil)
    {
        //新闻详情页进来
        urlString =[dic objectForKey:@"source"];
    }
   
    _img.imgUrl =[NSString stringWithFormat:@"http://127.0.0.1:8080%@",urlString];
    return _img;
}
@end




