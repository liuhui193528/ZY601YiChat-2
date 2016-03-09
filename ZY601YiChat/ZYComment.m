//
//  ZYComment.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYComment.h"

@implementation ZYComment
-(void)dealloc
{
    [_info release];
    [_name release];
    [super dealloc];
}
+(ZYComment *)parserNewsInfoCommentWithDic:(NSDictionary *)dic
{
    ZYComment *comment =[[[ZYComment alloc]init]autorelease];
    comment.name =[dic objectForKey:@"name"];
    comment.info =[dic objectForKey:@"info"];
    return comment;
}
@end





