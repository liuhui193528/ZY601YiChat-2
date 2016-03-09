//
//  ZYFilesViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYFilesViewController.h"
#import "ZYHeader.h"
@interface ZYFilesViewController ()

@end

@implementation ZYFilesViewController
-(void)dealloc
{
    [_publicArr release];
    [_personArr release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自动布局
    self.automaticallyAdjustsScrollViewInsets =NO;
    
    UISegmentedControl *contro =[[UISegmentedControl alloc]initWithItems:@[@"公共资源",@"个人资源"]];
    contro.selectedSegmentIndex =0;
    self.navigationItem.titleView =contro;
    [contro release];
    
    //右侧item
    UIBarButtonItem *_rightItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(goDownloadView)];
    self.navigationItem.rightBarButtonItem =_rightItem;
    [_rightItem release];
    
    
    
    UIScrollView *_scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, 480-64-49)];
    _scrollView.contentSize =CGSizeMake(320*2, 0);
    _scrollView.backgroundColor =[UIColor yellowColor];
    _scrollView.showsHorizontalScrollIndicator =NO;
    _scrollView.pagingEnabled =YES;
    [self.view addSubview:_scrollView];
    [_scrollView release];
    //发请求
    [ZYHttpManager getFileListRequestWithCompletionBlock:^(NSMutableArray *pubArr, NSMutableArray *perArr) {
        self.publicArr =pubArr;
        self.personArr =perArr;
        for (int i=0; i<2; i++)
        {
        ZYCollectionViewController *collection =[[ZYCollectionViewController alloc]init];
        
            collection.fileArray =(i==0)?self.publicArr:self.personArr;
             collection.view.frame =CGRectMake(i*320, 0, 320, 480-64-49);
            [_scrollView addSubview:collection.view];
            
            [self addChildViewController:collection];
            [collection release];
        }
      
        
    }];
    
}
//查看
-(void)goDownloadView
{
    
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
