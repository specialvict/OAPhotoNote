//
//  OAPhotoNotebookCollectionViewController.m
//  OAPhotoNote
//
//  Created by lee on 2015/5/17.
//  Copyright (c) 2015年 Lee Chung-Yun. All rights reserved.
//

#import "OAPhotoNotebookCollectionViewController.h"
#import "OAPhotoNoteCollectionViewCell.h"
#import "PhotoNote.h"
#import "OADocumentManager.h"

#define OACollectionCellInterItemSpace (0.0f)
#define OACollectionViewSectionInset UIEdgeInsetsMake(8, 10, 8, 10)
#define OACellWidth (self.view.frame.size.width - 4 * OACollectionCellInterItemSpace)/2

@interface OAPhotoNotebookCollectionViewController ()<NSFetchedResultsControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) NSFetchedResultsController * fetchedResultsController;
@end

@implementation OAPhotoNotebookCollectionViewController{
    PhotoNote * newPhotoNote;
    NSMutableArray * _sectionChanges;
    NSMutableArray * _itemChanges;
}

static NSString * const reuseIdentifier = @"PhotoNoteCell";

- (void)viewDidLoad {
    [super viewDidLoad];


    UIBarButtonItem * cameraButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto:)];
    self.navigationItem.rightBarButtonItem = cameraButton;

    NSError *error;
    if (![[self fetchedResultsController] performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.

         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    // Do any additional setup after loading the view.
}

-(void)dealloc{
    NSLog(@"%@ -- dealloc",self);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)takePhoto:(id)sender{
    UIImagePickerController * imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self presentViewController:imagePicker animated:YES completion:^{

        }];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

//    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    

    // Handle a still image capture

        // Get the image metadata
        UIImagePickerControllerSourceType pickerType = picker.sourceType;
        if(pickerType == UIImagePickerControllerSourceTypeCamera)
        {
            NSDictionary *imageMetadata = [info objectForKey:
                                           UIImagePickerControllerMediaMetadata];
            NSLog(@"image meta data:%@",imageMetadata);
            newPhotoNote = [NSEntityDescription insertNewObjectForEntityForName:@"PhotoNote" inManagedObjectContext:self.photoNotebook.managedObjectContext];
            newPhotoNote.name = @"test";
            [self.photoNotebook addPhotoNotesObject:newPhotoNote];
            NSString * imageName = [self imageNameForPhoto];
            if ([OADocumentManager saveImage:image forImgeName:imageName]) {
                newPhotoNote.imageName = imageName;
            } else {
                NSLog(@"save image error");
            }
        }

    [self dismissViewControllerAnimated:YES completion:nil];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSString *)imageNameForPhoto{
    NSDate * now = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString * imageName = [NSString stringWithFormat:@"%@imageWithDate%@",self.photoNotebook.name,[formatter stringFromDate:now]];
    return imageName;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OAPhotoNoteCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    PhotoNote * photoNote = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UIImage * photoImage = [OADocumentManager imageThumbnailImageForImagename:photoNote.imageName];
    cell.noteImageView.image = photoImage;
    cell.backgroundColor = [UIColor blackColor];

    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return OACollectionViewSectionInset;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return OACollectionCellInterItemSpace;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.collectionView.frame.size.width/5, self.collectionView.frame.size.width/5 );
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

#pragma mark - Fetched results controller

/*
 Returns the fetched results controller. Creates and configures the controller if necessary.
 */
- (NSFetchedResultsController *)fetchedResultsController {

    if (_fetchedResultsController != nil) {
        NSLog(@"fetched Objects %@",_fetchedResultsController.fetchedObjects);
        return _fetchedResultsController;
    }

    // Create and configure a fetch request with the Book entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"PhotoNote" inManagedObjectContext:self.photoNotebook.managedObjectContext];
    [fetchRequest setEntity:entity];

    // Create the sort descriptors array.
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];

    NSPredicate * notebookPredicate = [NSPredicate predicateWithFormat:@"(photoNotebook == %@)",self.photoNotebook];
    [NSFetchedResultsController deleteCacheWithName:@"Note"];
    [fetchRequest setPredicate:notebookPredicate];

    // Create and initialize the fetch results controller.
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.photoNotebook.managedObjectContext sectionNameKeyPath:nil cacheName:@"Note"];
    _fetchedResultsController.delegate = self;

    NSError * error;
    NSArray * fetchedArray = [self.photoNotebook.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"%@",error.localizedDescription);
    } else {
        NSLog(@"array : %@",fetchedArray);
    }

    return _fetchedResultsController;
}

/*
 NSFetchedResultsController delegate methods to respond to additions, removals and so on.
 */
#pragma mark - Fetched results controller

/*
 NSFetchedResultsController delegate methods to respond to additions, removals and so on.
 */
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {

    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    //    [self.tableView beginUpdates];
    //    [self.collectionView reloadData];
    _sectionChanges = [[NSMutableArray alloc] init];
    _itemChanges = [[NSMutableArray alloc] init];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

    ////    UITableView *tableView = self.tableView;
    //
    //    switch(type) {
    //
    //        case NSFetchedResultsChangeInsert:
    ////            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    ////            [self.collectionView reloadItemsAtIndexPaths:@[newIndexPath]];
    //            break;
    //
    //        case NSFetchedResultsChangeDelete:
    ////            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //            break;
    //
    //        case NSFetchedResultsChangeUpdate:
    ////            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
    //            break;
    //
    //        case NSFetchedResultsChangeMove:
    ////            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    ////            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //            break;
    //    }
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            change[@(type)] = newIndexPath;
            break;
        case NSFetchedResultsChangeDelete:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeUpdate:
            change[@(type)] = indexPath;
            break;
        case NSFetchedResultsChangeMove:
            change[@(type)] = @[indexPath, newIndexPath];
            break;
    }
    [_itemChanges addObject:change];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    //    switch(type) {
    //
    //        case NSFetchedResultsChangeInsert:
    ////            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    //            break;
    //
    //        case NSFetchedResultsChangeDelete:
    ////            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
    //            break;
    //    }
    NSMutableDictionary *change = [[NSMutableDictionary alloc] init];
    change[@(type)] = @(sectionIndex);
    [_sectionChanges addObject:change];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {

    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    //    [self.tableView endUpdates];
    [self.collectionView performBatchUpdates:^{
        for (NSDictionary *change in _sectionChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:[obj unsignedIntegerValue]]];
                        break;
                }
            }];
        }
        for (NSDictionary *change in _itemChanges) {
            [change enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
                NSFetchedResultsChangeType type = [key unsignedIntegerValue];
                switch(type) {
                    case NSFetchedResultsChangeInsert:
                        [self.collectionView insertItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeDelete:
                        [self.collectionView deleteItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeUpdate:
                        [self.collectionView reloadItemsAtIndexPaths:@[obj]];
                        break;
                    case NSFetchedResultsChangeMove:
                        [self.collectionView moveItemAtIndexPath:obj[0] toIndexPath:obj[1]];
                        break;
                }
            }];
        }
    } completion:^(BOOL finished) {
        _sectionChanges = nil;
        _itemChanges = nil;
    }];
}


@end
