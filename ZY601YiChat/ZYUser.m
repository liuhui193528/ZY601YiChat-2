//
//  ZYUser.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYUser.h"

@implementation ZYUser
-(void)dealloc
{
    [_name release];
    [_headerurl release];
    [_nickname release];
    [_email release];
    [super dealloc];
}
+(ZYUser *)parserUserWithDic:(NSDictionary *)dic
{
    ZYUser *user =[[[ZYUser alloc]init]autorelease];
    user.name =[dic objectForKey:@"name"];
    user.email =[dic objectForKey:@"email"];
   
    user.headerurl = [NSString stringWithFormat:@"http://127.0.0.1:8080/st%@",[dic objectForKey:@"headerurl"]];
    user.nickname =[dic objectForKey:@"nickname"];
    return user;
}
@end





