//
//  OAPhotoNoteObject.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/23.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class HashTag, NoteProperty;

@interface OAPhotoNoteObject : NSManagedObject

@property (nonatomic, retain) id backgroundColor;
@property (nonatomic, retain) NSString * contentDescription;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * updateDate;
@property (nonatomic, retain) NSSet *hashTags;
@property (nonatomic, retain) NSSet *noteProperties;
@end

@interface OAPhotoNoteObject (CoreDataGeneratedAccessors)

- (void)addHashTagsObject:(HashTag *)value;
- (void)removeHashTagsObject:(HashTag *)value;
- (void)addHashTags:(NSSet *)values;
- (void)removeHashTags:(NSSet *)values;

- (void)addNotePropertiesObject:(NoteProperty *)value;
- (void)removeNotePropertiesObject:(NoteProperty *)value;
- (void)addNoteProperties:(NSSet *)values;
- (void)removeNoteProperties:(NSSet *)values;

@end
