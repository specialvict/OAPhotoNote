//
//  OADocumentManager.h
//  OAPhotoNote
//
//  Created by lee on 2015/5/23.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IMAGE_DIRECTORY_NAME @"photoImgageAsset"
#define IMAGE_ORIGINAL_DIRECTORY_NAME @"originalImages"
#define IMAGE_THUMBNAIL_DIRECTORY_NAME @"thumbnailImages"

@interface OADocumentManager : NSObject


+(NSURL *)applicationDocumentsDirectory;
+(NSURL *)imageOriginalDocumentDirectory;
+(NSURL *)imageThumbnailDocumentDirectory;

+(BOOL)saveImage:(UIImage *)image forImgeName:(NSString *)imageName;
+(NSURL *)imageOriginalPathForImageName:(NSString *)imageName;
+(NSURL *)imageThumbnailPathForImageName:(NSString *)imageName;
+(UIImage *)imageOriginalImageForImagename:(NSString *)imageName;
+(UIImage *)imageThumbnailImageForImagename:(NSString *)imageName;


@end