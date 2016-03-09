//
//  ZYPersonViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYPersonViewController.h"
#import "ZYHeader.h"
#import "UIImageView+WebCache.h"
#import "ViewController.h"
@interface ZYPersonViewController ()

@end

@implementation ZYPersonViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //发请求
    [ZYHttpManager getPersonInfoRquestWithCompletionBlock:^(ZYUser *user) {
        
        self.user =user;
        
        [_tableView reloadData];
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"个人中心";
//    self.navigationItem.title
    //自己准备个钱包
//    self.user =[[ZYUser alloc]init];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==1)
    {
        return 3;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentfier =@"cell";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    if (!cell)
    {
        cell =[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentfier]autorelease];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    if (indexPath.section==0)
    {
        cell.textLabel.text =@"个人信息";
        UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(230, 5, 60, 60)];
        
        [imgView setImageWithURL:[NSURL URLWithString:self.user.headerurl] placeholderImage:[UIImage imageNamed:@"head"]];
        NSLog(@"-----%@",self.user.headerurl);
       
        [cell.contentView addSubview:imgView];
        
        imgView.layer.cornerRadius =30;
        imgView.clipsToBounds =YES;
        [imgView release];
        
    }
    else if (indexPath.section ==1)
    {
        if (indexPath.row==0)
        {
            cell.textLabel.text =@"清理图片缓存";
        }
        else if (indexPath.row==1)

        {
            cell.textLabel.text =@"清理文件缓存";
        }
        else
        {
            cell.textLabel.text =@"退出登录";
        }
    }
    else
    {
        cell.textLabel.text =@"关于我们";
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0)
    {
        return 70;
    }
    else
    {
        return 44;
    }
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0)
    {
        //个人设置
        ZYPersonInfoViewController *info =[[ZYPersonInfoViewController alloc]init];
        info.isSelf =YES;
        //隐藏tabbar
        info.hidesBottomBarWhenPushed =YES;
        info.user =self.user;
        [self.navigationController pushViewController:info animated:YES];
        [info release];
        
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row ==2)
        {
            //发请求
            [ZYHttpManager outLoginRequestWithCompletionBlock:^(BOOL result, NSString *errorMessage)
            {
                if (result==1)
                {
                    //退出登录成功
                    
                    //删除数据
                    [[NSUserDefaults standardUserDefaults]removeObjectForKey:ACCESSTOKEN];
                     [[NSUserDefaults standardUserDefaults]removeObjectForKey:GUOQITIME];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    //回到viewController上面
                    ViewController *vi =[[ViewController alloc]init];
                    self.view.window.rootViewController =vi;
                    [vi release];
                    /*
                     self.view如果是在storyboard或者xib或者第一次alloc设置根试图控制期的时候赋值的话，系统都会默认的来为view设置成white，但是如果后期再人为去调用self.view,这个时候系统没有义务为你设置颜色需要自己设置
                     
                     */
                }
                else
                {
                    ALERTSHOW(errorMessage);
                }
            }];
        }
    }
}
@end





