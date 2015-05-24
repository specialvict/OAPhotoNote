//
//  PhotoNote.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/23.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OAPhotoNoteObject.h"

@class PhotoNotebook;

@interface PhotoNote : OAPhotoNoteObject

@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * imageInfoPath;
@property (nonatomic, retain) PhotoNotebook *photoNotebook;

@end
