//
//  ZYCollectionViewCell.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYButton.h"
@interface ZYCollectionViewCell : UICollectionViewCell
@property(nonatomic,retain)IBOutlet ZYButton *fileBtn;
@property(nonatomic,retain)IBOutlet UILabel *fileLabel;
@end
