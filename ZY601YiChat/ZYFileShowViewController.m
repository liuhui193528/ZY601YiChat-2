//
//  ZYFileShowViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/9.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYFileShowViewController.h"
#import "NSString+ZYTools.h"
@interface ZYFileShowViewController ()

@end

@implementation ZYFileShowViewController
-(void)dealloc
{
    [_tableView release];
    [_file release];
    [_webView release];
    [_player release];
    [super dealloc];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_player stop];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title =self.file.name;
    
    _tableView =[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    NSString *filePath =[NSString setDirectoryPath:@"Files" filePath:self.file.tname];
    //本地路径转url
    NSURL *url =[NSURL fileURLWithPath:filePath];
    
    //音频视频
    if ([self.file.type intValue]==1 ||[self.file.type intValue]==2)
    {
        _player =[[MPMoviePlayerController alloc]initWithContentURL:url];
        _player.view.frame =CGRectMake(20,0, 280, 400);
          _tableView.tableHeaderView =_player.view;
        [_player play];
    }
    else
    {
        _webView =[[UIWebView alloc]initWithFrame:CGRectMake(20,0, 280, 400)];
       _tableView.tableHeaderView =_webView;
        _webView.scalesPageToFit =YES;
        
        [_webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellI =@"cellI";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellI];
    if (!cell)
    {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellI];
    }
    cell.textLabel.text =[NSString stringWithFormat:@"%@\n%@\n%@",self.file.author,self.file.length,self.file.time];
    cell.textLabel.numberOfLines=0;
    //miaopshu
    cell.detailTextLabel.text =self.file.fileDescription;
    cell.detailTextLabel.numberOfLines=0;
    cell.detailTextLabel.font =[UIFont systemFontOfSize:14];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
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
