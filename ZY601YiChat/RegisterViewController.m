//
//  RegisterViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "RegisterViewController.h"
#import "ZYHeader.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
//提交
-(IBAction)commitBtnCLick:(id)sender
{
    //一些常规的判断是又客户端完成的。
    
    [ZYHttpManager setRegisterWithUrlName:_nameText.text psw:_pswText.text trueName:_tureName.text email:_emailText.text completionBlock:^(BOOL result, NSString *errorMessage)
    {
        if (result ==1)
        {
            //注册成功
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
             //注册失败
            ALERTSHOW(errorMessage);
        }
    }];
}
-(void)dealloc
{
    [_nameText release];
    [_pswText release];
    [_tureName release];
    [_emailText release];
    [super dealloc];
}
@end





