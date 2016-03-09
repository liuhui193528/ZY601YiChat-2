//
//  ZYCollectionViewCell.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/8.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYCollectionViewCell.h"

@implementation ZYCollectionViewCell
-(void)dealloc
{
    [_fileBtn release];
    [_fileLabel release];
    [super dealloc];
}
- (void)awakeFromNib {
    // Initialization code
}

@end
