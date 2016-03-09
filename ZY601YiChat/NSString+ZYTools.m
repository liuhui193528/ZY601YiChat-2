//
//  NSString+ZYTools.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "NSString+ZYTools.h"

@implementation NSString (ZYTools)
+(NSString *)setDirectoryPath:(NSString *)dString filePath:(NSString *)fString
{
    NSString *directoryPath =[NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",dString]];
    if ([[NSFileManager defaultManager]fileExistsAtPath:directoryPath]==NO)
    {
        //创建
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //创建文件路径
    return [NSString stringWithFormat:@"%@/%@",directoryPath,fString];
}
@end





