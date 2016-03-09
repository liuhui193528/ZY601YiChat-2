//
//  ZYPersonViewController.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYUser.h"
@interface ZYPersonViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet  UITableView *_tableView;
}
@property(nonatomic,retain)ZYUser *user;
@end



