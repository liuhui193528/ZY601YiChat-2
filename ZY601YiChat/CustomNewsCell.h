//
//  CustomNewsCell.h
//  ZY601YiChat
//
//  Created by broncho on 16/3/7.
//  Copyright © 2016年 xiabeibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomNewsCell : UITableViewCell

//Cell1
@property(nonatomic,retain)IBOutlet UIImageView *cell1Image;
@property(nonatomic,retain)IBOutlet UILabel *cell1Title;
@property(nonatomic,retain)IBOutlet UILabel *cell1Text;
@property(nonatomic,retain)IBOutlet UILabel *cell1Source;


//Cell2
@property(nonatomic,retain)IBOutlet UIImageView *cell2Image1;
@property(nonatomic,retain)IBOutlet UIImageView *cell2Image2;
@property(nonatomic,retain)IBOutlet UIImageView *cell2Image3;
@property(nonatomic,retain)IBOutlet UILabel *cell2Title;
@property(nonatomic,retain)IBOutlet UILabel *cell2Source;


@end

