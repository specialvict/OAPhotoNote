//
//  HashTag.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/23.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OAPhotoNoteObject;

@interface HashTag : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) OAPhotoNoteObject *photoNoteObject;

@end
