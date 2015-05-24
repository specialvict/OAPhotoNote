//
//  OATextFieldTableViewCell.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/23.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OATextFieldTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *propertyTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *propertyTextField;

@end
