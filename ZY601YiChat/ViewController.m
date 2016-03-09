//
//  ViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.

//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ViewController.h"
#import "ZYHeader.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIImageView *_imgView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    _imgView.image =[UIImage imageNamed:@"1.png"];
    [self.view addSubview:_imgView];
    [_imgView release];
    
    
    //开启动画
    [UIView animateWithDuration:1 animations:^{
        _imgView.alpha =0.3;
    } completion:^(BOOL finished) {
        
        [UIView transitionWithView:self.view.window duration:1 options:UIViewAnimationOptionTransitionCurlUp animations:nil completion:nil];
        
        //判断是首界面还是登陆
        
        if ([ZYHttpManager isLogin]==NO)
        {
            //登录
            LoginViewController *loginVC =[[LoginViewController alloc]init];
            UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:loginVC];
            self.view.window.rootViewController =nav;
            [loginVC release];
            [nav release];
        }
        else
        {
            //首界面
            [ViewController goMain];
        }
        
    }];
 
}
+(void)goMain
{
    UITabBarController *tabBar =[[UITabBarController alloc]init];
    
    
    ZYHomeViewController *homeVC =[[ZYHomeViewController alloc]init];
    ZYNewsViewController *newsVC =[[ZYNewsViewController alloc]init];
    ZYFilesViewController *fileVC =[[ZYFilesViewController alloc]init];
    ZYPersonViewController *personVC =[[ZYPersonViewController alloc]init];
    
    NSMutableArray *arr =[NSMutableArray arrayWithObjects:homeVC,newsVC,fileVC,personVC, nil];
    
    NSArray *titles =@[@"主页",@"新闻",@"文件",@"个人"];
    NSArray *imgs =@[@"main",@"news",@"file",@"person"];
    NSMutableArray *vcArr =[NSMutableArray array];
    for (int i=0; i<4; i++)
    {
        UIViewController *vc =arr[i];
        UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:vc];
        vc.tabBarItem.title =titles[i];
        vc.tabBarItem.image =[UIImage imageNamed:imgs[i]];
        [vcArr addObject:nav];
        
        [nav release];
    }
    
    tabBar.viewControllers =vcArr;
    
    [UIApplication sharedApplication].keyWindow.rootViewController =tabBar;
    
    
    [homeVC release];
    [newsVC release];
    [fileVC release];
    [personVC release];
    [tabBar release];

}

@end











