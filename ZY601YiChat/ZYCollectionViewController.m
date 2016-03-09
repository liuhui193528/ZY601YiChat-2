//
//  ZYCollectionViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYCollectionViewController.h"
#import "ZYCollectionViewCell.h"
#import "ZYFile.h"
#import "UIButton+WebCache.h"
#import "ZYHeader.h"
#import "NSString+ZYTools.h"
@interface ZYCollectionViewController ()

@end

@implementation ZYCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _managerDic =[[NSMutableDictionary alloc]initWithCapacity:0];
  
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset =UIEdgeInsetsMake(5, 5, 5, 5);
    layout.itemSize =CGSizeMake(60, 90);
    layout.minimumInteritemSpacing =10;
    
    UICollectionView *collection =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-64-49) collectionViewLayout:layout];
    collection.delegate =self;
    collection.dataSource =self;
    [collection registerNib:[UINib nibWithNibName:@"ZYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell123"];
    collection.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:collection];
    [collection release];
    
   
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.fileArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZYCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell123" forIndexPath:indexPath];
    cell.backgroundColor =[UIColor grayColor];
    ZYFile *file =[self.fileArray objectAtIndex:indexPath.row];
    //记录下来按钮身上对应的file文件
    cell.fileBtn.file =file;
//    [cell.fileBtn setImageWithURL:[NSURL URLWithString:file.image_url]];
    [cell.fileBtn setBackgroundImageWithURL:[NSURL URLWithString:file.image_url]];
    [cell.fileBtn addTarget:self action:@selector(downLoadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.fileLabel.text =file.name;
    //根据当前父视图自适应
    cell.fileLabel.adjustsFontSizeToFitWidth =YES;
    //触发button类的set方法
//    cell.fileBtn.buttonStatus =ZYButtonDownloadNomal;
    /*
     1.完成  2.未完成
     
     */
    //未完成
     NSString *tmpString =[NSString setDirectoryPath:@"FilesCaches" filePath:cell.fileBtn.file.tname];
    
    //完成路径
    NSString *okString =[NSString setDirectoryPath:@"Files" filePath:cell.fileBtn.file.tname];
    if ([[NSFileManager defaultManager]fileExistsAtPath:tmpString])
    {
        long long size =[[[NSFileManager defaultManager]attributesOfItemAtPath:tmpString error:nil]fileSize];
        cell.fileBtn.progress =size/[cell.fileBtn.file.length floatValue];
        
        //没下载完
        //查看manager能不能从dic里面取出来东西
        ZYDownloadManager *_loadM =[_managerDic objectForKey:cell.fileBtn.file.tname];
        if (_loadM)
        {
            //在临时路径  点过
            cell.fileBtn.buttonStatus =ZYButtonDownloading;
        }else
        {
            //再次下载的时候又出现暂停的情况
            if ([_loadM isDownload])
            {
                cell.fileBtn.buttonStatus =ZYButtonDownloading;
            }
            else
            {
                cell.fileBtn.buttonStatus =ZYButtonPause;
            }
            
        }
    }

   else if ([[NSFileManager defaultManager]fileExistsAtPath:okString])
    {
        //有值
        cell.fileBtn.buttonStatus =ZYButtonCompletion;
        cell.fileBtn.progress =1.0;
    }
    else
    {
        cell.fileBtn.buttonStatus =ZYButtonDownloadNomal;

    }
    
    
    
    return cell;
}
//下载按钮的点击
-(void)downLoadBtnClick:(ZYButton *)button
{
//    button.file
    //下载   暂停>>下载>>完成 >>下载管理器
    //每点击一次按钮是有一个单独的下载器诞生的[只有之前没有点过的按钮才具备创建下载器的能力]
    
    //如果每个按钮点击创建下载器的同时，存下来下载器，下一次在点击按钮的时候根据按钮的文件名字去取，取出来就是之前点过，取不出来就是之前没有创建
    
    ZYDownloadManager *_loadM =[_managerDic objectForKey:button.file.tname];
    if (!_loadM)
    {
        //啥都没取出来  证明之前没下载过
          _loadM=[[ZYDownloadManager alloc]initWithFile:button.file];
        [_managerDic setObject:_loadM forKey:button.file.tname];
    }

    //有判断
    switch (button.buttonStatus)
    {
            //从来都没下载过
        case ZYButtonDownloadNomal:
        case ZYButtonPause:
        {
            //开始下载
            [_loadM startDownload];
            //改变状态
            button.buttonStatus =ZYButtonDownloading;
        }
            break;
            //正在下载中>>>>暂停
            case ZYButtonDownloading:
        {
            //直接命令asi清空就可以了，因为asi有断点下载的功能
            [_loadM stopDownload];
            button.buttonStatus =ZYButtonPause;
        }
            break;
            case ZYButtonCompletion:
        {
            ZYFileShowViewController *show =[[ZYFileShowViewController alloc]init];
            show.file =button.file;
            show.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:show animated:YES];
            [show release];
        }
            
        default:
            break;
    }

//    [manager release];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
