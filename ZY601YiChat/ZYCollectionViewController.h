//
//  ZYCollectionViewController.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYCollectionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>
{
    //用来存下载器
    NSMutableDictionary *_managerDic;
}
//公共资源  个人资源
@property(nonatomic,retain)NSMutableArray *fileArray;
@end




