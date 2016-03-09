//
//  ZYHeader.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

/*
 
 张雪霞
 
 电话:13673356091
 
 QQ:1373526321
 
 */



#ifndef ZYHeader_h
#define ZYHeader_h
//放一些常用的头文件  以及宏定义
#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ZYHttpManager.h"
#import "ZYHomeViewController.h"
#import "ZYPersonViewController.h"
#import "ZYFilesViewController.h"
#import "ZYNewsViewController.h"
#import "ZYPersonInfoViewController.h"
#import "ZYNewsInfoViewController.h"
#import "ZYFilesInfoViewController.h"
#import "ZYCollectionViewController.h"
#import "ZYDownloadManager.h"
#import "NSString+ZYTools.h"
#import "ZYFileShowViewController.h"


//常用的url
#define HOST @"http://127.0.0.1:8080/st/s"

#define ALERTSHOW(errorMessage)  UIAlertController *_controller =[UIAlertController alertControllerWithTitle:@"温馨提示" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];[_controller addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];[self presentViewController:_controller animated:YES completion:nil];

#define ACCESSTOKEN @"TOKEN"

#define GUOQITIME   @"TIMER"

#define GETTOKEN        [[NSUserDefaults standardUserDefaults]objectForKey:ACCESSTOKEN]

#endif /* ZYHeader_h */






