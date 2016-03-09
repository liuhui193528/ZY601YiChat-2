//
//  ZYNewsInfoViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYNewsInfoViewController.h"
#import "ZYHeader.h"
#import "UIImageView+WebCache.h"
@interface ZYNewsInfoViewController ()

@end

@implementation ZYNewsInfoViewController
-(void)dealloc
{
    [_newsInfoUrl release];
    [_newsInfo release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    
    //发请求
    [ZYHttpManager getNewsInfoDataRequestWithSourceUrl:self.newsInfoUrl CompletionBlock:^(ZYNewsInfo *info) {
        //拿钱
        self.newsInfo =info;
        //添加标题
        self.title =self.newsInfo.newsInfo.news_title;
        
//        NSLog(@"---%@",self.newsInfo.newsInfo.intro);
        //摘要拼接
        self.newsInfo.newsInfo.intro =[NSString stringWithFormat:@"摘要:%@",self.newsInfo.newsInfo.intro];
//        ZYData *data =[self.newsInfo.datas objectAtIndex:0];
        for (ZYData *data in self.newsInfo.datas)
        {
            if ([data.dataType intValue]==1)
            {
                data.content =[NSString stringWithFormat:@"%@",data.content];
            }
        }
        [self.tableView reloadData];
    }];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0)
    {
        return 2;
    }
    else if(section==1)
    {
        return self.newsInfo.datas.count;
    }
    else
    {
        //+1 热门跟帖
        return self.newsInfo.comments.count+1;
    }
}
//计算高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            return 70;
        }
        else
        {
            
            return [self getRowHeightWithString:self.newsInfo.newsInfo.intro size:14];
        }
    }
    else if (indexPath.section==1)
    {
        ZYData *data  =[self.newsInfo.datas objectAtIndex:indexPath.row];
        if ([data.dataType intValue]==1)
        {
            return [self getRowHeightWithString:data.content size:14]+15;
        }
        else
        {
            return [data.image.height floatValue]+15;
        }
    }
    else
    {
        if (indexPath.row ==0)
        {
            return 60;
        }
        else
        {
            ZYComment *comment  =[self.newsInfo.comments objectAtIndex:indexPath.row -1];
            return [self getRowHeightWithString:comment.info size:14]+20;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIndentfier =@"cellIndentfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentfier];
    
    if (!cell)
    {
        cell =[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentfier]autorelease];
    }
    cell.accessoryType=UITableViewCellAccessoryNone;
    
    [[cell viewWithTag:100]removeFromSuperview];
    //全部恢复最初状态
    cell.textLabel.text =@"";
    cell.textLabel.textColor =[UIColor blackColor];
    cell.backgroundColor =[UIColor whiteColor];
    cell.textLabel.font =[UIFont systemFontOfSize:17];
    
    cell.detailTextLabel.text=@"";
    cell.detailTextLabel.textColor =[UIColor blackColor];
    cell.detailTextLabel.backgroundColor =[UIColor whiteColor];
    cell.detailTextLabel.font =[UIFont systemFontOfSize:15];
    
    //第一区
    if (indexPath.section ==0)
    {
        if (indexPath.row==0)
        {
            cell.textLabel.text =self.newsInfo.newsInfo.news_title;
            cell.textLabel.font =[UIFont systemFontOfSize:17];
            cell.detailTextLabel.text =[NSString stringWithFormat:@"%@   %@/文            %@",self.newsInfo.newsInfo.source,self.newsInfo.newsInfo.auther,self.newsInfo.newsInfo.time];
            cell.detailTextLabel.font =[UIFont systemFontOfSize:14];

        }
        else
        {
            //摘要
            cell.backgroundColor =[UIColor grayColor];
            cell.textLabel.text =self.newsInfo.newsInfo.intro;
            cell.textLabel.numberOfLines =0;
            cell.textLabel.font =[UIFont systemFontOfSize:13];
        }
    }
    else if(indexPath.section==1)
    {
        ZYData *data =[self.newsInfo.datas objectAtIndex:indexPath.row];
        if ([data.dataType intValue]==1)
        {
            cell.textLabel.text =data.content;
            cell.textLabel.numberOfLines =0;
            cell.textLabel.textColor =[UIColor blackColor];
            cell.textLabel.font =[UIFont systemFontOfSize:14];
        }
        else
        {
            UIImageView *imgView =[[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 290, [data.image.height floatValue])];
            //方便删除
            imgView.tag =100;
            //赋值
            [imgView setImageWithURL:[NSURL URLWithString:data.image.imgUrl]];
            [cell addSubview:imgView];
            [imgView release];
        }
    }
    else
    {
        if (indexPath.row==0)
        {
            cell.textLabel.textColor =[UIColor redColor];
            cell.textLabel.text =@"热门跟帖";
        }
        else
        {
            ZYComment *comment =[self.newsInfo.comments objectAtIndex:indexPath.row -1];
            cell.textLabel.text =[NSString stringWithFormat:@"%@:\n %@",comment.name,comment.info];
            cell.textLabel.numberOfLines=0;
            cell.textLabel.font =[UIFont systemFontOfSize:14];
        }
    }
    return cell;
}
-(float)getRowHeightWithString:(NSString *)string size:(float)size
{
    CGRect rect =[string boundingRectWithSize:CGSizeMake(290, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:size]} context:nil];
    //向上取正 3.4^^^4
    return ceilf(rect.size.height);
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
