//
//  OADocumentManager.m
//  OAPhotoNote
//
//  Created by lee on 2015/5/23.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import "OADocumentManager.h"

@implementation OADocumentManager


+(NSURL *)applicationDocumentsDirectory{

//    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = [urls objectAtIndex:0];
    return documentsDirectory;
}



+(BOOL)existDirectoryForPath:(NSURL *)URLPath{
    NSString * path = URLPath.absoluteString;
    BOOL isDirectory;
    BOOL isSuccess = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return isSuccess && isDirectory;
}

+(BOOL)createDirectoryForPath:(NSURL *)URLPath{
    NSError * error;
    NSString * path = URLPath.path;
    NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                     forKey:NSFileProtectionKey];
    BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:path
                                               withIntermediateDirectories:YES
                                                                attributes:attr
                                                                     error:&error];
    if(!isSuccess){
        NSLog(@"error to create file directory %@",error);
    }

    return isSuccess;
}

#pragma mark - image methods
+(NSURL *)imageDocumentDirectory{
    return [[OADocumentManager applicationDocumentsDirectory] URLByAppendingPathComponent:IMAGE_DIRECTORY_NAME];
}

+(NSURL *)imageOriginalDocumentDirectory{
    return [[OADocumentManager imageDocumentDirectory] URLByAppendingPathComponent:IMAGE_ORIGINAL_DIRECTORY_NAME];
}
+(NSURL *)imageThumbnailDocumentDirectory{
    return [[OADocumentManager imageDocumentDirectory] URLByAppendingPathComponent:IMAGE_THUMBNAIL_DIRECTORY_NAME];
}

+(NSURL *)imageOriginalPathForImageName:(NSString *)imageName{
    return [[OADocumentManager imageOriginalDocumentDirectory] URLByAppendingPathComponent:imageName];
}
+(NSURL *)imageThumbnailPathForImageName:(NSString *)imageName{
    return [[OADocumentManager imageThumbnailDocumentDirectory] URLByAppendingPathComponent:imageName];
}

+(void)createImageDirectorys{
    [OADocumentManager createDirectoryForPath:[OADocumentManager imageOriginalDocumentDirectory]];
    [OADocumentManager createDirectoryForPath:[OADocumentManager imageThumbnailDocumentDirectory]];
}

+(BOOL)saveImage:(UIImage *)image forImgeName:(NSString *)imageName{
    if (![OADocumentManager existDirectoryForPath:[OADocumentManager imageDocumentDirectory]]) {
        [OADocumentManager createImageDirectorys];
    }

    BOOL isSuccess = NO;
    BOOL isSavedOrginalImage = [OADocumentManager saveOriginalImage:image forImgeName:imageName];
    if (isSavedOrginalImage) {
        isSuccess = [OADocumentManager saveThumbnailImage:image forImgeName:imageName];
    }

    return isSuccess;
}

+(BOOL)saveOriginalImage:(UIImage *)image forImgeName:(NSString *)imageName{
    NSData * imageData = UIImageJPEGRepresentation(image, 1.0);
    NSURL * imageURLPath = [OADocumentManager imageOriginalPathForImageName:imageName];
    NSError * error;
    BOOL isSuccess = [imageData writeToURL:imageURLPath options:NSDataWritingAtomic error:&error];
    if (!isSuccess) {
        NSLog(@"save original image error : %@",error.localizedDescription);
    }
    return isSuccess;

}

+(BOOL)saveThumbnailImage:(UIImage *)image forImgeName:(NSString *)imageName{

    UIImage * thumbnailImage = [OADocumentManager thumbnailImageFromImage:image];
    NSData * imageData = UIImageJPEGRepresentation(thumbnailImage, 1);
    NSURL * imageURLPath = [OADocumentManager imageThumbnailPathForImageName:imageName];
    NSError * error;
    BOOL isSuccess = [imageData writeToURL:imageURLPath options:NSDataWritingAtomic error:&error];
    if (!isSuccess) {
        NSLog(@"save Thumbnail image error : %@",error.localizedDescription);
    }
    return isSuccess;
}

+(UIImage *)thumbnailImageFromImage:(UIImage *)image{
    CGFloat imageScale = 0.25;
    UIGraphicsBeginImageContextWithOptions(image.size, YES, imageScale);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    UIImage * thumbnailImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnailImage;
}

+(UIImage *)imageOriginalImageForImagename:(NSString *)imageName{
    NSURL * imageURLPath = [OADocumentManager imageOriginalPathForImageName:imageName];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURLPath];
    UIImage * originalImage = [UIImage imageWithData:imageData];
    return originalImage;
}
+(UIImage *)imageThumbnailImageForImagename:(NSString *)imageName{
    NSURL * imageURLPath = [OADocumentManager imageThumbnailPathForImageName:imageName];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURLPath];
    UIImage * thumbnailImage = [UIImage imageWithData:imageData];
    return thumbnailImage;
}


@end
