//
//  ZYPersonInfoViewController.m
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import "ZYPersonInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "ZYHeader.h"
@interface ZYPersonInfoViewController ()

@end

@implementation ZYPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //1.自己查看自己的个人设置
    //2.查看别人的个人设置
    
    self.title =@"个人信息";
    
    //赋值
    _nameLabel.text =self.user.name;
    _nickNameT.text =self.user.nickname;
    _emailT.text =self.user.email;
    //头像
    [_logoImage setImageWithURL:[NSURL URLWithString:self.user.headerurl] placeholderImage:[UIImage imageNamed:@"head"]];
    
    if (_isSelf ==YES)
    {
        //属于自己查看自己
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithTitle:@"上传头像" style:UIBarButtonItemStylePlain target:self action:@selector(uploadLogo)];
        self.navigationItem.rightBarButtonItem =rightItem;
        
        _nickNameT.enabled =YES;
        _emailT.enabled =YES;
        _commitBtn.hidden =NO;
    }
    else
    {
        //自己查看别人
        //关闭掉编译特性
        _nickNameT.enabled =NO;
        _emailT.enabled =NO;
        _commitBtn.hidden =YES;
        
    }
    
}
//上传头像
-(void)uploadLogo
{
    UIImagePickerController *contro =[[UIImagePickerController alloc]init];
    contro.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    contro.delegate =self;
    [self presentViewController:contro animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    //0  压缩过了
    //1  没压缩
//      NSData *data =UIImageJPEGRepresentation(image, 1);
//    NSLog(@"--%d",data.length);
//    NSData *data1 =UIImageJPEGRepresentation(image, 0);
//    NSLog(@"-1-%d",data1.length);
    
    //发起请求
    [ZYHttpManager uploadImgRequestWithImage:image completionBlock:^(BOOL result, NSString *errorMessage) {
        if (result==1)
        {
            _logoImage.image =image;
        }
        else
        {
            ALERTSHOW(errorMessage);
        }
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
  
}
-(void)dealloc
{
    [_user release];
    [_nameLabel release];
    [_nickNameT release];
    [_logoImage release];
    [_emailT release];
    [_commitBtn release];
    [super dealloc];
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
