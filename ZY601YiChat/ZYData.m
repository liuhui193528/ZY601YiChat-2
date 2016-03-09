//
//  ZYData.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYData.h"

@implementation ZYData
-(void)dealloc
{
    [_dataType release];
    [_content release];
    [_image release];
    [super dealloc];
}
+(ZYData *)parserNewsInfoDataWithDic:(NSDictionary *)dic
{
    ZYData *data =[[[ZYData alloc]init]autorelease];
    data.dataType =[dic objectForKey:@"data_type"];
    data.content =[dic objectForKey:@"content"];
    data.image =[ZYImage parserImageWithDic:[dic objectForKey:@"image"]];
    return data;
}
@end
