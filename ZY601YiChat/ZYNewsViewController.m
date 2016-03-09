//
//  ZYNewsViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYNewsViewController.h"
#import "ZYHeader.h"
#import "CustomNewsCell.h"
#import "UIImageView+WebCache.h"
@interface ZYNewsViewController ()

@end

@implementation ZYNewsViewController

-(void)dealloc
{
    [_newsArray release];
    [_tableView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //请求
    [ZYHttpManager getNewsListDataRequestWithCompletionBlock:^(NSMutableArray *array, NSString *errorMessage)
    {
        self.newsArray =array;
        [_tableView reloadData];
    }];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentfier1 =@"cell1";
     static NSString *cellIndentfier2=@"cell2";
    CustomNewsCell *cell =nil;
    ZYNews *new =[self.newsArray objectAtIndex:indexPath.row];
    if ([new.type intValue]==6)
    {
        cell =[tableView dequeueReusableCellWithIdentifier:cellIndentfier2];
        if (!cell)
        {
            //多图
            cell =[[[NSBundle mainBundle]loadNibNamed:@"CustomNewsCell" owner:nil options:nil]objectAtIndex:1];
        }
        cell.cell2Title.text =new.news_title;
        ZYImage *img1 =[new.images objectAtIndex:0];
        [cell.cell2Image1 setImageWithURL:[NSURL URLWithString:img1.imgUrl] placeholderImage:[UIImage imageNamed:@"head"]];
        ZYImage *img2 =[new.images objectAtIndex:1];
        [cell.cell2Image2 setImageWithURL:[NSURL URLWithString:img2.imgUrl] placeholderImage:[UIImage imageNamed:@"head"]];
         ZYImage *img3 =[new.images objectAtIndex:2];
         [cell.cell2Image3 setImageWithURL:[NSURL URLWithString:img3.imgUrl] placeholderImage:[UIImage imageNamed:@"head"]];
        cell.cell2Source.text =new.source;
   
    }
    else
    {
           cell =[tableView dequeueReusableCellWithIdentifier:cellIndentfier1];
        if (!cell)
        {
            cell =[[[NSBundle mainBundle]loadNibNamed:@"CustomNewsCell" owner:nil options:nil]objectAtIndex:0];
        }
        cell.cell1Title.text =new.news_title;
        ZYImage *img1 =[new.images objectAtIndex:0];
        [cell.cell1Image setImageWithURL:[NSURL URLWithString:img1.imgUrl] placeholderImage:[UIImage imageNamed:@"head"]];
        cell.cell1Source.text =new.source;
        cell.cell1Text.text =new.intro;
        
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYNews *new =[self.newsArray objectAtIndex:indexPath.row];
    if ([new.type intValue]!=6)
    {
        return 66;
    }
    else
    {
        return 90;
    }
}
//
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    //取出此次点击对应的对象
    ZYNews *news =[self.newsArray objectAtIndex:indexPath.row];
    ZYNewsInfoViewController *info =[[ZYNewsInfoViewController alloc]init];
    info.newsInfoUrl =news.source_url;
    info.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:info animated:YES];
    [info release];
}
@end





