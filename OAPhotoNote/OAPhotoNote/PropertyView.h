//
//  PropertyView.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/23.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NoteProperty;

@interface PropertyView : NSManagedObject

@property (nonatomic, retain) id backgroundColor;
@property (nonatomic, retain) id frame;
@property (nonatomic, retain) id textColor;
@property (nonatomic, retain) NoteProperty *noteProperty;

@end
