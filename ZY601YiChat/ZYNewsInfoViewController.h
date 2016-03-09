//
//  ZYNewsInfoViewController.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYNewsInfo.h"
@interface ZYNewsInfoViewController : UITableViewController

@property(nonatomic,copy)NSString *newsInfoUrl;
@property(nonatomic,retain)ZYNewsInfo *newsInfo;
@end





