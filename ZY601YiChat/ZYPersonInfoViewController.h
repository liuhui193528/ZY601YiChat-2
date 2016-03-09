//
//  ZYPersonInfoViewController.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYUser.h"
@interface ZYPersonInfoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    IBOutlet UILabel *_nameLabel;
    
    IBOutlet UITextField *_nickNameT;
    
    IBOutlet UITextField *_emailT;
    
    IBOutlet UIImageView *_logoImage;
    
    IBOutlet UIButton *_commitBtn;
}
@property(nonatomic,assign)BOOL isSelf;
//用来接收个人中心传递过来的用户信息
@property(nonatomic,retain)ZYUser *user;
@end





