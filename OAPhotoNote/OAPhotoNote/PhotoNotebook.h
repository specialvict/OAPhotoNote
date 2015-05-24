//
//  PhotoNotebook.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/23.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "OAPhotoNoteObject.h"

@class NSManagedObject, PhotoNote;

@interface PhotoNotebook : OAPhotoNoteObject

@property (nonatomic, retain) NSSet *photoNotes;
@property (nonatomic, retain) NSManagedObject *bookCategory;
@end

@interface PhotoNotebook (CoreDataGeneratedAccessors)

- (void)addPhotoNotesObject:(PhotoNote *)value;
- (void)removePhotoNotesObject:(PhotoNote *)value;
- (void)addPhotoNotes:(NSSet *)values;
- (void)removePhotoNotes:(NSSet *)values;

@end
