//
//  NoteProperty.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/23.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OAPhotoNoteObject, PropertyView;

@interface NoteProperty : NSManagedObject

@property (nonatomic, retain) NSString * propertyKey;
@property (nonatomic, retain) NSString * propertyString;
@property (nonatomic, retain) NSNumber * isNeedDisplay;
@property (nonatomic, retain) OAPhotoNoteObject *photoNoteObject;
@property (nonatomic, retain) PropertyView *propertyView;

@end
