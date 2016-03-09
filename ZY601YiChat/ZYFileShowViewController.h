//
//  ZYFileShowViewController.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/9.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYFile.h"
#import <MediaPlayer/MediaPlayer.h>
@interface ZYFileShowViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    MPMoviePlayerController *_player;
    
    UIWebView *_webView;
}
@property (nonatomic,retain)ZYFile *file;
@end
