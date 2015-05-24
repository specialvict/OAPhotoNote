//
//  CategoryCollectionViewCell.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/24.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *categoryView;
@property (weak, nonatomic) IBOutlet UILabel *categoryTitleLabel;

@end
