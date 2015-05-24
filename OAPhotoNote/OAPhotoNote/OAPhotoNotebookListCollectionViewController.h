//
//  OANotebookCollectionViewController.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/17.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface OAPhotoNotebookListCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;

@end
