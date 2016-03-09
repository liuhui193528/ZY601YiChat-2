//
//  LoginViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "LoginViewController.h"
#import "ZYHeader.h"
#import "ViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"登录";
}
-(IBAction)registerBtnClick:(id)sender
{
    RegisterViewController *zhuce =[[RegisterViewController alloc]init];
    [self.navigationController pushViewController:zhuce animated:YES];
    [zhuce release];
}
-(IBAction)loginBtnClick:(id)sender
{
    [ZYHttpManager setLoginRequestWithName:_nameText.text psw:_pswText.text completionBlock:^(BOOL result, NSString *errorMessage) {
        
        if (result==1)
        {
            //加载首界面
            [ViewController goMain];
        }
        else
        {
            ALERTSHOW(errorMessage);
        }
    }];
}
-(void)dealloc
{
    [_nameText release];
    [_pswText release];
    [super dealloc];
}
@end
