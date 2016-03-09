//
//  ZYFile.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYFile.h"

@implementation ZYFile
-(void)dealloc
{
    [_name release];
    [_time release];
    [_tname release];
    [_type release];
    [_author release];
    [_fileDescription release];
    [_dtimes release];
    [_length release];
    [_image_url release];
    [_url release];
    [super dealloc];
    
}
+(ZYFile *)parserFileListWithDic:(NSDictionary *)dic
{
    ZYFile *file =[[[ZYFile alloc]init]autorelease];
    file.name =[dic objectForKey:@"name"];
    file.fileDescription =[dic objectForKey:@"description"];
    file.time =[dic objectForKey:@"time"];
    file.tname =[dic objectForKey:@"tname"];
    file.type =[dic objectForKey:@"type"];
    file.author =[dic objectForKey:@"author"];
    file.type =[dic objectForKey:@"type"];
    file.image_url =[dic objectForKey:@"image_url"];
    file.url =[dic objectForKey:@"url"];
    file.dtimes =[dic objectForKey:@"dtimes"];
     file.length =[dic objectForKey:@"length"];

    return file;
}
@end





