//
//  ZYNewsViewController.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYNewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView *_tableView;
}
@property(nonatomic,retain)NSMutableArray *newsArray;
@end
